//
//  RotateImage.swift
//  lazySacn
//
//  Created by Peter Pohlmann on 10.12.18.
//  Copyright © 2018 Peter Pohlmann. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageRotated(on degrees: CGFloat) -> UIImage {
        // Following code can only rotate images on 90, 180, 270.. degrees.
        let degrees = round(degrees / 90) * 90
        let sameOrientationType = Int(degrees) % 180 == 0
        let radians = CGFloat.pi * degrees / CGFloat(180)
        let newSize = sameOrientationType ? size : CGSize(width: size.height, height: size.width)
        
        UIGraphicsBeginImageContext(newSize)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return self
        }
        
        ctx.translateBy(x: newSize.width / 2, y: newSize.height / 2)
        ctx.rotate(by: radians)
        ctx.scaleBy(x: 1, y: -1)
        let origin = CGPoint(x: -(size.width / 2), y: -(size.height / 2))
        let rect = CGRect(origin: origin, size: size)
        ctx.draw(cgImage, in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? self
    }
    
        func resize(toTargetSize targetSize: CGSize) -> UIImage {
            // inspired by Hamptin Catlin
            // https://gist.github.com/licvido/55d12a8eb76a8103c753
            
            let newScale = self.scale // change this if you want the output image to have a different scale
            let originalSize = self.size
            
            let widthRatio = targetSize.width / originalSize.width
            let heightRatio = targetSize.height / originalSize.height
            
            // Figure out what our orientation is, and use that to form the rectangle
            let newSize: CGSize
            if widthRatio > heightRatio {
                newSize = CGSize(width: targetSize.width, height: targetSize.height)
            } else {
                newSize = CGSize(width: targetSize.width, height:  targetSize.height)
            }
            
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(origin: .zero, size: newSize)
            
            // Actually do the resizing to the rect using the ImageContext stuff
            let format = UIGraphicsImageRendererFormat()
            format.scale = newScale
            format.opaque = true
            let newImage = UIGraphicsImageRenderer(bounds: rect, format: format).image() { _ in
                self.draw(in: rect)
            }
            
            return newImage
        }

    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {
    
        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
        posX = ((contextSize.width - contextSize.height) / 2)
        posY = 0
        cgwidth = contextSize.height
        cgheight = contextSize.height
        } else {
        posX = 0
        posY = -CGFloat(height)
        print("height")
            print(-CGFloat(height))
        //posY = ((contextSize.height - contextSize.width) / 2)
        cgwidth = contextSize.width
        cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
    }
    
}
