#ifndef COMMON_RESOURCE_H
#define COMMON_RESOURCE_H 1

#include <array/array.h>

#include <common/types.h>
#include <common/object.h>

typedef struct resource {
  u32 def_prog;

  struct vao {
    u32 vert_arr, arr_buf;
  } cube;

  struct attrib {
    u32 model, projection, view;
  } attrib;

  struct arr objects;

  u32 wall_tex, proto_tex;
} *Resource;

u32 make_shader(GLenum type, const str path);
u32 make_program(u32 vshader, u32 fshader);
u32 make_texture(const str path);
struct vao make_vao(GLenum target, void *data, size_t size);
i32 make_resource(Resource resource);
void free_resource(Resource resource);
struct vao vao_from_mesh_config(enum mesh_type mesh_type);

#endif // COMMON_RESOURCE_H
