#include <stdio.h>
#include <stdlib.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <common/macros.h>
#include <common/app_state.h>
#include <common/consts.h>

#include <hot_load.h>

struct app_state app_state = {0};

static __attribute__((constructor))
void _setup(void);
static __attribute__((destructor))
void _cleanup(void);

int main(int argc, char **argv) {
  (void)argc, (void)argv;
  float time = 0.0, dt = 0.0;
  time = glfwGetTime();

  while (!glfwWindowShouldClose(app_state.main)) {
    glClearColor(BG.x, BG.y, BG.z, BG.w);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    hotint.render(obj_display);

    float _time = glfwGetTime();
    dt = _time - time, time = _time;
    hotint.update(dt);

    if (app_state.reload_request) {
      if (hot_load(&app_state) == -1) {
        panic("Failed to reload hotint");
      }
      app_state.reload_request = false;
    }

    glfwPollEvents();
    glfwSwapBuffers(app_state.main);
  }

  return 0;
}

static void _setup(void) {
  if (app_state_init(&app_state) == -1) {
    panic("Failed to initialize internal state");
  }

  if (hot_load(&app_state) == -1) {
    panic("Failed to load hot interface for the first time");
  }
}

static void _cleanup(void) {
  hot_unload();
  app_state_cleanup(&app_state);
}
