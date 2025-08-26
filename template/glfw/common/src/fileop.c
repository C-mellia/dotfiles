#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#include <common/fileop.h>
#include <common/defer.h>

#define STB_IMAGE_IMPLEMENTATION
#include <stb/stb_image.h>

void *read_content(const str fname, i32 *len) {
  if (!len) return (void *)0;

  i32 defer(fd_drop) fd = open(fname, O_RDONLY);
  if (fd == -1) return (void *)0;

  *len = lseek(fd, 0, SEEK_END), lseek(fd, 0, SEEK_SET);
  if (*len == -1) return (void *)0;

  char *contents = malloc(*len + 1);
  if (!contents) return (void *)0;

  *len = read(fd, contents, *len);
  if (*len == -1) {
    *len = 0, free(contents);
    return (void *)0;
  }

  return contents[*len] = 0, contents;
}

void *load_image(const str path, int *width, int *height, int *nrChannels) {
  stbi_set_flip_vertically_on_load(true);
  return stbi_load(path, width, height, nrChannels, 0);
}
