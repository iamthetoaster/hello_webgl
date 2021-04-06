#version 300 es

precision mediump float;

uniform float uOpacity;

in lowp vec4 vColor;

out vec4 fragColor;

void main() {
    fragColor = vec4(vColor.xyz, uOpacity);
}