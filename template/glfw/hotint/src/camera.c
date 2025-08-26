#include <stdlib.h>
#include <string.h>

#include <linalg/mat_ext.h>

#include <common/macros.h>
#include <common/camera.h>
#include <common/object.h>
#include <common/consts.h>

int cam_init(Camera cam, vec3 pos, vec3 ypr, f32 fov, f32 speed, f32 sense) {
  if (!cam) return -1;
  $(obj_init(&cam->__obj, pos, ypr,
             0.8, vec3_zero,
             MESH_NONE));

  cam->__obj.program = cam->__obj.texture = 0;

  cam->up = vec3_new(0.0, 1.0, 0.0);
  cam->speed = speed, cam->sense = sense;
  cam->focus = 0.0, cam->zoom_vel = 0.0;
  cam->zoom = 1.0, cam->fov = fov;

  return 0;
}

Camera cam_new(vec3 pos, vec3 ypr, f32 fov, f32 speed, f32 sense) {
  Camera cam = malloc(sizeof *cam);
  if (!cam) return (void *)0;
  memset(cam, 0, sizeof *cam);
  if (cam_init(
    cam, ypr, pos, fov, speed, sense
  ) == -1) return free(cam), (void *)0;
  return cam;
}

void cam_cleanup(Camera cam) {
  if (!cam) return;
}

void *cam_drop(Camera *cam) {
  if (cam) cam_cleanup(*cam), free(*cam), *cam = 0;
  return 0;
}

int cam_dbg_fmt(Arr fmt, Camera cam) {
  if (!fmt) return -1;
  if (!cam) return arr_printf(fmt, "(nil)");
  int len = 0;

  len += $(arr_printf(fmt, "{obj: "));
  len += $(obj_dbg_fmt(fmt, &cam->__obj));
  len += $(arr_printf(fmt, ", up: "));
  len += $(vec3_dbg_fmt(fmt, cam->up));
  len += $(arr_printf(fmt, ", speed: %f, sense: %f}",
                      cam->speed, cam->sense));

  return len;
}

f32 cam_yaw(Camera cam) {
  if (!cam) return 0.0;
  return obj_yaw(&cam->__obj);
}

f32 cam_pitch(Camera cam) {
  if (!cam) return 0.0;
  return obj_pitch(&cam->__obj);
}

f32 cam_roll(Camera cam) {
  if (!cam) return 0.0;
  return obj_roll(&cam->__obj);
}

void cam_reset(Camera cam) {
  if (!cam) return;
  cam_reset_ypr(cam), cam_reset_pos(cam), cam_reset_zoom(cam);
}

void cam_reset_zoom(Camera cam) {
  if (!cam) return;
  cam->zoom = 1.0, cam->zoom_vel = cam->focus = 0.0;
}

void cam_reset_ypr(Camera cam) {
  if (!cam) return;
  obj_reset_ypr(&cam->__obj);
}

void cam_reset_pos(Camera cam) {
  if (!cam) return;
  obj_reset_pos(&cam->__obj);
}

void cam_move(Camera cam, vec3 wants) {
  if (!cam) return;

  Obj obj = cam_get_obj(cam);
  mat3 dir_mat = cam_world(cam);
  dir_mat.b = cam->up;

  vec3 force = vec3_add(
    vec3_scale(
      mat3_mult_vec(mat3_transpose(dir_mat), vec3_normalize(wants)),
      cam->speed * BASE_SPEED
    ),
    obj_vel_damp(obj)
  );

  obj_apply(cam_get_obj(cam), force, vec3_zero);
  // obj_update_pos(obj, force, dt);
}

void cam_rotate(Camera cam, vec3 ypr) {
  if (!cam) return;

  Obj obj = cam_get_obj(cam);
  vec3 torque = vec3_add(
    vec3_scale(ypr, cam->sense * BASE_SENSE),
    obj_ypr_vel_damp(obj)
  );

  obj_apply(cam_get_obj(cam), vec3_zero, torque);
  // obj_update_ypr(obj, torque, dt);
  // obj->ypr = cam_ypr_check_bound(obj->ypr);
}

void cam_zoom(Camera cam, f32 zoom) {
  if (!cam) return;
  zoom = zoom * cam->sense * BASE_ZOOM - cam->zoom_vel * ZOOM_DAMPING;
  cam->focus += zoom;
}

mat4 cam_lookat(Camera cam) {
  if (!cam) return mat4_unit;
  Obj obj = &cam->__obj;
  return mat4_lookat_rad(obj->pos, obj->ypr);
}

mat3 cam_world(Camera cam) {
  if (!cam) return mat3_unit;

  Obj obj = &cam->__obj;
  mat3 ypr_mat = mat3_take_mat4(
    mat4_ypr_rad(obj->ypr), 0
  );

  ypr_mat.a = vec3_normalize(vec3_sub(
    ypr_mat.a, vec3_project(ypr_mat.a, cam->up)
  ));

  ypr_mat.b = vec3_normalize(vec3_sub(
    ypr_mat.b, vec3_project(ypr_mat.b, cam->up)
  ));

  ypr_mat.c = vec3_normalize(vec3_sub(
    ypr_mat.c, vec3_project(ypr_mat.c, cam->up)
  ));

  return ypr_mat;
}

int cam_update_zoom(Camera cam, f32 focus, f32 dt) {
  if (!cam) return -1;
  cam->zoom_vel += focus * dt;
  cam->zoom *= powf(10.0, cam->zoom_vel * dt);

  const f32 MAX_ZOOM = MAX_FOV / cam->fov;

  cam->zoom = cam->zoom > MAX_ZOOM
    ? MAX_ZOOM
    : cam->zoom < 1e-1
    ? 1e-1
    : cam->zoom;

  return 0;
}
