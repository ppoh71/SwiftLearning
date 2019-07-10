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
  
  var pointsForGreenScreen = [SCNVector3]()
  var baseLineGreenScreen: SCNNode?
  var heightLineGreenScreen: SCNNode?
  var pointHeightForGreenScreen: Float = 0.5
  var nextConnectPointForGreenScreen = SCNNode()
  var dictPanes = [ARPlaneAnchor: GroundMesh]()
  var finishCreatingPointsForGreenScreen = false
  
  var allGreenScreensInStudio: [GreenScreen]?
  
  
  @IBAction func addButtonNodeTapped(_ sender: Any) {
    addPointToGreenScreen()
  }
  
  @IBAction func planGreenScreenFinishTapped(_ sender: Any) {
    connectAllPointsForGeeenScreen()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupScene()
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
  
  fileprivate func setupScene() {
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    sceneView.autoenablesDefaultLighting = true
    
    // Create a new scene
    let scene = SCNScene()
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    
    // Set the scene to the view
    sceneView.scene = scene
  }
  
  // connect base lines to form GreenScreen Shape
  fileprivate func addPointToGreenScreen() {
    finishCreatingPointsForGreenScreen = false
    
    // check if we have a ground planeAnchor
    if let position = self.doHitTestOnExistingPlanes() {
      
      //set current position as point for GreenScreen
      let basePointGreenScreen = position
  
      // add point to array to get the whole greenScreen model
      pointsForGreenScreen.append(basePointGreenScreen)
      
      // create corner ground node
      let baseNode = SCNGeometry.cornerNodeAtPosition(basePointGreenScreen)
      sceneView.scene.rootNode.addChildNode(baseNode)
    
      // finally add line from points
      if pointsForGreenScreen.count >= 2 {
        self.baseLineGreenScreen?.removeFromParentNode()
        self.baseLineGreenScreen = SCNGeometry.multiPointsLine(points: pointsForGreenScreen, width: 5, closed: false, color: UIColor.red.cgColor, mitter: false)
        self.sceneView.scene.rootNode.addChildNode(self.baseLineGreenScreen!)
      }
      
    }
  }
  
  fileprivate func connectAllPointsForGeeenScreen() {
    finishCreatingPointsForGreenScreen = true
    
    //get height points from base points
    let baseLinePoints = pointsForGreenScreen
    let heightPoints = SCNGeometry.addHeightToPointArray(points: baseLinePoints, height: pointHeightForGreenScreen)
    
    // add height point nodes
    for point in heightPoints {
      print("add height node")
      let heightNode = SCNGeometry.cornerNodeAtPosition(point)
      sceneView.scene.rootNode.addChildNode(heightNode)
    }
    
    // connect height points with line
    if baseLinePoints.count >= 2 {
      self.heightLineGreenScreen?.removeFromParentNode()
      self.heightLineGreenScreen = SCNGeometry.multiPointsLine(points: heightPoints, width: 5, closed: false, color: UIColor.red.cgColor, mitter: false)
      self.sceneView.scene.rootNode.addChildNode(self.heightLineGreenScreen!)
    }
    
    // connect the height lines betwwen base and height points
    for (index,point) in baseLinePoints.enumerated() {
      var points = [SCNVector3]()
      points.append(point)
      points.append(heightPoints[index])
      self.heightLineGreenScreen = SCNGeometry.multiPointsLine(points: points, width: 5, closed: false, color: UIColor.red.cgColor, mitter: false)
      self.sceneView.scene.rootNode.addChildNode(self.heightLineGreenScreen!)
    }
    
    // finally add GreenScreen Shape
    let nodeGreenScreen = SCNGeometry.createtPlane(baseLinePoints: baseLinePoints, height: pointHeightForGreenScreen)
    sceneView.scene.rootNode.addChildNode(nodeGreenScreen)
    

    // save greenscreen and prepare for new greenscreen
    let newGreenScreen = GreenScreen(nodeGreenScreen: nodeGreenScreen, baseLinePoints: baseLinePoints)
    allGreenScreensInStudio?.append(newGreenScreen)
    pointsForGreenScreen = [SCNVector3]()
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
  
  func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
    return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
  }
  
  // draw shape
  
  
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
    
    // add connecting line
    // when moving throuh space to connect next point
    DispatchQueue.main.async {
      guard let currentPosition = self.doHitTestOnExistingPlanes() else {
          return
      }
      
      self.nextConnectPointForGreenScreen.removeFromParentNode()
      
      guard self.finishCreatingPointsForGreenScreen == false, self.pointsForGreenScreen.count >= 1
      else { return }
      
      if let lastPoint = self.pointsForGreenScreen.last {
        self.nextConnectPointForGreenScreen = SCNGeometry.multiPointsLine(points: [lastPoint, currentPosition], width: 5, closed: false, color: UIColor.red.cgColor, mitter: false)
        self.sceneView.scene.rootNode.addChildNode(self.nextConnectPointForGreenScreen)
      }
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
    // Add GroundMesh when PlaneAnchor was added
    DispatchQueue.main.async {
      
      if let planeAnchor = anchor as? ARPlaneAnchor {
        // Create a custom object to visualize the plane geometry and extent.
        let groundMesh = GroundMesh(anchor: planeAnchor, in: self.sceneView)
        
        // Add the visualization to the ARKit-managed node so that it tracks
        // changes in the plane anchor as plane estimation continues.
        node.addChildNode(groundMesh)
        
        // each anchor gets a mesh assigned
        self.dictPanes[planeAnchor] = groundMesh
        
      }
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    
    // update GroundMesh when Anchor collects more infos while moving throu world
    DispatchQueue.main.async {
      
      if let planeAnchor = anchor as? ARPlaneAnchor {
        if let groundMesh = self.dictPanes[planeAnchor] {
          
          // Update ARSCNPlaneGeometry to the anchor's new estimated shape.
          if let planeGeometry = groundMesh.meshNode.geometry as? ARSCNPlaneGeometry {
            planeGeometry.update(from: planeAnchor.geometry)
          }
        }
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

