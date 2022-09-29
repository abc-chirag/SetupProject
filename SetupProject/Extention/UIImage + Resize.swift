import UIKit
import CoreGraphics
import Accelerate

extension UIImage {
    
    public enum ResizeTechnique {
        case UIKit
        case CoreImage
        case CoreGraphics
        case ImageIO
        case Accelerate
    }
    
    /// Resize image from given size.
    ///
    /// - Parameter maxPixels: Max pixels in the output image. If input image pixel count is less than maxPixels value then it won'n be risezed.
    /// - Parameter resizeTechnique: Technique for image resizing: UIKit / CoreImage / CoreGraphics / ImageIO / Accelerate.
    /// - Returns: Resized image.
    public func resize(maxPixels: Int, with resizeTechnique: ResizeTechnique) -> UIImage {
        var resultImage = self
        let maxPixels = CGFloat(maxPixels)
        let imagePixelsCount = size.width * size.height
        if imagePixelsCount > maxPixels {
            let sizeRatio = sqrt(maxPixels / imagePixelsCount)
            let newWidth = size.width * sizeRatio
            let newHeight = size.height * sizeRatio
            let newSize = CGSize(width: newWidth, height: newHeight)
            resultImage = resize(to: newSize, with: resizeTechnique)
        }
        return resultImage
    }
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Parameter resizeTechnique: Technique for image resizing: UIKit / CoreImage / CoreGraphics / ImageIO / Accelerate.
    /// - Returns: Resized image.
    public func resize(to newSize: CGSize, with resizeTechnique: ResizeTechnique) -> UIImage {
        switch resizeTechnique {
        case .UIKit:
            return resizeWithUIKit(to: newSize)
        case .CoreGraphics:
            return resizeWithCoreGraphics(to: newSize)
        case .CoreImage:
            return resizeWithCoreImage(to: newSize)
        case .ImageIO:
            return resizeWithImageIO(to: newSize)
        case .Accelerate:
            return resizeWithAccelerate(to: newSize)
        }
    }
    
    // MARK: - UIKit
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithUIKit(to newSize: CGSize) -> UIImage {
        var resultImage = self
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return resultImage }
        resultImage = resizedImage
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
    // MARK: - CoreImage
    
    /// Resize CI image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithCoreImage(to newSize: CGSize) -> UIImage {
        var resultImage = self
        
        guard let cgImage = cgImage else { return resultImage }
        
        let ciImage = CIImage(cgImage: cgImage)
        let scale = (Double)(newSize.width) / (Double)(ciImage.extent.size.width)
        
        let filter = CIFilter(name: "CILanczosScaleTransform")!
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(NSNumber(value:scale), forKey: kCIInputScaleKey)
        filter.setValue(1.0, forKey:kCIInputAspectRatioKey)
        let outputImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        
        let context = CIContext(options: [.useSoftwareRenderer: false])
        resultImage = UIImage(cgImage: context.createCGImage(outputImage, from: outputImage.extent)!)
        return resultImage
    }
    
    // MARK: - CoreGraphics
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithCoreGraphics(to newSize: CGSize) -> UIImage {
        var resultImage = self
        
        guard let cgImage = cgImage else { return resultImage }
        
        let width = Int(newSize.width)
        let height = Int(newSize.height)
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace!
        let bitmapInfo = cgImage.bitmapInfo
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return resultImage }
        context.interpolationQuality = .high
        let rect = CGRect(origin: CGPoint.zero, size: newSize)
        context.draw(cgImage, in: rect)
        
        resultImage = context.makeImage().flatMap { UIImage(cgImage: $0) }!
        
        return resultImage
    }
    
    // MARK: - ImageIO
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithImageIO(to newSize: CGSize) -> UIImage {
        var resultImage = self
        
        guard let pngData = pngData() else { return resultImage }
        let imageCFData = NSData(data: pngData) as CFData
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: max(newSize.width, newSize.height)
            ] as CFDictionary
        guard let source = CGImageSourceCreateWithData(imageCFData, nil),
            let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else { return resultImage }
        resultImage = UIImage(cgImage: imageReference)
        
        return resultImage
    }
    
    // MARK: - Accelerate
    
    /// Resize image from given size.
    ///
    /// - Parameter newSize: Size of the image output.
    /// - Returns: Resized image.
    private func resizeWithAccelerate(to newSize: CGSize) -> UIImage {
        var resultImage = self
        
        guard let cgImage = cgImage else { return resultImage }
        
        // create a source buffer
        var format = vImage_CGImageFormat(bitsPerComponent: numericCast(cgImage.bitsPerComponent),
                                          bitsPerPixel: numericCast(cgImage.bitsPerPixel),
                                          colorSpace: Unmanaged.passUnretained(cgImage.colorSpace!),
                                          bitmapInfo: cgImage.bitmapInfo,
                                          version: 0,
                                          decode: nil,
                                          renderingIntent: .defaultIntent)
        var sourceBuffer = vImage_Buffer()
        defer {
            sourceBuffer.data.deallocate()
        }
        
        var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
        guard error == kvImageNoError else { return resultImage }
        
        // create a destination buffer
        let destWidth = Int(newSize.width)
        let destHeight = Int(newSize.height)
        let bytesPerPixel = cgImage.bitsPerPixel
        let destBytesPerRow = destWidth * bytesPerPixel
        let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
        defer {
            destData.deallocate()
        }
        var destBuffer = vImage_Buffer(data: destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
        
        // scale the image
        error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
        guard error == kvImageNoError else { return resultImage }
        
        // create a CGImage from vImage_Buffer
        let destCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
        guard error == kvImageNoError else { return resultImage }
        
        // create a UIImage
        if let scaledImage = destCGImage.flatMap({ UIImage(cgImage: $0) }) {
            resultImage = scaledImage
        }
        
        return resultImage
    }
    
    
    /// Fix image orientaton to protrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }
        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }
        ctx.concatenate(transform)
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        guard let newCGImage = ctx.makeImage() else { return nil }
        return autoreleasepool { UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up) }
        //return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
    
}
