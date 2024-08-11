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

// Circle Wave signed distance function
float sdCircleWave(in vec2 p, in float tb, in float ra) {
    tb = 3.1415927 * 5.0 / 6.0 * max(tb, 0.0001);
    vec2 co = ra * vec2(sin(tb), cos(tb));
    p.x = abs(mod(p.x, co.x * 4.0) - co.x * 2.0);
    vec2 p1 = p;
    vec2 p2 = vec2(abs(p.x - 2.0 * co.x), -p.y + 2.0 * co.y);
    float d1 = ((co.y * p1.x > co.x * p1.y) ? length(p1 - co) : abs(length(p1) - ra));
    float d2 = ((co.y * p2.x > co.x * p2.y) ? length(p2 - co) : abs(length(p2) - ra));
    return min(d1, d2);
}

// Box signed distance function
// float sdBox(in vec2 p, in vec2 b) {
//     vec2 d = abs(p) - b;
//     return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
// }

void main() {

    vec2 uv1 = vUv;
    vec2 uv0 = vUv0;

    // Flip the y-coordinate for the bottom half of the screen
    if (uv1.y < 0.5) {
        uv1.y = 1.0 - uv1.y;
        uv0.y = 1.0 - uv0.y;
    }

    uv0 = fract(uv0 * 1.0) - 0.5;

    vec3 finalColor = vec3(0.0);

    // Define the radius and tb parameters for the circle wave
    float radius = 0.3; // Adjust this value to control the size of the wave circles
    float tb = 1.0; // Adjust this value to control the wave shape

    for (float i = 0.0; i < 3.0; i++) {
        uv1 = fract(uv1 * 2.0) - 0.5;
        float d = sdCircleWave(uv1, tb, radius) * exp(-length(uv0)); // Using sdCircleWave
        
        vec3 col = palette(length(uv0) + (i * 0.8) + u_Time * 0.000005);

        d = sin(d * 12.0 + (u_Time * 0.0005)) / 4.0;
        d = abs(d);
        d = pow(0.03 / d, 1.0);

        finalColor += col * d;
    }

    gl_FragColor = vec4(finalColor, 1.0);
}
