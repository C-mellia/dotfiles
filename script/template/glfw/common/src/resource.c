#include <string.h>

#include <fcntl.h>
#include <errno.h>

#include <glad/glad.h>

#include <common/object.h>
#include <common/macros.h>
#include <common/fileop.h>
#include <common/resource.h>
#include <common/consts.h>
#include <common/defer.h>

// struct resource resource = {0};

static __attribute__((unused))
struct vao gen_rect_buf(void);
static __attribute__((unused))
struct vao gen_cube_buf(void);

u32 make_shader(GLenum type, const str path) {
  i32 len = 0;
  GLchar defer(ptr_drop) *src = read_content(path, &len);

  if (src == 0) {
    char log_buf[0x100] = {0};
    loginfo("error", "Failed to open file: '%s'", path);
    if (strerror_r(errno, log_buf, sizeof log_buf) != -1) {
      loginfo("info", "%s", log_buf);
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

    loginfo("error", "Failed to compile shader source file: '%s'", path);
    loginfo("info", "Error info: %s", log_buf);

    glDeleteShader(shader);
    return 0;
  } else {
    loginfo("info", "Successfully compiled source file: '%s'", path);
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

    loginfo("error", "Failed to link shader programs (%d) and (%d)", vshader, fshader);
    loginfo("info", "error info: %s", log_buf);

    glDeleteProgram(program);
  } else {
    loginfo("info", "Successfully linked program(%u)", program);
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

i32 make_resource(Resource resource) {
  {
    u32 defer(shader_drop) vshader = make_shader(GL_VERTEX_SHADER, DEFAULT_VERTEX);
    u32 defer(shader_drop) fshader = make_shader(GL_FRAGMENT_SHADER, DEFAULT_FRAGMENT);

    if (!vshader || !fshader) {
      error("Failed to create shader objects");
      return -1;
    }

    resource->def_prog = make_program(vshader, fshader);

    if (!resource->def_prog) {
      error("Failed to create shader program");
      return -1;
    }
  }

  {
    resource->attrib.projection = glGetUniformLocation(resource->def_prog, "projection");
    resource->attrib.model = glGetUniformLocation(resource->def_prog, "model");
    resource->attrib.view = glGetUniformLocation(resource->def_prog, "view");

    dbg("model(%d), view(%d), projection(%d)",
        resource->attrib.model,
        resource->attrib.view,
        resource->attrib.projection);
  }

  {
    resource->cube = gen_cube_buf();

    if (!resource->cube.vert_arr || !resource->cube.arr_buf) {
      error("Failed to create cube mesh");
      return -1;
    }

    dbg("cube: {vert_arr: %u, arr_buf: %u}",
        resource->cube.vert_arr,
        resource->cube.arr_buf);
  }

  {
    if (arr_init(&resource->objects, 0, sizeof(struct obj)) == -1) {
      error("Failed to initialize object array");
      return -1;
    }
  }

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

  {
    resource->wall_tex = make_texture(WALL_TEXTURE);
    if (!resource->wall_tex) {
      error("Failed to load wall texture");
      return -1;
    }
  }

  {
    resource->proto_tex = make_texture(PROTOTYPE_TEXTURE);
    if (!resource->proto_tex) {
      error("Failed to load prototype texture");
      return -1;
    }
  }

  loginfo("info", "resources loaded");
  return 0;
}

void free_resource(Resource resource) {
  glDeleteProgram(resource->def_prog);

  glDeleteTextures(1, &resource->wall_tex);
  glDeleteTextures(1, &resource->proto_tex);

  glDeleteVertexArrays(1, &resource->cube.vert_arr);
  glDeleteBuffers(1, &resource->cube.arr_buf);

  arr_cleanup(&resource->objects);

  loginfo("info", "resources deallocated");
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
