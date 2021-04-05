precision mediump float;

uniform float uOpacity;

varying lowp vec4 vColor;

void main() {
    gl_FragColor = vec4(vColor.xyz, uOpacity);
}