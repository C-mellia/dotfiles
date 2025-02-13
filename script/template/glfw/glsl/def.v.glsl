#version 330 core

layout(location = 0) in vec3 a_pos;
layout(location = 1) in vec2 a_tex_pos;

out vec2 tex_pos;

uniform mat4 projection, model, view;

void main(void) {
    gl_Position = projection * view * model * vec4(a_pos, 1.0);
    tex_pos = a_tex_pos;
}
