//
//  UsersCell.swift
//  SetupProject
//
//  Created by macbook on 23/08/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import UIKit
import SDWebImage

class UsersCell: UITableViewCell {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    
    //MARK:- LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupUI()
    }
    
    //MARK:- Functions
    private func setupUI() {
        imgUser.addCornerRadius(imgUser.frame.height / 2)
    }
    
    func config(index : UserData) {
        lblUsername.text = index.fullName
        lblEmail.text = index.email
        lblDateTime.text = index.formattedDate()
        imgUser.sd_setImage(with: URL(string: index.profilePicUrl) , placeholderImage: UIImage(named: "ic_userimage"))
    }
    
    //MARK:- IBActions
    
    
}
