#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include <mat.h>
#include <mat_ext.h>
#include <array.h>

#include <macros.h>
#include <state.h>
#include <resource.h>
#include <impl.h>

/*
 * handle_*: processing continuous pressing events
 * *_callback: handle one-time *press* or *release* events
 *
 * handle different keys in different type of handlers in case of conflicts
 */

static inline __attribute__((unused))
void handle_display(void);
static inline __attribute__((unused))
void handle_reshape(void);
static inline __attribute__((unused))
void handle_idle(void);
static inline __attribute__((unused))
void handle_keys(void);
static inline __attribute__((unused))
void handle_mouse(void);

static inline __attribute__((unused))
void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods);
static inline __attribute__((unused))
void cursor_pos_callback(GLFWwindow *window, double xpos, double ypos);
static inline __attribute__((unused))
void scroll_callback(GLFWwindow *window, double xoff, double yoff);

void update(void) {
    handle_reshape(), handle_keys(), handle_mouse();

    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    handle_display();
    glfwSwapBuffers(gl_state.main);
    glfwPollEvents();

    handle_idle();
}

void callbacks(void) {
    glfwSetKeyCallback(gl_state.main, key_callback);
    glfwSetScrollCallback(gl_state.main, scroll_callback);
    glfwSetCursorPosCallback(gl_state.main, cursor_pos_callback);
}

static void handle_display(void) {
#define set_matrix(id)\
    glUniformMatrix4fv(resource.attrib.id, 1, GL_TRUE, (void *)&id)

    glUseProgram(resource.def_prog);

    {
        if (!gl_state.height) exit(1);

        vec3 pos = gl_state.obj.pos;
        Camera cam = gl_state.cam;

        f32
        fov_ang = gl_state.fov_ang,
        ratio = (f32)gl_state.width / (f32)gl_state.height,
        near = 0.1f, far = 100.0f;

        mat4
        model = mat4_prod(
            2,
            mat4_rotate_ang(vec3_new(1.0, 1.0, 0.0), gl_state.obj.ang),
            mat4_translate(pos.x, pos.y, pos.z)
        ),
        view = mat4_lookat_ang(cam->pos, cam->ypr),
        projection = mat4_perspective(fov_ang, ratio, near, far);

        set_matrix(model), set_matrix(view), set_matrix(projection);
    }

    glBindVertexArray(resource.cube.vert_arr);
    glDrawArrays(GL_TRIANGLES, 0, 36);
}
#undef set_matrix

static void handle_idle(void) {
    f32 time = glfwGetTime();
    gl_state.dt = time - gl_state.time, gl_state.time = time;

    gl_state.obj.ang += gl_state.obj.ang_vel * gl_state.dt;
    gl_state.obj.ang = gl_state.obj.ang > 360.0? gl_state.obj.ang - 360.0: gl_state.obj.ang;
}

static void handle_keys(void) {
}

static void handle_mouse(void) {
}

static void handle_reshape(void) {
    glfwGetWindowSize(gl_state.main, &gl_state.width, &gl_state.height);
    glViewport(0, 0, gl_state.width, gl_state.height);
    glGetIntegerv(GL_VIEWPORT, gl_state.viewport);
}

static void key_callback(GLFWwindow *window, int key, int scancode, int action, int mods) {
    (void)window, (void)scancode, (void)action, (void)mods;
    switch(key) {
        case GLFW_KEY_Q:
        case GLFW_KEY_ESCAPE: {
            glfwSetWindowShouldClose(gl_state.main, GLFW_TRUE);
        } break;

        case GLFW_KEY_L: {
            if (action == GLFW_PRESS) {
                loginfo("info", "time: %f, dt: %f\n", gl_state.time, gl_state.dt);
                loginfo("info", "width: %d, height: %d\n", gl_state.width, gl_state.height);
                loginfo("info", "mouse_x: %f, mouse_y: %f\n", gl_state.mouse.x, gl_state.mouse.y);
            }
        } break;

        case GLFW_KEY_R: {
            if (action == GLFW_PRESS) {
                cam_reset_ypr(gl_state.cam), cam_reset_pos(gl_state.cam);
            }
        } break;

        default:;
    }
}

static void cursor_pos_callback(GLFWwindow *window, double xpos, double ypos) {
    (void)window;
    gl_state.mouse_off = vec2_new(
        xpos - gl_state.mouse.x,
        ypos - gl_state.mouse.y
    ), gl_state.mouse = vec2_new(xpos, ypos);

    if (glfwGetMouseButton(gl_state.main, GLFW_MOUSE_BUTTON_1) == GLFW_PRESS) {
        // loginfo("info", "button 1\n");
        cam_rotate(gl_state.cam, gl_state.mouse_off.x, gl_state.mouse_off.y, 0.0);
    }
}

static void scroll_callback(GLFWwindow *window, double xoff, double yoff) {
    (void)window;
    gl_state.scroll = vec2_new(xoff, yoff);
}
