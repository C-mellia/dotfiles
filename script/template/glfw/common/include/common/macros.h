#ifndef COMMON_MACROS_H
#define COMMON_MACROS_H 1

#include <stdio.h>
#include <math.h>

#define ESC 27
#define EPSILON 1e-4

#define $(_) ({\
  int _res = (_);\
  if (_res == -1) return -1;\
  _res;\
})

#define defer(func) __attribute__((cleanup(func)))

#define loginfo(LEVEL, FMT, ...) ({\
  fprintf(stderr, "[" LEVEL "] %s:%d:%s: " FMT "\n",\
          __FILE__, __LINE__, __func__, ##__VA_ARGS__);\
})

#define panic(FMT, ...) (loginfo("fatal", FMT, ##__VA_ARGS__), exit(1))
#define error(FMT, ...) (loginfo("error", FMT, ##__VA_ARGS__))

#ifndef RELEASE
#define dbg(FMT, ...) (loginfo("debug", FMT, ##__VA_ARGS__))
#else
#define dbg(FMT, ...) ((void)0)
#endif

#define __depr__ __attribute__((deprecated))

#endif // COMMON_MACROS_H
