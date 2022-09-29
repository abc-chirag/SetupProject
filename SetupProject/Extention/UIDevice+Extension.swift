//
//  UIDevice+Extension.swift
//  MovieApp
//
//  Created by Sunil Zalavadiya on 22/04/20.
//  Copyright © 2020 Kartum Infotech. All rights reserved.
//

import UIKit

extension UIDevice {

    public enum `Type` {
        case iPad
        case iPhone_unknown
        case iPhone_5_5S_5C
        case iPhone_6_6S_7_8
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_Xs
        case iPhone_Xs_11_Pro_Max
        case iPhone_Xr_11
        case iPhone_11_Pro
    }

    public var hasHomeButton: Bool {
        switch type {
        case .iPhone_X_Xs, .iPhone_Xr_11, .iPhone_Xs_11_Pro_Max, .iPhone_11_Pro:
            return false
        default:
            return true
        }
    }

    public var type: Type {
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: return .iPhone_5_5S_5C
            case 1334: return .iPhone_6_6S_7_8
            case 1920, 2208: return .iPhone_6_6S_7_8_PLUS
            case 2436: return .iPhone_X_Xs
            case 2688: return .iPhone_Xs_11_Pro_Max
            case 1792: return .iPhone_Xr_11
            case 2426: return .iPhone_11_Pro
            default: return .iPhone_unknown
        }
        }
        return .iPad
   }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0,  *) {
            var safeAreaInset: CGFloat?
            if (UIApplication.shared.statusBarOrientation == .portrait) {
                safeAreaInset = UIApplication.shared.delegate?.window??.safeAreaInsets.top
            }
            else if (UIApplication.shared.statusBarOrientation == .landscapeLeft) {
                safeAreaInset = UIApplication.shared.delegate?.window??.safeAreaInsets.left
            }
            else if (UIApplication.shared.statusBarOrientation == .landscapeRight) {
                safeAreaInset = UIApplication.shared.delegate?.window??.safeAreaInsets.right
            }
            return safeAreaInset ?? 0 > 24
        }
        return false
   }
}

public extension UIDevice {
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}

extension UIDevice {
    func MBFormatter(_ bytes: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: bytes) as String
    }
    
    //MARK: Get String Value
    var totalDiskSpaceInGB:String {
       return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var freeDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var usedDiskSpaceInGB:String {
        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
    }
    
    var totalDiskSpaceInMB:String {
        return MBFormatter(totalDiskSpaceInBytes)
    }
    
    var freeDiskSpaceInMB:String {
        return MBFormatter(freeDiskSpaceInBytes)
    }
    
    var usedDiskSpaceInMB:String {
        return MBFormatter(usedDiskSpaceInBytes)
    }
    
    //MARK: Get raw value
    var totalDiskSpaceInBytes:Int64 {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
        return space
    }
    
    /*
     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
     */
    var freeDiskSpaceInBytes:Int64 {
        if #available(iOS 11.0, *) {
            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                return space
            } else {
                return 0
            }
        } else {
            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                return freeSpace
            } else {
                return 0
            }
        }
    }
    
    var usedDiskSpaceInBytes:Int64 {
       return totalDiskSpaceInBytes - freeDiskSpaceInBytes
    }

}
