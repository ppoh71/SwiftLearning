//
//  ViewController.swift
//  ARKitWorkingWithWorldMapData
//
//  Created by Macbook on 8/11/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureLighting()
        addTapGestureToSceneView()
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didReceiveTapGesture(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didReceiveTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: sceneView)
        guard let hitTestResult = sceneView.hitTest(location, types: [.featurePoint, .estimatedHorizontalPlane]).first
            else { return }
        let anchor = ARAnchor(transform: hitTestResult.worldTransform)
        sceneView.session.add(anchor: anchor)
    }
    
    func generateSphereNode() -> SCNNode {
        let sphere = SCNSphere(radius: 0.05)
        let sphereNode = SCNNode()
        sphereNode.position.y += Float(sphere.radius)
        sphereNode.geometry = sphere
        return sphereNode
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func resetBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
        resetTrackingConfiguration()
    }
    
    @IBAction func saveBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func loadBarButtonItemDidTouch(_ sender: UIBarButtonItem) {
        
    }
    
    func resetTrackingConfiguration(with worldMap: ARWorldMap? = nil) {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        
        sceneView.debugOptions = [.showFeaturePoints]
        sceneView.session.run(configuration, options: options)
    }
    
    func setLabel(text: String) {
        label.text = text
    }
    
}


extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard !(anchor is ARPlaneAnchor) else { return }
        let sphereNode = generateSphereNode()
        DispatchQueue.main.async {
            node.addChildNode(sphereNode)
        }
    }
    
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.70)
    }
}
