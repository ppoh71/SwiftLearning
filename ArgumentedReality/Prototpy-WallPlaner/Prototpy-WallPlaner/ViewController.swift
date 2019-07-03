//
//  ViewController.swift
//  Prototpy-WallPlaner
//
//  Created by Peter Pohlmann on 03.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var tagetIcon: UIImageView!
  @IBOutlet weak var addNodeButton: UIButton!
  
  var shapeVertices = [SCNVector3]()
  
  @IBAction func addButtonNodeTapped(_ sender: Any) {
    
    if let position = self.doHitTestOnExistingPlanes() {
      let basePosition = position
      let baseYPosition = SCNVector3(basePosition.x, basePosition.y + 3, basePosition.z)
  
      // create ground node
      let baseNode = self.nodeWithPosition(basePosition)
      sceneView.scene.rootNode.addChildNode(baseNode)
      startNode = baseNode
      
      // create height node perpendicular to base node
      let baseHeightNode = self.nodeWithPosition(baseYPosition)
      sceneView.scene.rootNode.addChildNode(baseHeightNode)

      shapeVertices.append(basePosition)
      shapeVertices.append(baseYPosition)
      
      if shapeVertices.count == 4 {
        let plane = getPlane(planeVertices: shapeVertices)
        sceneView.scene.rootNode.addChildNode(plane)
        shapeVertices = [SCNVector3]()
      }
      
    }
  }
  
  var startNode: SCNNode?
  var endNode: SCNNode?
  
  var lineNode: SCNNode?
  var addLine = SCNNode()
  var greenScreenLine: SCNNode?
  var dictPanes = [ARPlaneAnchor: PlanerPlane]()
  
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


    // HitTest Function
    func doHitTestOnExistingPlanes() -> SCNVector3? {
      let results = sceneView.hitTest(view.center, types: .existingPlaneUsingExtent)
      
      if let result = results.first {
        let hitPos = self.positionFromTransform(result.worldTransform)
        return hitPos
      }
      return nil
    }
  
    // Add MarkerNodes
    func nodeWithPosition(_ position: SCNVector3) -> SCNNode {
      let sphere = SCNSphere(radius: 0.01)
      sphere.firstMaterial?.diffuse.contents = UIColor.white
      
      let node = SCNNode(geometry: sphere)
      node.position = position
      
      return node
    }
  
    // Draw Lines
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
  
    func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
      return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
  
    // draw shape
  func getPlane(planeVertices: [SCNVector3]) -> SCNNode {
    
//      let indices: [UInt32] = [0, 1, 2, 3]
//      let source = SCNGeometrySource(vertices: planeVertices)
//      let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
//
//      let shape = SCNShape(sources: [source], elements: [element])
//      shape.firstMaterial?.diffuse.contents = UIColor.red
//      shape.firstMaterial?.isDoubleSided = true
//
//      let shapeNode = SCNNode(geometry: shape)
//      return shapeNode
    
    let src = SCNGeometrySource(vertices: planeVertices)
    let indices: [UInt32] = [0, 1, 2, 3]
    let normals = SCNGeometrySource(normals: [SCNVector3](repeating: SCNVector3(0, 0, 1), count: 4))
    let textureMap = SCNGeometrySource(textureCoordinates: [
      CGPoint(x: 0, y: 1),
      CGPoint(x: 1, y: 1),
      CGPoint(x: 0, y: 0),
      CGPoint(x: 1, y: 0)
    ])
    let inds = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
    let geometry = SCNGeometry(sources: [src, normals], elements: [inds])
    
    let shapeNode = SCNNode(geometry: geometry)
    shapeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
    shapeNode.geometry?.firstMaterial?.specular.contents = UIColor.white
     shapeNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
    
    shapeNode.geometry?.firstMaterial?.isDoubleSided = true
    
    return shapeNode
    
    }
  
}

// Mark: ARSCN Deletes
// =======================
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
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    //
    
    DispatchQueue.main.async {
      if let planeAnchor = anchor as? ARPlaneAnchor {
        
        let plane = PlanerPlane(anchor: planeAnchor)
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

