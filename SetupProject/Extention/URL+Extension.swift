//
//  URL+Extension.swift
//  StoryMaker
//
//  Created by Sunil Zalavadiya on 19/09/20.
//  Copyright © 2020 Kartum. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices

extension URL {
    
    func thumbnailForVideo() -> UIImage? {
        let asset = AVURLAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        do {
            let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fileSize() -> Double {
        var fileSize: Double = 0.0
        var fileSizeValue = 0.0
        try? fileSizeValue = (self.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
        if fileSizeValue > 0.0 {
            fileSize = (Double(fileSizeValue) / (1024 * 1024))
        }
        return fileSize
    }
    
    
    func isAudio() -> Bool {
        let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as CFString, nil)
        return UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio)
    }
    
    func isSupportedMediaFormate() -> Bool {
        let pathExtension = self.pathExtension.lowercased()
        return pathExtension == "flac" ||
            pathExtension == "aiff" ||
            pathExtension == "aac" ||
            pathExtension == "wav" ||
            pathExtension == "m4a" ||
            pathExtension == "mp3" ||
            pathExtension == "mp4" ||
            pathExtension == "caf" ||
            pathExtension == "mov"
    }
    func isSupportedAudioFormate() -> Bool {
        //flac, aiff, aac, wav, m4a, mp3, mp4, caf
        let pathExtension = self.pathExtension.lowercased()
        return pathExtension == "flac" ||
            pathExtension == "aiff" ||
            pathExtension == "aac" ||
            pathExtension == "wav" ||
            pathExtension == "m4a" ||
            pathExtension == "mp3" ||
            pathExtension == "mp4" ||
            pathExtension == "caf"
    }
    func isSupportedVideoFormate() -> Bool {
        //mp4
        let pathExtension = self.pathExtension.lowercased()
        return pathExtension == "mp4"
    }
    func containsAudio() -> Bool {
        let asset = AVURLAsset(url: self)
        // if using a mixComposition it's: let asset = mixComposition (an AVMutableComposition itself is an asset)
        let audioTrack = asset.tracks(withMediaType: .audio)
        if audioTrack.isEmpty {
            print("this file has no sound")
            return false
        }
        print("this file has sound")
        return true
    }
    func containsVideo() -> Bool {
        let asset = AVURLAsset(url: self)
        // if using a mixComposition it's: let asset = mixComposition (an AVMutableComposition itself is an asset)
        let track = asset.tracks(withMediaType: .video)
        if track.isEmpty {
            print("this file has no video")
            return false
        }
        print("this file has video")
        return true
    }
}
