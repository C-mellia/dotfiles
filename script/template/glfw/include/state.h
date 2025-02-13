#ifndef STATE_H
#define STATE_H 1

#include <types.h>
#include <vec.h>
#include <camera.h>

extern struct gl_state {
    GLFWwindow *main;
    i32 width, height;
    i32 viewport[4];

    vec2 mouse, mouse_off, scroll;

    f32 time, dt;

    struct obj {
        vec3 pos;
        f32 ang_vel, ang;
    } obj;

    Camera cam;
    f32 fov_ang;
} gl_state;

int state_init(int argc, char **argv);
void state_cleanup(void);

#endif // STATE_H
