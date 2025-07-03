#ifndef COMMON_CAMERA_H
#define COMMON_CAMERA_H 1

#include <linalg/vec.h>
#include <linalg/mat.h>
#include <array/array.h>

#include <common/types.h>
#include <common/object.h>

typedef struct camera {
  struct obj __obj;

  vec3 up;

  // zoom accel, vel, level
  f32
  focus, zoom_vel,
  zoom, fov;

  f32 speed, sense;
} *Camera;

int cam_init(Camera cam, vec3 pos, vec3 ypr, f32 fov, f32 speed, f32 sense);
Camera cam_new(vec3 pos, vec3 ypr, f32 fov, f32 speed, f32 sense);
void cam_cleanup(Camera cam);
void *cam_drop(Camera *cam);

int cam_dbg_fmt(Arr fmt, Camera cam);

static inline Obj cam_get_obj(Camera cam) { return cam? &cam->__obj: nullptr; }
f32 cam_yaw(Camera cam);
f32 cam_pitch(Camera cam);
f32 cam_roll(Camera cam);

void cam_reset(Camera cam);
void cam_reset_zoom(Camera cam);
void cam_reset_ypr(Camera cam);
void cam_reset_pos(Camera cam);
/*
 * wants: { right, up, dir }
 * pos += mat3(right, up, dir) * wants * speed
 */
void cam_move(Camera cam, vec3 wants);
void cam_rotate(Camera cam, vec3 ypr);
/*
 * cur_zoom *= BASE_ZOOM^zoom_rate
 */
void cam_zoom(Camera cam, f32 zoom);
mat4 cam_lookat(Camera cam);
mat3 cam_world(Camera cam);

int cam_update_zoom(Camera cam, f32 zoom, f32 dt);

#endif // COMMON_CAMERA_H
