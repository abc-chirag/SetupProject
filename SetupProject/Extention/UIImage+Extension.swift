//
//  UIImage+Extension.swift
//  Trichordal
//
//  Created by Sunil Zalavadiya on 23/01/19.
//  Copyright © 2019 Sunil Zalavadiya. All rights reserved.
//

import UIKit

extension UIImage {
    
    public func tintWithColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        //UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        
        // flip the image
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -self.size.height)
        
        // multiply blend mode
        context?.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context?.fill(rect)
        
        // create uiimage
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public static func gradientImageWith(size : CGSize, colors : [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient (size.height)
        context.drawLinearGradient(gradient, start: CGPoint(x: size.width, y: 0.0), end: CGPoint(x: 0.0, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func aspectResize(maxSize: CGSize) -> UIImage {
        if self.size.width > maxSize.width || self.size.height > maxSize.height {
            let theWidthScaleFactor = maxSize.width / self.size.width
            let theHeightScaleFactor = maxSize.height / self.size.height
            let theScaleFactor = min(theWidthScaleFactor, theHeightScaleFactor)
            let theWidth = self.size.width * theScaleFactor
            let theHeight = self.size.height * theScaleFactor
            return self.resize(to: CGSize(width: theWidth, height: theHeight), with: .CoreGraphics)
            
            //            let format = UIGraphicsImageRendererFormat()
            //            format.scale = 1
            //            let renderer = UIGraphicsImageRenderer(size: CGSize(width: theWidth, height: theHeight), format: format)
            //            let croppedImage = renderer.image { _ in
            //                self.draw(in: CGRect(origin: .zero, size: CGSize(width: theWidth, height: theHeight)))
            //            }
            //
            //            return croppedImage
            
        } else {
            return self
        }
    }
    
    
}

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}

extension UIImage {
    public func gradientImageForButton(size : CGSize) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = [UIColor.red.cgColor, UIColor.green.cgColor]
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0, 0.8, 1.0] //0.5
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        // Draw the gradient (size.height)
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0.5), end: CGPoint(x: size.width, y: 0.5), options: [])
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
