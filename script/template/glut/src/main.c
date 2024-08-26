#include <GL/glut.h>

static void display(void);

int main(int argc, char **argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(400, 300);
    glutCreateWindow("Glut");
    glutDisplayFunc(display);
    glutMainLoop();
    return 0;
}

static void display(void) {
    glClear(GL_COLOR_BUFFER_BIT);
    glBegin(GL_POLYGON);
    glColor3f(1.0, 0.0, 0.0); glVertex3f(-0.6, -0.75, 0.5);
    glColor3f(0.0, 1.0, 0.0); glVertex3f(0.6, -0.75, 0);
    glColor3f(0.0, 0.0, 1.0); glVertex3f(0, 0.75, 0);
    glEnd();
    glFlush();
}
