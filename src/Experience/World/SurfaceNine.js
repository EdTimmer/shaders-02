import * as THREE from 'three'
import Experience from '../Experience'
import vertexShader from '../shaders/8/vertex_8.glsl'
import fragmentShader from '../shaders/8/fragment_8.glsl'

export default class SurfaceNine {
  constructor() {
    this.experience = new Experience();
    this.scene = this.experience.scene;
    this.camera = this.experience.camera.instance;
    this.mouse = new THREE.Vector2();
    this.raycaster = new THREE.Raycaster();
    this.environmentMap = this.experience.resources.items.environmentMap;

    this.setMaterial()
    this.setGeometry()
    this.setMesh()
    this.update()
  }

  setMaterial() {
    // this.material = new THREE.RawShaderMaterial({
    //   vertexShader: vertexShader,
    //   fragmentShader: fragmentShader,
    //   transparent: true, 
    //   side: THREE.DoubleSide,
    //   uniforms: {
    //     u_Time: { value: 0.0 },
    //     u_Resolution: { value: new THREE.Vector2(window.innerWidth, window.innerHeight) },
    //   },
    // })
    this.material  = new THREE.MeshPhysicalMaterial({
      color: 0x000000,
      // color: 'white',
      metalness: 1.0,
      roughness: 0.0,
      // envMap: this.environmentMap,
      envMapIntensity: 0.1,
      opacity: 1.0,
    });

    

  }

  setGeometry() {
    // this.geometry = new THREE.PlaneGeometry(50, 50, 32, 32);
    // this.geometry = new THREE.SphereGeometry(26, 32, 32);
    // this.geometry = new THREE.BoxGeometry(50, 50, 50, 32, 32, 32);
    this.geometry = new THREE.TorusGeometry(18, 10, 16, 100);
  }

  setMesh() {
    this.mesh = new THREE.Mesh(this.geometry, this.material);
    this.mesh.position.set(60, -60, 0);

    this.meshPosition = this.mesh.position;
    this.meshQuaternion = this.mesh.quaternion;
    this.scene.add(this.mesh);

    // Calculate resolution based on bounding box
    // const boundingBox = new THREE.Box3().setFromObject(this.mesh);
    // const size = new THREE.Vector3();
    // boundingBox.getSize(size);

    // // Scale the resolution based on the mesh size (you can adjust the scaling factor as needed)
    // const resolutionX = size.x * 100; // Adjust scaling factor as needed
    // const resolutionY = size.y * 100;
    // this.material.uniforms.u_Resolution.value.set(resolutionX, resolutionY);
  } 

  update() {    
    // this.material.uniforms.u_Time.value = this.experience.time.getElapsedTime().toFixed(2);
    this.mesh.rotation.y += 0.01;
    this.mesh.rotation.x += 0.01;
  }
}