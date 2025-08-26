#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <linalg/vec.h>
#include <linalg/mat.h>
#include <linalg/mat_ext.h>

#include <common/macros.h>
#include <common/consts.h>
#include <common/app_state.h>
#include <common/object.h>

static inline int gl_setup(AppState app_state);

int app_state_init(AppState app_state) {
  if (!app_state) {
    error("'app_state' at this point is null! check callee of this function");
    return -1;
  }

  Arr obj_refs = &app_state->obj_refs;
  Resource resource = &app_state->resource;

  if (arr_init(obj_refs, 0, sizeof(Obj)) == -1) {
    error("Failed to initialize internal objects array");
    return -1;
  }

  if (gl_setup(app_state) == -1) {
    error("Failed setup OpenGL contexts");
    return -1;
  }

  if (make_resource(resource) == -1) {
    error("Failed to load resources");
    return -1;
  }

  return 0;
}

void app_state_cleanup(AppState app_state) {
  if (!app_state) return;

  glfwTerminate();

  arr_cleanup(&app_state->obj_refs);
  free_resource(&app_state->resource);
}

int obj_display(AppState app_state,
                Obj obj,
                mat4 (*_obj_model)(Obj obj),
                mat4 (*_cam_lookat)(Camera cam)) {
#define set_matrix(id)\
  glUniformMatrix4fv(resource->attrib.id, 1, GL_TRUE, (void *)&id)

  if (!app_state || !obj) return -1;
  Camera cam = &app_state->cam;
  Resource resource = &app_state->resource;

  const f32
  FOV_ANG = cam->fov * cam->zoom,
  RATIO = (f32)app_state->width / (f32)app_state->height,
  NEAR = 0.1f, FAR = 100.0f;

  mat4
  model = _obj_model(obj),
  view = _cam_lookat(cam),
  projection = mat4_perspective(FOV_ANG, RATIO, NEAR, FAR);

  set_matrix(model);
  set_matrix(view);
  set_matrix(projection);

  if (obj->program && obj->texture && obj->mesh_type != MESH_NONE) {
    glUseProgram(obj->program);
    glBindTexture(GL_TEXTURE_2D, obj->texture);

    glBindVertexArray(resource->cube.vert_arr);
    glDrawArrays(GL_TRIANGLES, 0, 36);
  }

  return 0;
}
#undef set_matrix

static inline int gl_setup(AppState app_state) {
  if (glfwInit() == -1) {
    error("Failed to initialize GLFW context");
    return -1;
  }

  app_state->width = INIT_WIDTH, app_state->height = INIT_HEIGHT;
  glfwWindowHint(GLFW_TRANSPARENT_FRAMEBUFFER, GLFW_TRUE);
  app_state->main = glfwCreateWindow(INIT_WIDTH, INIT_HEIGHT, TITLE, 0, 0);
  if (!app_state->main) return -1;
  glfwMakeContextCurrent(app_state->main);

  if (!gladLoadGLLoader((void *)glfwGetProcAddress)) {
    error("Failed to load OpenGL functions");
    return -1;
  }

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  return 0;
}
