//
//  ViewController.swift
//  HelloAR
//
//  Created by Peter Pohlmann on 01.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var sphere = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentationWithDepth

        // Run the view's session
        sceneView.session.run(configuration)
        
 //       drawSphereAtOrigin()
         drawBoxAt1200Hight()
//        drawPyramid()
//        drawPlane()
//        drawTorus()
//        drawOrbitingShip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    func drawOrbitingShip() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        let ship = (scene!.rootNode.childNode(withName: "ship", recursively: false))!
        ship.position = SCNVector3(1, 0, 0)
        ship.scale = SCNVector3(0.3, 0.3, 0.3)
        ship.eulerAngles = SCNVector3(0, 180.deegreesToRadiants(), 0)
        sphere.addChildNode(ship)
    }
    
    func drawSphereAtOrigin() {
        sphere = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        sphere.position = SCNVector3(0, 0, 0)
        sceneView.scene.rootNode.addChildNode(sphere)
        
        let rotationAction = SCNAction.rotate(by: 360.deegreesToRadiants(), around: SCNVector3(0, 1, 0), duration: 8)
        let rotateForever = SCNAction.repeatForever(rotationAction)
        sphere.runAction(rotateForever)
    }
    
    func drawBoxAt1200Hight() {
        let box = SCNNode(geometry: SCNBox(width: 100, height: 100, length: 1, chamferRadius: 0))
        box.position = SCNVector3(0, -1, -100)
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        //box.geometry?.firstMaterial?.specular.contents = UIColor.white
        sceneView.scene.rootNode.addChildNode(box)
        
        
        let box2 = SCNNode(geometry: SCNBox(width: 100, height: 100, length: 1, chamferRadius: 0))
        box2.position = SCNVector3(30, 0, -90)
        box2.eulerAngles = SCNVector3(0, 0.deegreesToRadiants(), 0)
        sceneView.scene.rootNode.addChildNode(box2)
        
        let box3 = SCNNode(geometry: SCNBox(width: 100, height: 100, length: 1, chamferRadius: 0))
        box3.position = SCNVector3(-30, 0, -80)
        box3.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "cat")
        box3.eulerAngles = SCNVector3(0, 0.deegreesToRadiants(), 0)
        sceneView.scene.rootNode.addChildNode(box3)
    }
    
    func drawPyramid() {
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramid.position = SCNVector3(0, -0.2, 0.3)
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        pyramid.geometry?.firstMaterial?.specular.contents = UIColor.white
        sceneView.scene.rootNode.addChildNode(pyramid)
    }
    
    func drawPlane() {
        let plane = SCNNode(geometry: SCNPlane(width: 2.2, height: 2.1))
        plane.position = SCNVector3(-0.2, -0.2, -2)
        plane.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        plane.geometry?.firstMaterial?.isDoubleSided = true
        sceneView.scene.rootNode.addChildNode(plane)
    }
    
    func drawTorus() {
        let torus = SCNNode(geometry: SCNTorus(ringRadius: 0.05, pipeRadius: 0.03))
        torus.position = SCNVector3(0.2, 0, 0)
        torus.eulerAngles = SCNVector3(0, 0, 45.deegreesToRadiants())
        torus.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        torus.geometry?.firstMaterial?.specular.contents = UIColor.white
        sceneView.scene.rootNode.addChildNode(torus)
        
    }
    
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }

}


extension Int {
    func deegreesToRadiants() -> CGFloat {
        return CGFloat(self) * CGFloat.pi / 180.0
    }
}
