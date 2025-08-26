#include <stdlib.h>
#include <math.h>

#include <array/array.h>

#include <common/consts.h>
#include <common/macros.h>
#include <common/object.h>
#include <common/physics.h>

vec3 obj_ypr_check_bound(vec3 ypr, bool free_look) {
  const f32 PITCH=85.0 * RAD;
  return (struct vec3) {
    ypr.x < -M_PI? ypr.x + 2 * M_PI: ypr.x > M_PI? ypr.x - 2 * M_PI: ypr.x,
    free_look
    ? ypr.y < -M_PI? ypr.y + 2 * M_PI: ypr.y > M_PI? ypr.y - 2 * M_PI: ypr.y
    : ypr.y < -PITCH? -PITCH: ypr.y > PITCH? PITCH: ypr.y,
    ypr.z < 0? ypr.z + 2 * M_PI: ypr.z > M_PI? ypr.z - 2 * M_PI: ypr.z,
  };
}

int objs_update(Arr objs, float dt) {
  // dbg("%f", dt);
  for (size_t i = 0; i < arr_len(objs); ++i) {
    Obj *obj_p = arr_get(objs, i);
    if (!obj_p || !*obj_p) continue;
    Obj obj = *obj_p;
    obj_update(obj, obj->force, obj->torque, dt);
    obj->ypr = obj_ypr_check_bound(obj->ypr, obj->free_look);
    obj->force = obj->torque = vec3_zero;
  }
  return 0;
}
