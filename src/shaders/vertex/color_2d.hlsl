#version 300 es

in vec4 aPosition;
uniform mat4 uTransform;

out vec2 v_position;

void main() {
    vec4 position = uTransform * aPosition;
    float size = 400.0;
    v_position = aPosition.xy * size - vec2(size, size) / 2.0;
    gl_Position = position;
}