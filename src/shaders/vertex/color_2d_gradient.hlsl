#version 300 es

in vec4 aPosition;
in vec4 aColor;

uniform mat4 uTransform;

out lowp vec4 vColor;

void main() {
    vec4 position = uTransform * aPosition;
    vColor = aColor;
    gl_Position = position;
}