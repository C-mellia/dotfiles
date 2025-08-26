#ifndef COMMON_DEFER_H
#define COMMON_DEFER_H 1

#include <stdarg.h>

#include <common/types.h>

#define defer(func) __attribute__((cleanup(func)))

void *va_list_drop(va_list *list);
void *fd_drop(int *fd);
void *ptr_drop(void *ptr);
void *shader_drop(u32 *shader);

#endif // COMMON_DEFER_H
