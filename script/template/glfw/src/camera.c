#include <stdlib.h>
#include <string.h>

#include <mat_ext.h>

#include <camera.h>

/*
 * yaw in [-180, 180]
 * pitch in [-89, 89]
 * roll in [0, 360]
 */
static inline __attribute__((unused))
vec3 ypr_check_bound(vec3 ypr);
static inline __attribute__((unused))
mat3 cam_ortho(Camera cam);

int cam_init(Camera cam, vec3 ypr, vec3 pos, f32 speed, f32 sense) {
    if (!cam) return -1;
    cam->ypr = ypr, cam->pos = pos;
    cam->speed = speed, cam->sense = sense;
    return 0;
}

Camera cam_new(vec3 ypr, vec3 pos, f32 speed, f32 sense) {
    Camera cam = malloc(sizeof *cam);
    if (!cam) return (void *)0;
    memset(cam, 0, sizeof *cam);
    if (cam_init(cam, ypr, pos, speed, sense) == -1) return (void *)0;
    return cam;
}

void cam_cleanup(Camera cam) {
    if (!cam) return;
}

void *cam_drop(Camera *cam) {
    if (cam) cam_cleanup(*cam), free(*cam), *cam = 0;
    return 0;
}

f32 cam_yaw(Camera cam) {
    if (!cam) return 0.0;
    return cam->ypr.x;
}

f32 cam_pitch(Camera cam) {
    if (!cam) return 0.0;
    return cam->ypr.y;
}

f32 cam_roll(Camera cam) {
    if (!cam) return 0.0;
    return cam->ypr.z;
}

void cam_reset_ypr(Camera cam) {
    cam->ypr = vec3_zero;
}

void cam_reset_pos(Camera cam) {
    cam->pos = vec3_zero;
}

void cam_move(Camera cam, vec3 wants) {
    cam->pos = vec3_add(
        cam->pos,
        vec3_scale(
            mat3_mult_vec(mat3_transpose(cam_ortho(cam)), wants),
            cam->speed
        )
    );
}

void cam_rotate(Camera cam, f32 yaw, f32 pitch, f32 roll) {
    vec3 ypr = vec3_scale(vec3_new(yaw, pitch, roll), cam->sense);
    cam->ypr = vec3_add(cam->ypr, ypr);
    cam->ypr = ypr_check_bound(cam->ypr);
}

static vec3 ypr_check_bound(vec3 ypr) {
    return vec3_new(
        ypr.x < -180.0? ypr.x + 360.0: ypr.x > 180.0? ypr.x - 360.0: ypr.x,
        ypr.y < -89.0? -89.0: ypr.y > 89.0? 89.0: ypr.y,
        ypr.z < 0? ypr.z + 360.0: ypr.z > 360.0? ypr.z - 360.0: ypr.z
    );
}

static mat3 cam_ortho(Camera cam) {
    return mat3_take_mat4(
        mat4_ypr_ang(cam->ypr), 0
    );
}

