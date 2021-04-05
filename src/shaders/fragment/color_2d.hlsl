precision mediump float;

varying vec2 v_position;

float sinh(float x) {
    return (1.0 - exp(2.0 * x)) / (2.0 * exp(-x));
}

float cosh(float x) {
    return (1.0 + exp(2.0 * x)) / (2.0 * exp(-x));
}

float tanh(float x) {
    float cos_h = cosh(x);
    float sin_h = sinh(x);
    if (cos_h == 0.0) return 1.0;
    return sin_h / cos_h;
}

vec4 color_from_angle(float theta) {
    const float PI = 3.14159265;
    const float TWO_PI = PI * 2.0;
    if (theta < 0.0) {
        theta = theta + TWO_PI;
    }
    if (theta > TWO_PI) {
        theta = theta - TWO_PI;
    }
    const float TWO_THIRDS_PI = PI * 2.0 / 3.0;
    if (theta < TWO_THIRDS_PI) {
        float amount = theta / TWO_THIRDS_PI;
        return mix(vec4(1.0, 0.0, 0.0, 1.0), vec4(0.0, 1.0, 0.0, 1.0), amount);
    }
    theta = theta - TWO_THIRDS_PI;
    if (theta < TWO_THIRDS_PI) {
        float amount = theta / TWO_THIRDS_PI;
        return mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(0.0, 0.0, 1.0, 1.0), amount);
    }
    theta = theta - TWO_THIRDS_PI;
    float amount = theta / TWO_THIRDS_PI;
    return mix(vec4(0.0, 0.0, 1.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), amount);
}

void main() {
    gl_FragColor = color_from_angle(tanh(tan(atan(v_position.y / v_position.x) * 3.0)) + cos(length(v_position)));
}