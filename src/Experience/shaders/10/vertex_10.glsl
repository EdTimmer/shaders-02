precision mediump float;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;
uniform vec2 u_Frequency;
uniform float u_Time;

attribute vec3 position;
attribute vec2 uv;

varying float v_PositionZ;
varying vec2 vUv;
varying float v_Elevation;

void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    float elevation = sin(modelPosition.x * u_Frequency.x - u_Time * 0.001) * 1.5;
    elevation += sin(modelPosition.y * u_Frequency.x - u_Time * 0.001) * 1.5;

    modelPosition.z += elevation;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;

    v_PositionZ = modelPosition.z / 3.0;

    vUv = uv;
    v_Elevation = elevation;
}