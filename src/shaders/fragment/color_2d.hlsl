#version 300 es

precision mediump float;

in vec2 v_position;

out vec4 fragColor;

// vec4 color_from_angle(float theta) {
//     const float PI = 3.14159265;
//     const float TWO_PI = PI * 2.0;
//     if (theta < 0.0) {
//         theta = theta + TWO_PI;
//     }
//     if (theta > TWO_PI) {
//         theta = theta - TWO_PI;
//     }
//     const float TWO_THIRDS_PI = PI * 2.0 / 3.0;
//     if (theta < TWO_THIRDS_PI) {
//         float amount = theta / TWO_THIRDS_PI;
//         return mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), amount);
//     }
//     theta = theta - TWO_THIRDS_PI;
//     if (theta < TWO_THIRDS_PI) {
//         float amount = theta / TWO_THIRDS_PI;
//         return mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(0.0, 0.0, 1.0, 1.0), amount);
//     }
//     theta = theta - TWO_THIRDS_PI;
//     float amount = theta / TWO_THIRDS_PI;
//     return mix(vec4(0.0, 0.0, 1.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), amount);
// }

void main() {
    // fragColor = color_from_angle(tanh(tan(atan(v_position.y / v_position.x) * 3.0)) + cos(length(v_position)));
    ivec2 position = ivec2(v_position);
    fragColor = (position.x | position.y) % 19 == 0 ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
}