import * as THREE from "three";
import Experience from "../Experience";

export default class Environment {
  constructor() {
    this.experience = new Experience()
    this.scene = this.experience.scene
    this.resources = this.experience.resources
    this.debug = this.experience.debug

    // Debug
    // if (this.debug.active) {
    //   this.debugFolder = this.debug.ui.addFolder('environment')
    // }

    this.setSunLight()
    this.setEnvironmentMap()
  }

  setSunLight() {
    this.sunLight = new THREE.DirectionalLight('#ffffff', 1)
    this.sunLight.castShadow = true
    this.sunLight.shadow.camera.far = 15
    this.sunLight.shadow.mapSize.set(1024, 1024)
    this.sunLight.shadow.normalBias = 0.05
    this.sunLight.position.set(3.5, 2, -1.25)
    this.scene.add(this.sunLight)

    // Debug
    // if (this.debug.active) {
    //   this.debugFolder
    //     .add(this.sunLight, 'intensity')
    //     .name('sunLightIntensity')
    //     .min(0)
    //     .max(10)
    //     .step(0.001)

    //   this.debugFolder
    //     .add(this.sunLight.position, 'x')
    //     .name('sunLightX')
    //     .min(-5)
    //     .max(5)
    //     .step(0.001)

    //   this.debugFolder
    //     .add(this.sunLight.position, 'y')
    //     .name('sunLightY')
    //     .min(-5)
    //     .max(5)
    //     .step(0.001)
      
    //   this.debugFolder
    //     .add(this.sunLight.position, 'z')
    //     .name('sunLightZ')
    //     .min(-5)
    //     .max(5)
    //     .step(0.001)
    // }
  }

  setEnvironmentMap() {
    this.environmentMap = {}
    this.environmentMap.background = this.resources.items.background
    
    this.scene.environment = this.environmentMap.background
    // this.scene.background = this.environmentMap.background
  }
}