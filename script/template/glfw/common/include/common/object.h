#ifndef COMMON_OBJECT_H
#define COMMON_OBJECT_H 1

#include <linalg/mat.h>
#include <linalg/vec.h>
#include <array/array.h>

#include <common/types.h>

typedef struct obj {
  vec3
  pos, ypr,
  vel, ypr_vel,
  force, torque;

  f32 mass;
  vec3 scale;

  bool free_look;

  u32 program, texture;
  enum mesh_type mesh_type;
} *Obj;

int obj_init(Obj obj, vec3 pos, vec3 ypr,
             f32 mass, vec3 scale,
             enum mesh_type mesh_type);
Obj obj_new(vec3 pos, vec3 ypr,
            f32 mass, vec3 scale,
            enum mesh_type mesh_type);
void obj_cleanup(Obj obj);
void *obj_drop(Obj *obj);

int obj_dbg_fmt(Arr fmt, Obj obj);

f32 obj_yaw(Obj obj);
f32 obj_pitch(Obj obj);
f32 obj_roll(Obj obj);
vec3 obj_vel_damp(Obj obj);
vec3 obj_ypr_vel_damp(Obj obj);
vec3 obj_dir(Obj obj);

void obj_use_prog(Obj obj, u32 program);
void obj_use_texture(Obj obj, u32 texture);
void obj_apply(Obj obj, vec3 force, vec3 torque);
void obj_update(Obj obj, vec3 force, vec3 torque, f32 dt);
void obj_update_pos(Obj obj, vec3 force, f32 dt);
void obj_update_ypr(Obj obj, vec3 torque, f32 dt);
void obj_reset_pos(Obj obj);
void obj_reset_ypr(Obj obj);
mat4 obj_model(Obj obj);
mat4 obj_lookat(Obj obj);

#endif // COMMON_OBJECT_H
