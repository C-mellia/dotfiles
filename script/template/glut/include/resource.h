#ifndef RESOURCE_H
#define RESOURCE_H 1

#include <types.h>

extern struct resource {
    u32 def_prog;

    struct vao {
        u32 vert_arr, arr_buf;
    } cube;

    struct attrib {
        u32 model, projection, view;
    } attrib;

    u32 wall_tex;
} resource;

u32 make_shader(GLenum type, const str path);
u32 make_program(u32 vshader, u32 fshader);
u32 make_texture(const str path);
struct vao make_vao(GLenum target, void *data, size_t size);
i32 make_resource(void);
void free_resource(void);

#endif // RESOURCE_H
