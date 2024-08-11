precision mediump float;

uniform float u_Time;

varying vec2 vUv;
varying vec2 vUv0;

// vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
//     return a + b * cos(6.28318 * (c * t + d));
// }

vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5); 
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);
    return a + b * cos(6.28318 * (c * t + d));
}

void main() {

    vec2 uv1 = vUv;
    vec2 uv0 = vUv0;

    
    uv0 = fract(uv0 * 1.0) - 0.5;

    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i < 4.0; i++) {
        uv1 = fract(uv1 * 2.0) - 0.5;
        float d = length(uv1) * exp(-length(uv0));
        vec3 col = palette(length(uv0) + (i * 0.4) + u_Time * 0.00005);

        d = sin(d * 8.0 + (u_Time * 0.001)) / 8.0;
        d = abs(d);
        d = pow(0.01 / d, 1.2);

        finalColor += col * d;
    }

    gl_FragColor = vec4(finalColor, 1.0);
}
