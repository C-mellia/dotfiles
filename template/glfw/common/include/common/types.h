#ifndef COMMON_TYPES_H
#define COMMON_TYPES_H 1

#include <GL/gl.h>

typedef GLuint u32;
typedef GLint i32;
typedef GLushort u16;
typedef GLshort i16;
typedef GLubyte u8;
typedef GLbyte i8;
typedef GLsizei isize;
typedef GLfloat f32;
typedef const char *str;

enum mesh_type {
  MESH_NONE=-1,
  MESH_CUBE,
};

#endif // COMMON_TYPES_H
