#version 300 es
#define PI 3.14159265359
#define HALF_PI 1.57079632679
#define TAU 6.28318530718

precision mediump float;

uniform float uTime;

in vec2 v_position;

out vec4 fragColor;

const float CYCLE_TIME = 38.0;

const float START_DIVISOR = 2.0;
const float END_DIVISOR = 40.0;

void main() {
    ivec2 position = ivec2(v_position);
    int i_time = int(
        ((mod(uTime, CYCLE_TIME) / CYCLE_TIME) * (END_DIVISOR - START_DIVISOR)) + START_DIVISOR
    );
    fragColor = (position.x | position.y) % i_time == 0 ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
}