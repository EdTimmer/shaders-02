import * as THREE from "three"
import Experience from "../Experience"
import Environment from "./Environment"
import SurfaceFive from "./SurfaceFive"
import SurfaceFour from "./SurfaceFour"
import SurfaceThree from "./SurfaceThree"
import SurfaceTwo from "./SurfaceTwo"
import SurfaceOne from "./SurfaceOne"
import SurfaceSix from "./SurfaceSix"
import SurfaceSeven from "./SurfaceSeven"
import SurfaceEight from "./SurfaceEight"
import SurfaceNine from "./SurfaceNine"

export default class World {
  constructor() {
    this.experience = new Experience()
    this.scene = this.experience.scene
    this.camera = this.experience.camera
    this.resources = this.experience.resources
    this.debug = this.experience.debug
    // this.axisHelper = new THREE.AxesHelper(100)

    // this.scene.add(this.axisHelper)

    // Debug
    if (this.debug.active) {
      this.debugFolder = this.debug.ui.addFolder('world')
    }

    // Wait for resources
    this.resources.on('ready', () => {
      // Setup
      this.surfaceOne = new SurfaceFive();
      this.surfaceTwo = new SurfaceFour();
      this.surfaceThree = new SurfaceThree();
      this.surfaceFour = new SurfaceTwo();
      this.surfaceFive = new SurfaceOne();
      this.surfaceSix = new SurfaceSix();
      this.surfaceSeven = new SurfaceSeven();
      this.surfaceEight = new SurfaceEight();
      this.surfaceNine = new SurfaceNine();

      this.environment = new Environment()
           
      // Pass engineGroup to the camera
      this.camera.setTarget(this.surfaceOne.mesh)
    })
  }

  update() {
    if (this.camera) {
      this.camera.update()
    }
    if (this.surfaceOne) { 
      this.surfaceOne.update()
    }
    if (this.surfaceTwo) {
      this.surfaceTwo.update()
    }
    if (this.surfaceThree) {
      this.surfaceThree.update()
    }
    if (this.surfaceFour) {
      this.surfaceFour.update()
    }
    if (this.surfaceFive) {
      this.surfaceFive.update()
    }
    if (this.surfaceSix) {
      this.surfaceSix.update()
    }
    if (this.surfaceSeven) {
      this.surfaceSeven.update()
    }
    if (this.surfaceEight) {
      this.surfaceEight.update()
    }
    if (this.surfaceNine) {
      this.surfaceNine.update()
    }
  }
}