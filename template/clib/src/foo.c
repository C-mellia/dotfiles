#include <stdlib.h>

#include <foo/foo.h>

int foo(int val) {
  if (val < 0) exit(1);
  else return 0;
}
