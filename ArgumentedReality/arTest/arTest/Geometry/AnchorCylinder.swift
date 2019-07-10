//
//  anchorCylinder.swift
//  arvisto
//
//  Created by Peter Pohlmann on 06.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import ARKit

class AnchorCylinder: SCNNode {
  var planeGeometry = SCNBox()
  
  init(anchor: ARPlaneAnchor) {
    super.init()
    
    // create cylinder
    let cylinder = SCNCylinder(radius: 0.2, height: 0.01)
    let node = SCNNode(geometry: cylinder)
    node.position = SCNVector3(anchor.center.x, -0.02, anchor.center.z)
    
    // add node
    self.addChildNode(node)
  }
  
  func updateWith(_ anchor: ARPlaneAnchor) {
    // position
    self.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init coder not implementet")
  }
  
}
