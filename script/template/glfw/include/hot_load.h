#ifndef HOT_LOAD_H
#define HOT_LOAD_H 1

#include <hotint.h>

extern void *lib_handle;
extern struct hotint hotint;

int hot_load(AppState app_state);
void hot_unload(void);

#endif // HOT_LOAD_H
