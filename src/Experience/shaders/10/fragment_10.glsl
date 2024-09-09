precision mediump float;

uniform sampler2D u_Texture;

varying float v_PositionZ;
varying vec2 vUv;
varying float v_Elevation;

void main() {
    // vec3 color = vec3(v_PositionZ * 0.5, 0.2, 0.8);

    vec4 textureColor = texture2D(u_Texture, vUv);
    textureColor.rgb *= v_Elevation * 0.1 + 1.0;
    
    // gl_FragColor = vec4(color, 1.0);
     gl_FragColor = textureColor;
}
