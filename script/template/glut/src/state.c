#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#include <GL/glut.h>

#include <state.h>
#include <macros.h>
#include <consts.h>
#include <resource.h>

struct gl_state gl_state = {
    .width = 0, .height = 0,
    .viewport = {0},

    .active = -1,
    .mouse = { 0.0, 0.0 },
    .time = 0.0, .dt = 0.0,

    .obj = {
        .pos = { 0.0, 0.0, -10.0 },
        .ang_vel = 45.0,
        .ang = 0.0,
    },

    .pos = { 0.0, 0.0, 0.0 },

    .fov_ang = 100.0,
};

static inline void signal_callback(int sig);

void state_init(int argc, char **argv) {
    (void)argc, (void)argv;
    gl_state.width = INIT_WIDTH, gl_state.height = INIT_HEIGHT;

    glEnable(GL_DEPTH_TEST);

    signal(SIGSEGV, signal_callback);
    signal(SIGTERM, signal_callback);
    signal(SIGKILL, signal_callback);
    signal(SIGINT, signal_callback);

    if (make_resource() == -1) {
        loginfo("error", "Failed to load resources\n");
        exit(1);
    }

    gl_state.time = glutGet(GLUT_ELAPSED_TIME);
}

void state_cleanup(void) {
    free_resource();
    loginfo("info", "Successfully freed resources\n");
}

static void signal_callback(int sig) {
    switch(sig) {
        case SIGSEGV:
        case SIGTERM:
        case SIGKILL:
        case SIGINT: {
            exit(sig);
        } break;

        default:;
    }
}
