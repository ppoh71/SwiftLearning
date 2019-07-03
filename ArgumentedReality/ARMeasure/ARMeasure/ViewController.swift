//
//  ViewController.swift
//  ARMeasure
//
//  Created by Peter Pohlmann on 03.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var button: UIButton!
  
  var startNode: SCNNode?
  var endNode: SCNNode?
  
  var lineNode: SCNNode?
  var addLine = SCNNode()
  var greenScreenLine: SCNNode?
  var dictPanes = [ARPlaneAnchor: Plane]()
  
  
  @IBAction func actionButton(_ sender: Any) {
    print(button.tag)
    
    if let position = self.doHitTestOnExistingPlanes() {
     print("HIT POSITION: \(position)")
      
      if button.tag == 0 {
        print("Button Index 0")
        let node = self.nodeWithPosition(position)
        sceneView.scene.rootNode.addChildNode(node)
        startNode = node
        button.tag = 1
        
        
      } else {
        
        print("Button Index 1")
        let nodeEnd = self.nodeWithPosition(position)
        sceneView.scene.rootNode.addChildNode(nodeEnd)
        endNode = nodeEnd
        button.tag = 0
        
        if let startNode = startNode, let endNode = endNode {
          addLine = self.getDrawnLineFrom(pos1: startNode.position, toPos2: endNode.position)
          self.sceneView.scene.rootNode.addChildNode(addLine)
          
          //createGreenScreen()
        let shape = shapeFrom(vector: startNode.position, toVector: endNode.position)
        print("Shape")
        print()
        self.sceneView.scene.rootNode.addChildNode(shape)
          
          
        }
        
      }
    }
  }
  
  func shapeFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNNode{
    
    let indices: [Int32] = [0,1]
    let source = SCNGeometrySource(vertices: [vector1, vector2])
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    
    let shape = SCNShape(sources: [source], elements: [element])

    shape.extrusionDepth = 4.5
    shape.firstMaterial?.diffuse.contents = UIColor.red
    
    let shapeNode = SCNNode(geometry: shape)
    
    
    if let startPosition = startNode?.position {
      shapeNode.position = startPosition
      shape.firstMaterial?.diffuse.contents = UIColor.red
      shape.firstMaterial?.isDoubleSided = true
    }
    
    return shapeNode
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScene()
  }
  
  fileprivate func setupScene() {
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    sceneView.autoenablesDefaultLighting = true
    
    // Create a new scene
    let scene = SCNScene()
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    
    
    // Set the scene to the view
    sceneView.scene = scene
  }
  
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentation
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
  
  func doHitTestOnExistingPlanes() -> SCNVector3? {
    let results = sceneView.hitTest(view.center, types: .existingPlaneUsingExtent)
    
    if let result = results.first {
      let hitPos = self.positionFromTransform(result.worldTransform)
     
      return hitPos
    }
    
    return nil
  }
  
  func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
    return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
  }
  
  
  func nodeWithPosition(_ position: SCNVector3) -> SCNNode {
    let sphere = SCNSphere(radius: 0.003)
    sphere.firstMaterial?.diffuse.contents = UIColor.red
    
    let node = SCNNode(geometry: sphere)
    node.position = position
    
    return node
  }
  
  func createGreenScreen() {
    let path = UIBezierPath()
    
    if let startNode = startNode, let endNode = endNode {
      path.move(to: CGPoint(x: CGFloat(startNode.position.x), y: CGFloat(startNode.position.z) ))
      path.addLine(to: CGPoint(x: CGFloat(endNode.position.x), y: CGFloat(endNode.position.z) ))
      path.close()
      
      let shape = SCNShape(path: path, extrusionDepth: 0.01)
      let color = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
      shape.firstMaterial?.diffuse.contents = color
      shape.chamferRadius = 0.1
      
      
      let greenScreen = SCNNode(geometry: shape)
//      greenScreen.eulerAngles = SCNVector3(0, 90.deegreesToRadiants(), 0)
//      greenScreen.eulerAngles = SCNVector3(-90.deegreesToRadiants(), 0, 0)
      
      
      
      greenScreen.position = startNode.position
      print("Green Position \(greenScreen.position)")
      
      //add greenscreen
      sceneView.scene.rootNode.addChildNode(greenScreen)
    }
   
    
  }
  
}


extension ViewController: ARSCNViewDelegate {
  
  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
  }
  
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    //
    
    DispatchQueue.main.async {
      guard let currentPosition = self.doHitTestOnExistingPlanes(),
        let start = self.startNode else {
          return
      }
      
      self.lineNode?.removeFromParentNode()
      self.lineNode = self.getDrawnLineFrom(pos1: currentPosition, toPos2: start.position)
      self.sceneView.scene.rootNode.addChildNode(self.lineNode!)
      
    }
  }

  func  getDrawnLineFrom(pos1: SCNVector3, toPos2: SCNVector3) -> SCNNode {
    let line = lineFrom(vector: pos1, toVector: toPos2)
    let lineInBetween1 = SCNNode(geometry: line)
    return lineInBetween1
  }
  
  

  
  func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry{
    
    let indices: [Int32] = [0,1]
    let source = SCNGeometrySource(vertices: [vector1, vector2])
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    
    return SCNGeometry(sources: [source], elements: [element])
    
  }
  
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    //
    
    DispatchQueue.main.async {
      if let planeAnchor = anchor as? ARPlaneAnchor {
        
        let plane = Plane(anchor: planeAnchor)
        node.addChildNode(plane)
        self.dictPanes[planeAnchor] = plane
        
      }
    }
    
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    //
    DispatchQueue.main.async {
      if let planeAnchor = anchor as? ARPlaneAnchor {
        let plane = self.dictPanes[planeAnchor]
        plane?.updateWith(planeAnchor)
        
      }
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
    //
  }
  

  
  func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
    //
    
    if let planeAnchor = anchor as? ARPlaneAnchor {
      self.dictPanes.removeValue(forKey: planeAnchor)
    }
  }
  
}

extension Int {
  func deegreesToRadiants() -> CGFloat {
    return CGFloat(self) * CGFloat.pi / 180.0
  }
}
