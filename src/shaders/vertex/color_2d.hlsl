#version 300 es

uniform mat4 uTransform;
uniform float uSize;

in vec4 aPosition;

out vec2 v_position;

void main() {
    vec4 position = uTransform * aPosition;
    v_position = aPosition.xy * uSize - vec2(uSize, uSize) / 2.0;
    gl_Position = position;
}