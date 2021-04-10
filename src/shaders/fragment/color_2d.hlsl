#version 300 es
precision mediump float;

uniform float uTime;

in vec2 v_position;

out vec4 fragColor;


const float PI = 3.14159265359;
const float HALF_PI = 1.57079632679;
const float TAU = 6.28318530718;

const float CYCLE_TIME = 62.0;
const float START_DIVISOR = 2.0;
const float END_DIVISOR = 64.0;

void main() {
    ivec2 position = ivec2(v_position);
    float time = ((mod(uTime, CYCLE_TIME) / CYCLE_TIME) * (END_DIVISOR - START_DIVISOR)) + START_DIVISOR;
    int i_time = int(
        time
    );

    float f_time = fract(time);

    vec4 curr_color = vec4(
        (position.x ^ position.y) % i_time == 0,
        (position.x | position.y) % i_time == 0,
        (position.x & position.y) % i_time == 0,
        1.0
    );
    vec4 next_color = vec4(
        (position.x ^ position.y) % (i_time + 1) == 0,
        (position.x | position.y) % (i_time + 1) == 0,
        (position.x & position.y) % (i_time + 1) == 0,
        1.0
    );

    fragColor = mix(curr_color, next_color, f_time);
}