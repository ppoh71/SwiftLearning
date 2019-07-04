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
  
  // create thin line between 2 points, with color
  static func createLine(startPoint: SCNVector3, endPoint: SCNVector3, color : UIColor) -> SCNNode {
    let vertices: [SCNVector3] = [startPoint, endPoint]
    let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data
    
    let vertexSource = SCNGeometrySource(data: data,
                                         semantic: .vertex,
                                         vectorCount: vertices.count,
                                         usesFloatComponents: true,
                                         componentsPerVector: 3,
                                         bytesPerComponent: MemoryLayout<Float>.size,
                                         dataOffset: 0,
                                         dataStride: MemoryLayout<SCNVector3>.stride)
    
    
    let indices: [Int32] = [ 0, 1]
    let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data
    let element = SCNGeometryElement(data: indexData,
                                     primitiveType: .line,
                                     primitiveCount: indices.count/2,
                                     bytesPerIndex: MemoryLayout<Int32>.size)
    
    let line = SCNGeometry(sources: [vertexSource], elements: [element])
    line.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
    line.firstMaterial?.diffuse.contents = color
    
    let lineNode = SCNNode(geometry: line)
    return lineNode;
    
  }
  
  // create thin line between multi points
  static func createMultiLine(lineVertices: [SCNVector3], color : UIColor) -> SCNNode {
    
    let vertices: [SCNVector3] = lineVertices
    let data = NSData(bytes: vertices, length: MemoryLayout<SCNVector3>.size * vertices.count) as Data
    
    let vertexSource = SCNGeometrySource(data: data,
                                         semantic: .vertex,
                                         vectorCount: vertices.count,
                                         usesFloatComponents: true,
                                         componentsPerVector: 3,
                                         bytesPerComponent: MemoryLayout<Float>.size,
                                         dataOffset: 0,
                                         dataStride: MemoryLayout<SCNVector3>.stride)
    
    
    
    // create indicices from lineVertices array
    // repeat vertices to connect as whole line
    var indices = [Int32]()
    for (index,_) in lineVertices.enumerated() {
      if index > 1 {
        indices.append(Int32(index - 1))
      }
        indices.append(Int32(index))
    }

    let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count) as Data
    let element = SCNGeometryElement(data: indexData,
                                     primitiveType: .line,
                                     primitiveCount: indices.count/2,
                                     bytesPerIndex: MemoryLayout<Int32>.size)
    
    let line = SCNGeometry(sources: [vertexSource], elements: [element])
    line.firstMaterial?.lightingModel = SCNMaterial.LightingModel.constant
    line.firstMaterial?.diffuse.contents = color
    
    let lineNode = SCNNode(geometry: line)
    return lineNode;
    
  }
  
  static func lineThrough(points: [SCNVector3], width:Int = 20, closed: Bool = false, color: CGColor = UIColor.black.cgColor, mitter: Bool = false) -> SCNNode {
    
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
}
