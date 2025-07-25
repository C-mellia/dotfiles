#ifndef COMMON_CONSTS_H
#define COMMON_CONSTS_H 1

#include <linalg/vec.h>
#include <common/types.h>

extern const u32
INIT_WIDTH,
INIT_HEIGHT;

extern const str
TITLE,
DEFAULT_VERTEX,
DEFAULT_FRAGMENT,
WALL_TEXTURE,
PROTOTYPE_TEXTURE;

extern const f32
RAD,
HALF,
INIT_YAW,
INIT_PITCH,
INIT_ROLL,
INIT_FOV,
INIT_SPEED,
INIT_SENSE,
BASE_SPEED,
BASE_SENSE,
BASE_ZOOM,
MOVE_DAMPING,
ROTATE_DAMPING,
ZOOM_DAMPING,
MAX_FOV;

extern const vec3
INIT_POS;

extern const vec4
BG;

#endif // COMMON_CONSTS_H
