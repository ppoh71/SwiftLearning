//
//  GroundPlane.swift
//  arvisto
//
//  Created by Peter Pohlmann on 06.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import ARKit

class GroundPlane: SCNNode {
  var planeGeometry = SCNBox()
  
  init(anchor: ARPlaneAnchor) {
    super.init()
    let width = CGFloat(anchor.extent.x)
    let length = CGFloat(anchor.extent.z)
    let planeHeight = 0.01 as CGFloat
    
    self.planeGeometry = SCNBox(width: width, height: planeHeight, length: length, chamferRadius: 0)
    
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.lightGray
    
    let transparentMaterial = SCNMaterial()
    transparentMaterial.diffuse.contents = UIColor.clear
    
    planeGeometry.materials = [transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial]
    
    // create node
    let planeNode = SCNNode(geometry: self.planeGeometry)
    planeNode.position = SCNVector3(0, -0.5, 0)
    
    // add node
    //self.addChildNode(planeNode)
    //setTextureScale()
    
  }
  
  
  func updateWith(_ anchor: ARPlaneAnchor) {
    
    //update pane with new Anchor
    self.planeGeometry.width = CGFloat(anchor.extent.x)
    self.planeGeometry.length = CGFloat(anchor.extent.z)
    
    // position
    self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    setTextureScale()
    
  }
  
  func setTextureScale() {
    
    let width = self.planeGeometry.width
    let length = self.planeGeometry.length
    
    // scaling grid texture
    let material = self.planeGeometry.materials[4]
    material.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(length), 1)
    material.diffuse.wrapS = .repeat
    material.diffuse.wrapT = .repeat
  }
  
  required init?(coder: NSCoder) {
    fatalError("init coder not implementet")
  }
  
}
