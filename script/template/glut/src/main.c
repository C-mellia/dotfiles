#include <stdio.h>

#include <GL/glew.h>
#include <GL/glut.h>

#include <consts.h>
#include <state.h>
#include <impl.h>
#include <macros.h>

static __attribute__((destructor))
void __cleanup(void);

int main(int argc, char **argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
    glutInitWindowSize(INIT_WIDTH, INIT_HEIGHT);
    glutCreateWindow(TITLE);

    glewInit();

    state_init(argc, argv);

    glutDisplayFunc(display_callback);
    glutIdleFunc(idle_callback);
    glutReshapeFunc(reshape_callback);
    glutKeyboardFunc(key_callback);
    glutSpecialFunc(special_key_callback);
    glutMouseFunc(mouse_callback);
    glutMotionFunc(motion_callback);
    glutPassiveMotionFunc(passive_motion_callback);
    glutVisibilityFunc(visibility_callback);
    glutEntryFunc(entry_callback);

    loginfo("info", "All set\n"), glutMainLoop();

    return 0;
}

static void __cleanup(void) {
    state_cleanup();
}
