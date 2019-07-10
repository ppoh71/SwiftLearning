//
//  GroundMesh.swift
//  arvisto
//
//  Created by Peter Pohlmann on 05.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import ARKit

class GroundMesh: SCNNode {
  let meshNode: SCNNode
  var classificationNode: SCNNode?
  
  /// - Tag: VisualizePlane
  init(anchor: ARPlaneAnchor, in sceneView: ARSCNView) {
    
    // Create a mesh to visualize the estimated shape of the plane.
    guard let meshGeometry = ARSCNPlaneGeometry(device: sceneView.device!) else {
      fatalError("Can't create plane geometry")
    }
    
    meshGeometry.update(from: anchor.geometry)
    meshNode = SCNNode(geometry: meshGeometry)
    
    super.init()
    self.setupMeshVisualStyle()
   // addChildNode(meshNode)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupMeshVisualStyle() {
    // Make the plane visualization semitransparent to clearly show real-world placement.
    meshNode.opacity = 0
    
    // Use color and blend mode to make planes stand out.
    guard let material = meshNode.geometry?.firstMaterial
      else {
        print("ARSCNPlaneGeometry always has one material")
        return
    }
    
    material.diffuse.contents = UIColor.lightGray
    //material.fillMode = .lines
  }
  
}
