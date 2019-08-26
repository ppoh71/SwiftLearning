import Foundation
import SceneKit
import SpriteKit

enum ShapeTypes {
  case Greenscreen
  case Display
}

enum MaterialType {
  case Image
  case Video
}

struct Studio {
  private let uuid: String
  private var activeGS: Greenscreen {
    didSet {
      print("do something when setting")
      saveActiveGreenscreenToStudio()
    }
  }
  
  public var activeGreenscreen: Greenscreen {
    get { return self.activeGS }
  }
  
  private var studioGreenscreens: [String: Greenscreen] = [:]
  
  init(uuid: String) {
    self.uuid = uuid
    
    // get new uuid and init greensceen
    let uuidGreenscreen = UUID().uuidString
    let newGreenscreen = Greenscreen(uuid: uuidGreenscreen)
    self.activeGS = newGreenscreen
  }

}

extension Studio {
  /// Appends basepoints for a greenscreen to the activeGreenscreen
  ///
  /// - Parameters:
  ///   - uuid: The uuid of the greenscreen
  ///   - basePoint: A ground point set by the user for a greenscreen as SCNVector3
  mutating func appendBasepointForActiveGreenscreen(uuid: String, basePoint: SCNVector3) {
    if uuid == self.activeGS.uuid{
      self.activeGS.basePoints.append(basePoint)
    }
  }
  
  /// Set all basepoints for a greenscreen to the activeGreenscreen
  ///
  /// - Parameters:
  ///   - uuid: The uuid of the greenscreen
  ///   - basePoints: A array of SCNVector3 for the greenscreen base points
  mutating func setBasepointsForActiveGreenscreen(uuid: String, basePoints: [SCNVector3]) {
    if uuid == self.activeGS.uuid {
          self.activeGS.basePoints = basePoints
    }
  }
  
  /// Sets the new heightfor a greenscreen to the activeGreenscreen
  ///
  /// - Parameters:
  ///   - uuid: The uuid of the greenscreen
  ///   - height: A float for the height
  mutating func setHeightForActiveGreenscreen(uuid: String, height: Float) {
    if uuid == self.activeGS.uuid {
              self.activeGS.height = height
    }
  }
  
  /// Sets a new height and also a newly generated greenscreenNode
  ///
  /// - Parameters:
  ///   - uuid: The uuid of the greenscreen
  ///   - height: A float for the height
  ///   - greenscreenNode:  A newly vreated greenscreen SCNNode
  mutating func setNewGeometryForActiveGreenscreen(uuid: String, height: Float, greenscreenNode: SCNNode) {
    if uuid == self.activeGS.uuid {
      self.activeGS.height = height
      self.activeGS.greenscreenNode = greenscreenNode

    }
  }
  
  /// Sets a new height and also a newly generated greenscreenNode
  ///
  /// - Parameters:
  ///   - uuid: The uuid of the greenscreen
  ///   - aspectRatio: A float for aspectRatio from an image or video (width/height)
  ///   - materialType:  The type of the material: image or video
  ///   - videoNode: An optional videonode, this will be used to controll the video (play, pause, resume)
  mutating func setMaterialForActiveGreenscreen(uuid: String, aspectRatio: Float, materialType: MaterialType, materialName: String, videoNode: SKVideoNode? ) {
      if uuid == self.activeGS.uuid {
        self.activeGS.materialAspectRatio = aspectRatio
        self.activeGS.materialType = materialType
        self.activeGS.materialName = materialName
        
        if let videoNode = videoNode {
          self.activeGS.videoNode = videoNode
        }
        
      }
    }
  
  /// Saves the actual greenscren to the studio greenscreen dictionary
  mutating func saveActiveGreenscreenToStudio() {
    studioGreenscreens[self.activeGS.uuid] = self.activeGreenscreen
    print("Updating: \(studioGreenscreens[self.activeGS.uuid])")
  }
  
}


struct Greenscreen {
  let uuid: String
  var basePoints = [SCNVector3]()
  var height: Float = 0.0
  
  var greenscreenNode = SCNNode()
  var materialAspectRatio: Float?
  var materialType: MaterialType?
  var materialName: String?
  var videoNode: SKVideoNode?
  
  var displays = [Display]()
}

struct Display {
  let uuid: String = ""
  let points = [SCNVector3]()
  var materialAspectRatio: Float?
  var materialType: MaterialType?
  var materialName: String?
  var videoNode: SKVideoNode?
}


var studio = Studio(uuid: "xx")
studio.activeGreenscreen.uuid


// append basepoints
studio.appendBasepointForActiveGreenscreen(uuid: "xx", basePoint: SCNVector3(1, 1, 2))
studio.activeGreenscreen.basePoints

// set basepoints
studio.setBasepointsForActiveGreenscreen(uuid: "xx", basePoints: [SCNVector3(1, 1, 2), SCNVector3(1, 1, 2), SCNVector3(1, 1, 2)])
studio.activeGreenscreen.basePoints

// set geometry

