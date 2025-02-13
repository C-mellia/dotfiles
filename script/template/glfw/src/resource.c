#include <string.h>

#include <macros.h>
#include <fcntl.h>
#include <errno.h>

#include <GL/glew.h>
#include <GL/gl.h>

#include <macros.h>
#include <fileop.h>
#include <resource.h>
#include <consts.h>
#include <defer.h>

struct resource resource = {0};

static __attribute__((unused))
struct vao gen_rect_buf(void);
static __attribute__((unused))
struct vao gen_cube_buf(void);

u32 make_shader(GLenum type, const str path) {
    i32 len = 0;
    GLchar defer(ptr_drop) *src = read_content(path, &len);

    if (src == 0) {
        char log_buf[0x100] = {0};
        loginfo("error", "Failed to open file: '%s'\n", path);
        if (strerror_r(errno, log_buf, sizeof log_buf) != -1) {
            loginfo("info", "%s\n", log_buf);
        }
        return 0;
    }

    u32 shader = glCreateShader(type);
    glShaderSource(shader, 1, (const GLchar **)&src, &len);
    glCompileShader(shader);

    i32 ok = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &ok);

    if (!ok) {
        i32 log_len = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &log_len);
        GLchar log_buf[log_len];
        glGetShaderInfoLog(shader, log_len, 0, log_buf);

        loginfo("error", "Failed to compile shader source file: '%s'\n", path);
        loginfo("info", "Error info: %s\n", log_buf);

        glDeleteShader(shader);
        return 0;
    } else {
        loginfo("info", "Successfully compiled source file: '%s'\n", path);
        return shader;
    }
}

u32 make_program(u32 vshader, u32 fshader) {
    u32 program = glCreateProgram();

    glAttachShader(program, vshader);
    glAttachShader(program, fshader);
    glLinkProgram(program);

    i32 ok = 0;
    glGetProgramiv(program, GL_LINK_STATUS, &ok);

    if (!ok) {
        i32 log_len = 0;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &log_len);
        GLchar log_buf[log_len];
        glGetProgramInfoLog(program, log_len, 0, log_buf);

        loginfo("error", "Failed to link shader programs (%d) and (%d)\n", vshader, fshader);
        loginfo("info", "error info: %s\n", log_buf);

        glDeleteProgram(program);
    } else {
        loginfo("info", "Successfully linked program(%u)\n", program);
    }

    return program;
}

u32 make_texture(const str path) {
    int width, height, nrChannels;
    u8 defer(ptr_drop) *image = load_image(path, &width, &height, &nrChannels);

    if (!image) return 0;

    u32 texture = 0;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexImage2D(
        GL_TEXTURE_2D,
        0, GL_RGB,
        width, height,
        0, GL_RGB,
        GL_UNSIGNED_BYTE,
        image
    ), glGenerateMipmap(GL_TEXTURE_2D);

    return texture;
}

struct vao make_vao(GLenum target, void *data, size_t size) {
    u32 vert_arr, arr_buf;

    glGenVertexArrays(1, &vert_arr), glBindVertexArray(vert_arr);

    glGenBuffers(1, &arr_buf), glBindBuffer(target, arr_buf);
    glBufferData(target, size, data, GL_STATIC_DRAW);

    return (struct vao) {
        .vert_arr = vert_arr,
        .arr_buf = arr_buf,
    };
}

i32 make_resource(void) {
    {
        u32 defer(shader_drop)
        vshader = make_shader(GL_VERTEX_SHADER, DEFAULT_VERTEX),
        fshader = make_shader(GL_FRAGMENT_SHADER, DEFAULT_FRAGMENT);

        if (!vshader || !fshader) return -1;

        resource.def_prog = make_program(vshader, fshader);
        if (!resource.def_prog) return -1;
    }

    {
        resource.attrib.projection = glGetUniformLocation(resource.def_prog, "projection");
        resource.attrib.model = glGetUniformLocation(resource.def_prog, "model");
        resource.attrib.view = glGetUniformLocation(resource.def_prog, "view");

        loginfo("info", "model(%d), view(%d), projection(%d)\n",
                resource.attrib.model, resource.attrib.view, resource.attrib.projection);
    }

    {
        resource.cube = gen_cube_buf();
        if (!resource.cube.vert_arr || !resource.cube.arr_buf) return -1;
    }

    {
        resource.wall_tex = make_texture(WALL_TEXTURE);
        if (!resource.wall_tex) return -1;
    }

    return 0;
}

void free_resource(void) {
    glDeleteProgram(resource.def_prog);

    glDeleteTextures(1, &resource.wall_tex);

    glDeleteVertexArrays(1, &resource.cube.vert_arr);
    glDeleteBuffers(1, &resource.cube.arr_buf);
}

static struct vao gen_rect_buf(void) {
    static f32 rect_mesh[] = {
        -0.5,  0.5,  0.0,    0.0, 1.0,
         0.5, -0.5,  0.0,    1.0, 0.0,
        -0.5, -0.5,  0.0,    0.0, 0.0,
        -0.5,  0.5,  0.0,    0.0, 1.0,
         0.5, -0.5,  0.0,    1.0, 0.0,
         0.5,  0.5,  0.0,    1.0, 1.0,
    };

    struct vao vao = make_vao(GL_ARRAY_BUFFER, rect_mesh, sizeof rect_mesh);

    glVertexAttribPointer(
        0 /* attribute */,
        3 /* size */,
        GL_FLOAT /* type */,
        GL_FALSE /* normalized */,
        sizeof(f32) * 5 /* stride */,
        (void *)0 /* array buffer offset */
    ), glEnableVertexAttribArray(0);

    glVertexAttribPointer(
        1 /* attribute */,
        2 /* size */,
        GL_FLOAT /* type */,
        GL_FALSE /* normalized */,
        sizeof(f32) * 5 /* stride */,
        (void *)(sizeof(f32) * 3) /* array buffer offset */
    ), glEnableVertexAttribArray(1);

    return vao;
}

static struct vao gen_cube_buf(void) {
    static f32 cube_mesh[] = {
        // front
        -0.5,  0.5,  0.5,    0.0, 1.0,
         0.5, -0.5,  0.5,    1.0, 0.0,
        -0.5, -0.5,  0.5,    0.0, 0.0,
        -0.5,  0.5,  0.5,    0.0, 1.0,
         0.5, -0.5,  0.5,    1.0, 0.0,
         0.5,  0.5,  0.5,    1.0, 1.0,

        // back
         0.5,  0.5, -0.5,    0.0, 1.0,
        -0.5, -0.5, -0.5,    1.0, 0.0,
         0.5, -0.5, -0.5,    0.0, 0.0,
         0.5,  0.5, -0.5,    0.0, 1.0,
        -0.5, -0.5, -0.5,    1.0, 0.0,
        -0.5,  0.5, -0.5,    1.0, 1.0,

        // left
        -0.5,  0.5, -0.5,    0.0, 1.0,
        -0.5, -0.5,  0.5,    1.0, 0.0,
        -0.5, -0.5, -0.5,    0.0, 0.0,
        -0.5,  0.5, -0.5,    0.0, 1.0,
        -0.5, -0.5,  0.5,    1.0, 0.0,
        -0.5,  0.5,  0.5,    1.0, 1.0,

        // right
         0.5,  0.5,  0.5,    0.0, 1.0,
         0.5, -0.5, -0.5,    1.0, 0.0,
         0.5, -0.5,  0.5,    0.0, 0.0,
         0.5,  0.5,  0.5,    0.0, 1.0,
         0.5, -0.5, -0.5,    1.0, 0.0,
         0.5,  0.5, -0.5,    1.0, 1.0,

        // top
        -0.5,  0.5, -0.5,    0.0, 1.0,
         0.5,  0.5,  0.5,    1.0, 0.0,
        -0.5,  0.5,  0.5,    0.0, 0.0,
        -0.5,  0.5, -0.5,    0.0, 1.0,
         0.5,  0.5,  0.5,    1.0, 0.0,
         0.5,  0.5, -0.5,    1.0, 1.0,

        // bottom
        -0.5, -0.5,  0.5,    0.0, 1.0,
         0.5, -0.5, -0.5,    1.0, 0.0,
        -0.5, -0.5, -0.5,    0.0, 0.0,
        -0.5, -0.5,  0.5,    0.0, 1.0,
         0.5, -0.5, -0.5,    1.0, 0.0,
         0.5, -0.5,  0.5,    1.0, 1.0,
    };

    struct vao vao = make_vao(GL_ARRAY_BUFFER, cube_mesh, sizeof cube_mesh);

    glVertexAttribPointer(
        0 /* attribute */,
        3 /* size */,
        GL_FLOAT /* type */,
        GL_FALSE /* normalized */,
        sizeof(f32) * 5 /* stride */,
        (void *)0 /* array buffer offset */
    ), glEnableVertexAttribArray(0);

    glVertexAttribPointer(
        1 /* attribute */,
        2 /* size */,
        GL_FLOAT /* type */,
        GL_FALSE /* normalized */,
        sizeof(f32) * 5 /* stride */,
        (void *)(sizeof(f32) * 3) /* array buffer offset */
    ), glEnableVertexAttribArray(1);

    return vao;
}
