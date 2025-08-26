#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <linalg/mat_ext.h>

#include <common/consts.h>
#include <common/macros.h>
#include <common/object.h>

int obj_init(Obj obj, vec3 pos, vec3 ypr,
             f32 mass, vec3 scale,
             enum mesh_type mesh_type) {
  if (!obj) return -1;
  obj->ypr = ypr, obj->pos = pos;
  obj->ypr_vel = obj->vel = vec3_zero;

  obj->mass = mass;
  obj->scale = scale;

  obj->force = obj->torque = vec3_zero;

  obj->free_look = true;

  obj->mesh_type = mesh_type;
  obj->program = obj->texture = 0;

  return 0;
}

Obj obj_new(vec3 pos, vec3 ypr,
            f32 mass, vec3 scale,
            enum mesh_type mesh_type) {
  Obj obj = malloc(sizeof *obj);
  if (!obj) return 0;
  memset(obj, 0, sizeof *obj);
  if (obj_init(
    obj, ypr, pos,
    mass, scale,
    mesh_type
  ) == -1) return free(obj), (void *)0;

  return obj;
}

void obj_cleanup(Obj obj) {
  if (!obj) return;
}

void *obj_drop(Obj *obj) {
  if (obj) obj_cleanup(*obj), free(*obj), *obj = (void *)0;
  return 0;
}

int obj_dbg_fmt(Arr fmt, Obj obj) {
  if (!fmt) return -1;
  if (!obj) return arr_printf(fmt, "(nil)");
  int len = 0;

  len += $(arr_printf(fmt, "{pos: "));
  len += $(vec3_dbg_fmt(fmt, obj->pos));
  len += $(arr_printf(fmt, ", ypr: "));
  len += $(vec3_dbg_fmt(fmt, obj->ypr));
  len += $(arr_printf(fmt, ", vel: "));
  len += $(vec3_dbg_fmt(fmt, obj->vel));
  len += $(arr_printf(fmt, ", ypr_vel: "));
  len += $(vec3_dbg_fmt(fmt, obj->ypr_vel));
  len += $(arr_printf(fmt, ", mass: %f}", obj->mass));

  return len;
}

f32 obj_yaw(Obj obj) {
  if (!obj) return 0.0;
  return obj->ypr.x;
}

f32 obj_pitch(Obj obj) {
  if (!obj) return 0.0;
  return obj->ypr.y;
}

f32 obj_roll(Obj obj) {
  if (!obj) return 0.0;
  return obj->ypr.z;
}

vec3 obj_vel_damp(Obj obj) {
  if (!obj) return vec3_zero;
  return vec3_scale(obj->vel, -MOVE_DAMPING);
}

vec3 obj_ypr_vel_damp(Obj obj) {
  if (!obj) return vec3_zero;
  return vec3_scale(obj->ypr_vel, -ROTATE_DAMPING);
}

vec3 obj_dir(Obj obj) {
  if (!obj) return vec3_zero;
  const f32
  cy = cos(obj->ypr.x), sy = sin(obj->ypr.x),
  cp = cos(obj->ypr.y), sp = sin(obj->ypr.y);
  return (vec3){
    cy * cp, sy * cp, -sp
  };
}

void obj_use_prog(Obj obj, u32 program) {
  if (!obj) return;
  obj->program = program;
}

void obj_use_texture(Obj obj, u32 texture) {
  if (!obj) return;
  obj->texture = texture;
}

void obj_apply(Obj obj, vec3 force, vec3 torque) {
  if (!obj) return;
  obj->force = vec3_add(obj->force, force);
  obj->torque = vec3_add(obj->torque, torque);
}

// approximate moment of inertia with mass
void obj_update(Obj obj, vec3 force, vec3 torque, f32 dt) {
  if (!obj) return;
  obj_update_pos(obj, force, dt), obj_update_ypr(obj, torque, dt);
}

void obj_update_pos(Obj obj, vec3 force, f32 dt) {
  if (!obj) return;

  obj->pos = vec3_add(
    obj->pos, vec3_scale(obj->vel, dt)
  );

  if (fabs(obj->mass) < EPSILON) return;

  obj->vel = vec3_add(
    obj->vel, vec3_scale(force, dt / obj->mass)
  );
}

void obj_update_ypr(Obj obj, vec3 torque, f32 dt) {
  if (!obj) return;

  obj->ypr = vec3_add(
    obj->ypr, vec3_scale(obj->ypr_vel, dt)
  );

  if (fabs(obj->mass) < EPSILON) return;

  obj->ypr_vel = vec3_add(
    obj->ypr_vel, vec3_scale(torque, dt / obj->mass)
  );
}

void obj_reset_pos(Obj obj) {
  obj->pos = obj->vel = obj->force = vec3_zero;
}

void obj_reset_ypr(Obj obj) {
  obj->ypr = obj->ypr_vel = obj->torque = vec3_zero;
}

mat4 obj_model(Obj obj) {
  if (!obj) return mat4_unit;
  return mat4_mult_mat(
    mat4_diag(obj->scale.x, obj->scale.y, obj->scale.z, 1.0),
    mat4_mult_mat(
      mat4_translate(obj->pos.x, obj->pos.y, obj->pos.z),
      mat4_transpose(mat4_ypr_rad(obj->ypr))
    )
  );
}

mat4 obj_lookat(Obj obj) {
  return mat4_lookat_rad(obj->pos, obj->ypr);
}
