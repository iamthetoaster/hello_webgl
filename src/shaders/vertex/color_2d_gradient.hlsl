attribute vec4 aPosition;
attribute vec4 aColor;

uniform mat4 uTransform;

varying lowp vec4 vColor;

void main() {
    vec4 position = uTransform * aPosition;
    vColor = aColor;
    gl_Position = position;
}