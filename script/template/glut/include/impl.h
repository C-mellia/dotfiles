#ifndef IMPL_H
#define IMPL_H 1

#include <types.h>

void reshape_callback(int width, int height);
void display_callback(void);
void mouse_callback(int button, int state, int x, int y);
void key_callback(u8 key, int x, int y);
void special_key_callback(int key, int x, int y);
void motion_callback(int x, int y);
void passive_motion_callback(int x, int y);

// state: GLUT_NOT_VISIBLE | GLUT_VISIBLE
void visibility_callback(int state);

// state: GLUT_LEFT | GLUT_ENTERED
void entry_callback(int state);

void idle_callback(void);

#endif // IMPL_H
