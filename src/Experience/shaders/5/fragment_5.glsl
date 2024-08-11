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

// Hexagon shape function
float sdHexagon( in vec2 p, in float r ) {
    const vec3 k = vec3(-0.866025404,0.5,0.577350269);
    p = abs(p);
    p -= 2.0*min(dot(k.xy,p),0.0)*k.xy;
    p -= vec2(clamp(p.x, -k.z*r, k.z*r), r);
    return length(p)*sign(p.y);
}

float dot2( in vec2 v ) { return dot(v,v); }

float sdHeart( in vec2 p ) {
    p.x = abs(p.x);

    if( p.y+p.x>1.0 )
        return sqrt(dot2(p-vec2(0.25,0.75))) - sqrt(2.0)/4.0;
    return sqrt(min(dot2(p-vec2(0.00,1.00)),
                    dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
}

void main() {

    vec2 uv1 = vUv;
    vec2 uv0 = vUv0;

    // Flip the y-coordinate for the bottom half of the screen
    if (uv1.y < 0.5) {
        uv1.y = 1.0 - uv1.y;
        uv0.y = 1.0 - uv0.y;
    }

    uv0 = fract(uv0 * 3.0) - 0.5;

    vec3 finalColor = vec3(0.0);

    // Hexagram size (adjust as needed)
    // float r = 0.3;

    for (float i = 0.0; i < 3.0; i++) {
        uv1 = fract(uv1 * 2.0) - 0.5;
        float d = sdHeart(uv1) * exp(-length(uv0));
        vec3 col = palette(length(uv0) + (i * 0.4) + u_Time * 0.00005);

        d = sin(d * 8.0 + (u_Time * 0.001)) / 8.0;
        d = abs(d);
        d = pow(0.01 / d, 0.9);

        finalColor += col * d;
    }

    gl_FragColor = vec4(finalColor, 1.0);
}
