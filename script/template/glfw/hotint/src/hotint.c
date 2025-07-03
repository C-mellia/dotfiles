#include <stdio.h>
#include <stdlib.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <dlfcn.h>

#include <linalg/vec.h>
#include <linalg/mat.h>
#include <linalg/mat_ext.h>

#include <common/app_state.h>
#include <common/macros.h>
#include <common/physics.h>
#include <common/consts.h>

#include <hotint.h>

AppState _app_state = nullptr;
static inline void callbacks(void);
static inline int handle_display(obj_display_t _obj_display);
static inline int handle_reshape(void);
static inline int handle_keys(void);
static inline int handle_mouse(void);
static inline int handle_idle(f32 dt);

static inline Obj objs_add_proto_cube(Resource resource,
                                      vec3 pos, f32 mass, vec3 scale);

static inline void key_callback(
  GLFWwindow *window,
  int key,
  int scancode,
  int action,
  int mods);
static inline void cursor_pos_callback(
  GLFWwindow *window,
  double xpos,
  double ypos);
static inline void scroll_callback(
  GLFWwindow *window,
  double xoff,
  double yoff);

static inline int app_state_post_init(AppState app_state) {
  Camera cam = &app_state->cam;
  Obj cam_obj = cam_get_obj(cam);
  Arr obj_refs = &app_state->obj_refs;
  Resource resource = &app_state->resource;

  if (cam_init(
    cam, INIT_POS,
    vec3_new(INIT_YAW, INIT_PITCH, INIT_ROLL),
    INIT_FOV, INIT_SPEED, INIT_SENSE
  ) == -1) {
    error("Failed to initialize internal camera object");
    return -1;
  }

  if (!arr_pushback(obj_refs, &cam_obj, 1)) {
    error("Failed to push camera base object model to objects array");
    return -1;
  }

  { // a cool spinning cube
    Obj proto_cube = objs_add_proto_cube(
      resource,
      vec3_new(0.0, 0.0, -5.0), 1.0,
      vec3_one
    );
    if (proto_cube == nullptr) return -1;

    proto_cube->ypr_vel = vec3_scale((vec3){ 30.0, 30.0, 0.0 }, RAD);
    if (arr_pushback(&app_state->obj_refs, &proto_cube, 1) == nullptr) return -1;
  }

  return 0;
}

static inline void app_state_post_cleanup(AppState app_state) {
  cam_cleanup(&app_state->cam);
}

int _update(f32 dt) {
  // dbg("%f", _app_state->zoom);
  if (!_app_state
    || handle_reshape() == -1
    || handle_keys() == -1
    || handle_mouse() == -1
    || handle_idle(dt) == -1) return -1;

  return 0;
}

int _on_load(AppState app_state) {
  if (app_state_post_init(app_state) == -1) return -1;

  _app_state = app_state;
  callbacks();
  loginfo("info", "hotint loaded successfully!");

  return 0;
}

void _on_unload(void) {
  app_state_post_cleanup(_app_state);
  _app_state = nullptr;
  loginfo("info", "hotint unloaded.");
}

int _render(obj_display_t _obj_display) {
  if (!_app_state || !_obj_display
    || handle_display(_obj_display) == -1) return -1;
  return 0;
}

void _on_reload(AppState app_state) {
  _app_state = app_state;
  callbacks();
  loginfo("info", "hotint reloaded successfully!");
}

struct hotint load_hotint(void) {
  return (struct hotint) {
    .update = _update,
    .render = _render,
    .on_load = _on_load,
    .on_reload = _on_reload,
    .on_unload = _on_unload,
  };
}

static inline void callbacks(void) {
  loginfo("info", "setting callbacks");
  glfwSetKeyCallback(_app_state->main, key_callback);
  glfwSetScrollCallback(_app_state->main, scroll_callback);
  glfwSetCursorPosCallback(_app_state->main, cursor_pos_callback);
}

static int handle_display(obj_display_t _obj_display) {
  if (!_obj_display || !_app_state->height) return -1;

  Arr obj_refs = &_app_state->obj_refs;
  for (size_t i = 0; i < arr_len(obj_refs); ++i) {
    Obj *obj_p = arr_get(obj_refs, i);
    if (!obj_p || !*obj_p) continue;

    if (_obj_display(
      _app_state, *obj_p, obj_model, cam_lookat
    ) == -1) return -1;
  }

  return 0;
}

static int handle_idle(f32 dt) {
  Arr objs = &_app_state->obj_refs;
  Camera cam = &_app_state->cam;

  cam_move(cam, _app_state->wants);
  cam_rotate(cam, _app_state->ypr);
  cam_zoom(cam, _app_state->zoom);

  if (objs_update(objs, dt) == -1) return -1;
  if (cam_update_zoom(cam, cam->focus, dt) == -1) return -1;
  cam->focus = 0.0;

  _app_state->ypr = _app_state->wants = vec3_zero;
  _app_state->zoom = 0;

  return 0;
}

static int handle_keys(void) {
  if (!_app_state->main) return -1;

  if (glfwGetKey(_app_state->main, GLFW_KEY_Q) == GLFW_PRESS) {
    _app_state->ypr.z -= 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_E) == GLFW_PRESS) {
    _app_state->ypr.z += 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_W) == GLFW_PRESS) {
    _app_state->wants.z -= 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_A) == GLFW_PRESS) {
    _app_state->wants.x -= 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_S) == GLFW_PRESS) {
    _app_state->wants.z += 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_D) == GLFW_PRESS) {
    _app_state->wants.x += 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_SPACE) == GLFW_PRESS) {
    _app_state->wants.y += 1;
  }

  if (glfwGetKey(_app_state->main, GLFW_KEY_LEFT_CONTROL) == GLFW_PRESS) {
    _app_state->wants.y -= 1;
  }

  return 0;
}

static int handle_mouse(void) {
  if (glfwGetMouseButton(_app_state->main, GLFW_MOUSE_BUTTON_5) == GLFW_PRESS) {
    _app_state->zoom += -1.0;
  }

  if (glfwGetMouseButton(_app_state->main, GLFW_MOUSE_BUTTON_4) == GLFW_PRESS) {
    _app_state->zoom += 1.0;
  }

  return 0;
}

static int handle_reshape(void) {
  if (!_app_state->main) return -1;
  glfwGetWindowSize(_app_state->main, &_app_state->width, &_app_state->height);
  glViewport(0, 0, _app_state->width, _app_state->height);
  glGetIntegerv(GL_VIEWPORT, _app_state->viewport);
  return 0;
}

static void key_callback(GLFWwindow *window,
                         int key,
                         int scancode,
                         int action,
                         int mods) {
  (void)window, (void)scancode, (void)action, (void)mods;
  Camera cam = &_app_state->cam;

  switch(key) {
    case GLFW_KEY_ESCAPE: {
      glfwSetWindowShouldClose(window, GLFW_TRUE);
    } break;

    case GLFW_KEY_L: {
      loginfo("info", "action: %d", action);
      if (action == GLFW_PRESS) {
        loginfo("info", "width: %d, height: %d",
                _app_state->width,
                _app_state->height);
        loginfo("info", "mouse_x: %f, mouse_y: %f",
                _app_state->mouse.x,
                _app_state->mouse.y);
        loginfo("info", "camera fov: %f",
                cam->zoom * cam->fov);
      }
    } break;

    case GLFW_KEY_F5: {
      if (action == GLFW_PRESS) {
        _app_state->reload_request = true;
      }
    } break;

    case GLFW_KEY_R: {
      if (action == GLFW_PRESS) {
        loginfo("info", "camera reset.");
        cam_reset(cam);
      }
    } break;

    default:;
  }
}

static void cursor_pos_callback(GLFWwindow *window, double xpos, double ypos) {
  vec2 old_mouse = _app_state->mouse;
  (void)window, (void)old_mouse;
  _app_state->mouse_off = vec2_new(
    xpos - _app_state->mouse.x,
    _app_state->mouse.y - ypos
  ), _app_state->mouse = vec2_new(xpos, ypos);

  if (glfwGetMouseButton(_app_state->main, GLFW_MOUSE_BUTTON_2) == GLFW_PRESS) {
    _app_state->ypr = (vec3){
      _app_state->mouse_off.x,
      _app_state->mouse_off.y,
      0.0,
    };
  }
}

static void scroll_callback(GLFWwindow *window, double xoff, double yoff) {
  (void)window, (void)xoff, (void)yoff;
  // loginfo("info", "%f, %f", xoff, yoff);

  _app_state->zoom -= yoff;
}

static Obj objs_add_proto_cube(Resource resource, vec3 pos, f32 mass, vec3 scale) {
  struct obj _obj = {0};
  if (obj_init(&_obj, pos, vec3_zero, mass, scale, MESH_CUBE) == -1) return nullptr;
  obj_use_prog(&_obj, resource->def_prog);
  obj_use_texture(&_obj, resource->proto_tex);

  return arr_pushback(&resource->objects, &_obj, 1);
}
