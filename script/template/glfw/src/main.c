#include <stdio.h>
#include <stdlib.h>

#include <GLFW/glfw3.h>

#include <impl.h>
#include <state.h>
#include <macros.h>

static inline __attribute__((destructor))
void __cleanup(void);

int main(int argc, char **argv) {
    if (state_init(argc, argv) == -1) exit(1);
    while (!glfwWindowShouldClose(gl_state.main)) {
        update();
    }
    return 0;
}

static void __cleanup(void) {
    state_cleanup(), glfwTerminate();
}
