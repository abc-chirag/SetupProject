//
//  BaseViewController.swift
//  KEC
//
//  Created by Kartum Infotech on 21/07/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    
    //MARK:- Properties
    
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //MARK:- Functions
    func showNoNetworkAlert() {
        Utility.showMessageAlert(title: "NO Network Connection", andMessage: "Check Connection", withOkButtonTitle: "OK")
    }
    
    //MARK:- IBActions
//    @IBAction func onBtnBack() {
//        navigationController?.popViewController(animated: true)
//    }
    
    
}
