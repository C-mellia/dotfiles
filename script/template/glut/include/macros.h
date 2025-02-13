#ifndef MACROS_H
#define MACROS_H 1

#include <stdio.h>

#define ESC 27
#define EPSILON 1e-6

#define loginfo(LEVEL, FMT, ...) ({\
    fprintf(stderr, "["LEVEL"] %s:%d:%s: "FMT,\
            __FILE__, __LINE__, __func__, ##__VA_ARGS__);\
})

#endif // MACROS_H
