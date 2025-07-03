#ifndef COMMON_PHYSICS_H
#define COMMON_PHYSICS_H 1

#include <linalg/vec.h>

struct arr;

/*
 * yaw in [-180, 180]
 * pitch in [-89, 89] or [-180, 180] if free_look
 * roll in [0, 360]
 */
vec3 obj_ypr_check_bound(vec3 ypr, bool free_look);
int objs_update(struct arr *objs, float dt);

#endif // COMMON_PHYSICS_H
