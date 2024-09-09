import * as THREE from 'three'
import Experience from '../Experience'
import vertexShader from '../shaders/10/vertex_10.glsl'
import fragmentShader from '../shaders/10/fragment_10.glsl'

export default class SurfaceFive {
  constructor() {
    this.experience = new Experience();
    this.scene = this.experience.scene;
    this.camera = this.experience.camera.instance;
    this.mouse = new THREE.Vector2();
    this.raycaster = new THREE.Raycaster();
    // this.environmentMap = this.experience.resources.items.environmentMap;
    this.avaImage  = this.experience.resources.items.avaImage;

    // this.textureLoader = new THREE.TextureLoader();
    // this.oilTexture = this.textureLoader.load('/background/ava.jpg');

    this.setMaterial()
    this.setGeometry()
    this.setMesh()
    this.update()
  }

  setMaterial() {
    if (this.avaImage) {
      this.material = new THREE.RawShaderMaterial({
        vertexShader: vertexShader,
        fragmentShader: fragmentShader,
        transparent: true, 
        side: THREE.DoubleSide,
        metalness: 1.0,
        roughness: 0.0,
        uniforms: {
          u_Frequency: { value: new THREE.Vector2(0.1, 0.05) },
          u_Time: { value: 0.0 },
          u_Texture: { value: this.avaImage }
        }
      });
    }
  }

  setGeometry() {
    // this.geometry = new THREE.PlaneGeometry(50, 50, 32, 32);
    // this.geometry = new THREE.SphereGeometry(26, 32, 32);
    this.geometry = new THREE.BoxGeometry(50, 50, 50, 32, 32, 32);
    // this.geometry = new THREE.TorusGeometry(20, 16, 16, 100);
    // this.geometry = new THREE.IcosahedronGeometry(26, 0);
  }

  setMesh() {
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.mesh.position.set(0, 0, 0);

    this.meshPosition = this.mesh.position;
    this.meshQuaternion = this.mesh.quaternion;
    this.scene.add(this.mesh);

    // // Calculate resolution based on bounding box
    // const boundingBox = new THREE.Box3().setFromObject(this.mesh);
    // const size = new THREE.Vector3();
    // boundingBox.getSize(size);

    // // Scale the resolution based on the mesh size (you can adjust the scaling factor as needed)
    // const resolutionX = size.x * 100; // Adjust scaling factor as needed
    // const resolutionY = size.y * 100;
    // this.material.uniforms.u_Resolution.value.set(resolutionX, resolutionY);
  } 

  update() {    
    this.material.uniforms.u_Time.value = this.experience.time.getElapsedTime().toFixed(2);
    // this.mesh.rotation.y += 0.01;
    // this.mesh.rotation.x += 0.01;
  }
}