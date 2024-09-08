precision mediump float;

uniform float u_Time;
uniform vec2 u_Resolution;

varying vec2 vUv;
varying vec2 vUv0;

varying vec3 vNormal;
varying vec3 vViewPosition;

  vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
  vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
  vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

  float snoise(vec2 v) {
      const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);

      vec2 i = floor(v + dot(v, C.yy));
      vec2 x0 = v - i + dot(i, C.xx);
      vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
      vec2 x1 = x0.xy + C.xx - i1;
      vec2 x2 = x0.xy + C.zz;

      i = mod289(i);
      vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));

      vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
      m = m * m;
      m = m * m;

      vec3 x = 2.0 * fract(p * C.www) - 1.0;
      vec3 h = abs(x) - 0.5;
      vec3 ox = floor(x + 0.5);
      vec3 a0 = x - ox;

      m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

      vec3 g = vec3(0.0);
      g.x = a0.x * x0.x + h.x * x0.y;
      g.yz = a0.yz * vec2(x1.x, x2.x) + h.yz * vec2(x1.y, x2.y);

      return 130.0 * dot(m, g);
  }

  #define OCTAVES 1
  float fpm (in vec2 st) {
      float value = 0.0;
      float amplitude = 0.6;
      float frequency = 2.0;
      for (int i = 0; i < OCTAVES; i++) {
          value += amplitude * fract(snoise(st + snoise(vec2(st.y + u_Time * 0.00005, st.x))));
          st *= frequency;
          amplitude *= 0.5;
      }
      return value;
  }

  float pattern(in vec2 p, out vec2 q) {
      q.x = fpm(p + vec2(0.240, 0.670));
      q.y = fpm(p + vec2(5.2, 1.3));
      return fpm(p + q * 1.5);
  }

  void main() {
      // vec2 st = gl_FragCoord.xy / u_Resolution.y;
      vec2 st = vUv;
      vec3 color = vec3(0.0);
      vec2 q;
      float f = pattern(st * 0.2, q);

      color = vec3(1.000, 0.881, 0.631);
      color = mix(color, vec3(0.243, 0.646, 0.945), f);
      color = mix(color, vec3(0.220, 0.835, 0.352), q.x * q.x);
      color = mix(color, vec3(0.830, 0.626, 0.835), q.y * q.y * 2.0);
      color = mix(color, vec3(0.765, 0.975, 0.928), 0.5 * smoothstep(0.368, 0.844, abs(q.y) + abs(q.x)));

      vec2 ex = vec2(1.0 / u_Resolution.x, 0.0);
      vec2 ey = vec2(0.0, 1.0 / u_Resolution.y);
      vec3 nor = normalize(vec3(fpm(st + ex) - f, ex.x, fpm(st + ey) - f));

      vec3 lig = normalize(vec3(0.8, -0.5, -0.47));
      float dif = clamp(0.9 + 0.1 * dot(nor, lig), 0.0, 1.0);

      vec3 bdrf = vec3(0.924, 0.965, 0.922) * (nor.y * 0.5 + 0.5);
      bdrf += vec3(0.030, 0.036, 0.050) * dif;
      bdrf = vec3(0.85, 0.90, 0.95) * (nor.y * 0.5 + 0.5);
      bdrf += vec3(0.545, 0.474, 0.351) * dif;

      color *= bdrf;
      color *= vec3(1.0, 1.0, 1.15);
      vec2 p = gl_FragCoord.xy / u_Resolution.xy;
      color *= 0.5 + 0.5 * sqrt(40.0 * p.x * p.y * (1.0 - p.x) * (1.0 - p.y));

      gl_FragColor = vec4(color, 1.0);
  }