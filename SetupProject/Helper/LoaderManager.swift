//
//  LoaderManager.swift
//  hypnosis
//
//  Created by Sunil Zalavadiya on 04/06/20.
//  Copyright © 2020 Steve G. Jones Clinical Hypnotherapy, LLC. All rights reserved.
//

import Foundation
import MBProgressHUD

class LoaderManager: NSObject {
    
    private static var loadingCount = 0
    
    class func showLoader(message: String? = nil) {
        if loadingCount == 0 {
            // Show loader
            DispatchQueue.main.async {
                let progress = MBProgressHUD.showAdded(to: Utility.windowMain()!, animated: true)
                progress.label.text = message
            }
        }
        loadingCount += 1
    }
    
    class func updateMessage(message: String? = nil) {
        DispatchQueue.main.async {
            MBProgressHUD.forView(Utility.windowMain()!)?.label.text = message
        }
    }
    //gdfg
    class func hideLoader() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            // Hide loader
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: Utility.windowMain()!, animated: true)
            }
        }
    }
}
