#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include <impl.h>
#include <state.h>
#include <macros.h>
#include <consts.h>
#include <resource.h>

struct gl_state gl_state = {
    .width = 0, .height = 0,
    .viewport = {0},

    .time = 0.0, .dt = 0.0,

    .obj = {
        .pos = { 0.0, 0.0, -5.0 },
        .ang_vel = 45.0,
        .ang = 0.0,
    },

    .cam = 0,
    .fov_ang = 100.0,
};

static inline void signal_callback(int sig);

int state_init(int argc, char **argv) {
    (void)argc, (void)argv;
    gl_state.width = INIT_WIDTH, gl_state.height = INIT_HEIGHT;
    gl_state.cam = cam_new(
        vec3_new(INIT_YAW, INIT_PITCH, INIT_ROLL),
        INIT_POS, INIT_SPEED, INIT_SENSE
    );

    if (!glfwInit()) return -1;
    gl_state.main = glfwCreateWindow(INIT_WIDTH, INIT_HEIGHT, TITLE, 0, 0);
    if (!gl_state.main) return -1;
    glfwMakeContextCurrent(gl_state.main);

    glewInit();

    callbacks();

    glEnable(GL_DEPTH_TEST);

    signal(SIGSEGV, signal_callback);
    signal(SIGTERM, signal_callback);
    signal(SIGKILL, signal_callback);
    signal(SIGINT, signal_callback);

    if (make_resource() == -1) {
        loginfo("error", "Failed to load resources\n");
        exit(1);
    }

    gl_state.time = glfwGetTime();
    return 0;
}

void state_cleanup(void) {
    free_resource();
    cam_drop(&gl_state.cam);
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
