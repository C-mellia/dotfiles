#include <stdlib.h>

#include <glad/glad.h>

#include <unistd.h>
#include <fcntl.h>

#include <common/defer.h>

void *va_list_drop(va_list *list) {
    if (list) va_end(*list);
    return (void *)0;
}

void *fd_drop(int *fd) {
    // in case maintaining errno is required, since `closing` a -1 file
    // descriptor, which isn't a regular file descriptor, will overwrite the
    // errno
    if (fd && *fd != -1) close(*fd), *fd = -1;
    return (void *)0;
}

void *ptr_drop(void *ptr) {
    void **__ptr = ptr;
    if (ptr) free(*__ptr), *__ptr = (void *)0;
    return (void *)0;
}

void *shader_drop(u32 *shader) {
    if (shader) glDeleteShader(*shader), *shader = 0;
    return (void *)0;
}
