#ifndef HOTINT_H
#define HOTINT_H 1

#include <common/app_state.h>
#include <common/types.h>

struct hotint {
  int (*update)(f32 dt);
  int (*render)(obj_display_t obj_display);
  int (*on_load)(AppState app_state);
  void (*on_reload)(AppState app_state);
  void (*on_unload)(void);

  // struct callbacks {
  //   void (*key_callback)(GLFWwindow *window,
  //                        int key,
  //                        int scancode,
  //                        int action,
  //                        int mods);
  //   void (*cursor_pos_callback)(GLFWwindow *window,
  //                               double xpos,
  //                               double ypos);
  //   void (*scroll_callback)(GLFWwindow *window,
  //                           double xoff,
  //                           double yoff);
  // } callbacks;
};

#endif // HOTINT_H
