#include <common/macros.h>
#include <common/consts.h>

const u32
INIT_WIDTH=800,
INIT_HEIGHT=600;

const str
TITLE="OpenGL",
DEFAULT_VERTEX="glsl/def.v.glsl",
DEFAULT_FRAGMENT="glsl/def.f.glsl",
WALL_TEXTURE="textures/wall.jpg",
PROTOTYPE_TEXTURE="prototype/texture_01.png";

const f32
RAD=M_PI / 180.0,
INIT_YAW=0.0,
INIT_PITCH=0.0,
INIT_ROLL=0.0,
INIT_FOV = 100.0,
INIT_SPEED = 1.0,
INIT_SENSE = 0.15,
BASE_SPEED=20.0,
BASE_SENSE=15.0 * M_PI,
BASE_ZOOM=45.0,
MOVE_DAMPING=5.4,
ROTATE_DAMPING=6.0,
ZOOM_DAMPING=6.0,
MAX_FOV=170.0;

const vec3
INIT_POS={ 0.0, 0.0, 0.0 };

const vec4
BG = { 0.09, 0.09, 0.09, 0.80 };
