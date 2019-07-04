//
//  Geometry+Extension.swift
//  Prototype-ScreenPlaner
//
//  Created by Peter Pohlmann on 04.07.19.
//  Copyright © 2019 Peter Pohlmann. All rights reserved.
//
import UIKit
import ARKit
import Foundation
import SceneKit

extension SCNGeometry {
  
  // create thick lines, shaders.metal needed
  static func multiPointsLine(points: [SCNVector3], width:Int = 20, closed: Bool = false, color: CGColor = UIColor.black.cgColor, mitter: Bool = false) -> SCNNode {
    
    // Becouse we cannot use geometry shaders in metal, every point on the line has to be changed into 4 verticles
    let vertices: [SCNVector3] = points.flatMap { p in [p, p, p, p] }
    
    // Create Geometry Source object
    let source = SCNGeometrySource(vertices: vertices)
    
    // Create Geometry Element object
    var indices = Array((0..<Int32(vertices.count)))
    if (closed) {
      indices += [0, 1]
    }
    let element = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
    
    // Prepare data for vertex shader
    // Format is line width, number of points, should mitter be included, should line create closed loop
    let lineData: [Int32] = [Int32(width), Int32(points.count), Int32(mitter ? 1 : 0), Int32(closed ? 1 : 0)]
    
    let geometry = SCNGeometry(sources: [source], elements: [element])
    geometry.setValue(Data(bytes: lineData, count: MemoryLayout<Int32>.size*lineData.count), forKeyPath: "lineData")
    
    // map verticles into float3
    let floatPoints = vertices.map { SIMD3<Float>($0) }
    geometry.setValue(NSData(bytes: floatPoints, length: MemoryLayout<SIMD3<Float>>.size * floatPoints.count), forKeyPath: "vertices")
    
    // map color into float
    let colorFloat = color.components!.map { Float($0) }
    geometry.setValue(NSData(bytes: colorFloat, length: MemoryLayout<simd_float1>.size * color.numberOfComponents), forKey: "color")
    
    // Set the shader program
    let program = SCNProgram()
    program.fragmentFunctionName = "thickLinesFragment"
    program.vertexFunctionName = "thickLinesVertex"
    geometry.program = program
    
    let lineNode = SCNNode(geometry: geometry)
    return lineNode;
  }
  
  // create GReenScreen Plane from added vertices
  static func createtPlane(planeVertices: [SCNVector3]) -> SCNNode {
    let src = SCNGeometrySource(vertices: planeVertices)
    
    let indices: [UInt32] = [0, 1, 2, 3]
    
    
    let normals = SCNGeometrySource(normals: [SCNVector3](repeating: SCNVector3(0, 0, 1), count: 4))
    
    let inds = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
    let geometry = SCNGeometry(sources: [src], elements: [inds])
    
    let shapeNode = SCNNode(geometry: geometry)
    shapeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
    shapeNode.geometry?.firstMaterial?.transparent.contents = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
    //shapeNode.geometry?.firstMaterial?.specular.contents = UIColor.white
    shapeNode.geometry?.firstMaterial?.lightingModel = .constant
    
    shapeNode.geometry?.firstMaterial?.isDoubleSided = true
    return shapeNode
    
  }
  
  // add node per each added position for GreenScreen
  static func cornerNodeAtPosition(_ position: SCNVector3) -> SCNNode {
    let sphere = SCNSphere(radius: 0.01)
    sphere.firstMaterial?.diffuse.contents = UIColor.white
    
    let node = SCNNode(geometry: sphere)
    node.position = position
    
    return node
  }
  
  // get add height to a given point
  static func addHeightToPoint(point: SCNVector3, height: Float) -> SCNVector3{
    let pointPlusHeight = SCNVector3(point.x, point.y + height, point.z)
    return pointPlusHeight
  }
  
  // get add height to a given point array
  static func addHeightToPointArray(points: [SCNVector3], height: Float) -> [SCNVector3] {
    var heightPoints = [SCNVector3]()
    
    // add height to each points
    for point in points {
      let pointPlusHeight = SCNVector3(point.x, point.y + height, point.z)
      heightPoints.append(pointPlusHeight)
    }
    return heightPoints
  }
}
