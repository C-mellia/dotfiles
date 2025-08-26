#ifndef COMMON_APP_STATE_H
#define COMMON_APP_STATE_H

#include <array/array.h>
#include <linalg/vec.h>

#include <GLFW/glfw3.h>

#include <common/types.h>
#include <common/camera.h>
#include <common/resource.h>

typedef struct app_state {
  GLFWwindow *main;
  i32 width, height;
  i32 viewport[4];

  vec2 mouse, mouse_off;

  struct resource resource;
  struct arr obj_refs;
  struct camera cam;

  vec3 wants, ypr;
  f32 zoom;

  bool reload_request;
} *AppState;

int app_state_init(AppState app_state);
void app_state_cleanup(AppState app_state);

typedef int (*obj_display_t)(AppState app_state,
                             Obj obj,
                             mat4 (*_obj_model)(Obj obj),
                             mat4 (*_cam_lookat)(Camera cam));
int obj_display(AppState app_state,
                Obj obj,
                mat4 (*_obj_model)(Obj obj),
                mat4 (*_cam_lookat)(Camera cam));

#endif // COMMON_APP_STATE_H
