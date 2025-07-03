#ifndef COMMON_FILEOP_H
#define COMMON_FILEOP_H 1

#include <common/types.h>

// returns:
//
// char[*len]: a buffer containing content of a file
// (void *)-1: unistd.h function call error, extra error info can be retrieved
// by perrno
// (void *)0: probably `len` is null or failed to allocate a result file buffer
void *read_content(const str fname, i32 *len);
void *load_image(const str path, int *width, int *height, int *nrChannels);

#endif // COMMON_FILEOP_H
