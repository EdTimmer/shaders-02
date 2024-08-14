precision mediump float;

uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelViewMatrix;
uniform float u_Time;
uniform vec2 u_Resolution;

attribute vec3 position;
attribute vec2 uv;

varying vec2 vUv;
varying vec2 vUv0;

void main() {
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    vUv = uv;
    vUv0 = uv;
}