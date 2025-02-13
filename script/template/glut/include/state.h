#ifndef STATE_H
#define STATE_H 1

#include <types.h>
#include <vec.h>

extern struct gl_state {
    u32 width, height;
    i32 viewport[4];

    i32 active;
    vec2 mouse;

    f32 time, dt;

    struct obj {
        vec3 pos;
        f32 ang_vel, ang;
    } obj;

    vec3 pos;
    f32 fov_ang;
} gl_state;

void state_init(int argc, char **argv);
void state_cleanup(void);

#endif // STATE_H
