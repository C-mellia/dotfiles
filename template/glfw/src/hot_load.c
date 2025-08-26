#include <dlfcn.h>

#include <common/macros.h>

#include <hot_load.h>

const char *const HOT_LIB = "./libhotint.so";
void *lib_handle = nullptr;
struct hotint hotint = {0};

int hot_load(AppState app_state) {
  if (lib_handle) dlclose(lib_handle);

  void *_new_handle = dlopen(HOT_LIB, RTLD_LAZY | RTLD_GLOBAL);
  if (!_new_handle) {
    error("Failed to load hot library: '%s'; reason: %s", HOT_LIB, dlerror());
    return -1;
  }

  dbg("dlopen: %p", _new_handle);

  struct hotint (*load_hotint)(void) = dlsym(_new_handle, "load_hotint");
  if (!load_hotint) {
    error("Failed to resolve symbol: load_hotint");
    return -1;
  }

  hotint = load_hotint();

  if (lib_handle) hotint.on_reload(app_state);
  else hotint.on_load(app_state);

  lib_handle = _new_handle;
  return 0;
}

void hot_unload(void) {
  if (!lib_handle) return;

  hotint.on_unload();
  dlclose(lib_handle);

  lib_handle = nullptr, hotint = (struct hotint) {0};
}
