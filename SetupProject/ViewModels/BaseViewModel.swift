//
//  BaseViewModel.swift
//  KEC
//
//  Created by Kartum Infotech on 21/07/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    
    // MARK: - Properties
    lazy var apiClient = APIClient()
    lazy var messageToShow = ""
    
    override init() {
        super.init()
    }
}
