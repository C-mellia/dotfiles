#ifndef CAMERA_H
#define CAMERA_H 1

#include <types.h>
#include <vec.h>
#include <mat.h>

typedef struct camera {
    vec3 ypr, pos;

    f32 speed, sense;
} *Camera;

int cam_init(Camera cam, vec3 ypr, vec3 pos, f32 speed, f32 sense);
Camera cam_new(vec3 ypr, vec3 pos, f32 speed, f32 sense);
void cam_cleanup(Camera cam);
void *cam_drop(Camera *cam);

f32 cam_yaw(Camera cam);
f32 cam_pitch(Camera cam);
f32 cam_roll(Camera cam);

void cam_reset_ypr(Camera cam);
void cam_reset_pos(Camera cam);
/*
 * wants: { right, up, dir }
 * pos += mat3(right, up, dir) * wants * speed
 */
void cam_move(Camera cam, vec3 wants);
void cam_rotate(Camera cam, f32 yaw, f32 pitch, f32 roll);

#endif // CAMERA_H
