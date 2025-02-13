#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include <GL/glew.h>
#include <GL/glut.h>

#include <mat.h>
#include <mat_ext.h>
#include <array.h>

#include <macros.h>
#include <state.h>
#include <resource.h>
#include <impl.h>

static void render(void);
static void overlay(void);

void reshape_callback(int width, int height) {
    gl_state.width = width, gl_state.height = height;
    glViewport(0, 0, width, height);
    glGetIntegerv(GL_VIEWPORT, gl_state.viewport);
}

void display_callback(void) {
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    render(), overlay();

    glutSwapBuffers();
}

void mouse_callback(int button, int state, int x, int y) {
    if (state == GLUT_DOWN) {
        gl_state.active = button;
    } else {
        gl_state.active = -1;
    }

    gl_state.mouse = vec2_new(x, y);
}

void key_callback(uint8_t key, int x, int y) {
    switch(key) {
        case 'q':
        case 'Q':
        case ESC: {
            exit(0);
        } break;

        case 'R':
        case 'r': {
            (void)"reload";
        }

        default:;
    }

    gl_state.mouse = vec2_new(x, y);
}

void special_key_callback(int key, int x, int y) {
    (void)key;

    gl_state.mouse = vec2_new(x, y);
}

void motion_callback(int x, int y) {
    gl_state.mouse = vec2_new(x, y);
}

void passive_motion_callback(int x, int y) {
    gl_state.mouse = vec2_new(x, y);
}

void visibility_callback(int state) {
    (void)state;
}

void entry_callback(int state) {
    (void)state;
}

void idle_callback(void) {
    f32 time = glutGet(GLUT_ELAPSED_TIME);
    gl_state.dt = time - gl_state.time, gl_state.time = time;

    gl_state.obj.ang += gl_state.obj.ang_vel * gl_state.dt / 1000.f;
    gl_state.obj.ang = gl_state.obj.ang > 360.0? gl_state.obj.ang - 360.0: gl_state.obj.ang;

    glutPostRedisplay();
}

static void render() {
#define set_matrix(id)\
    glUniformMatrix4fv(resource.attrib.id, 1, GL_TRUE, (void *)&id)

    glUseProgram(resource.def_prog);

    {
        if (!gl_state.height) exit(1);

        vec3
        pos = gl_state.obj.pos,
        cam_pos = gl_state.pos;

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
        view = mat4_translate(cam_pos.x, cam_pos.y, cam_pos.z),
        projection = mat4_perspective(fov_ang, ratio, near, far);

        set_matrix(model), set_matrix(view), set_matrix(projection);
    }

    glBindVertexArray(resource.cube.vert_arr);
    glDrawArrays(GL_TRIANGLES, 0, 36);
}
#undef set_matrix

static void overlay(void) {
}
