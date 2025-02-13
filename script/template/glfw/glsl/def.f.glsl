#version 330 core

in vec2 tex_pos;
out vec4 FragColor;

uniform sampler2D wall_tex;

void main(void) {
    FragColor = texture(wall_tex, tex_pos);
}
