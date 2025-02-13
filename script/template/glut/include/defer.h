#ifndef DEFER_H
#define DEFER_H 1

#include <types.h>
#include <stdarg.h>

#define defer(func) __attribute__((cleanup(func)))

void *va_list_drop(va_list *list);
void *fd_drop(int *fd);
void *ptr_drop(void *ptr);
void *shader_drop(u32 *shader);

#endif // DEFER_H
