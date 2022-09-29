//
//  ViewController.swift
//  SetupProject
//
//  Created by Kartum Infotech on 23/08/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var searcgBar: UISearchBar!
    @IBOutlet weak var tblEmployee: UITableView!
    
    //MARK:- Properties
    var viewModel = GetUsersViewModel()
   
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    //MARK:- Functions
    private func setupUI() {
        setupTableView()
        getUsersApi()
        searcgBar.delegate = self
    }
    
    private func setupTableView() {
        tblEmployee.delegate = self
        tblEmployee.dataSource = self
        tblEmployee.register(UsersCell.nib, forCellReuseIdentifier: UsersCell.identifier)
        tblEmployee.reloadData()
    }
    
    
    private func getUsersApi() {
        guard Reachability.isConnectedToNetwork() else {
            showNoNetworkAlert()
            return
        }
        LoaderManager.showLoader()
        viewModel.getUsers{ (success, messege) in
            LoaderManager.hideLoader()
            if success {
                print("success ")
                self.tblEmployee.reloadData()
            } else if messege.isEmpty == false {
                self.view.showToastAtBottom(message: messege)
            }
        }
    }
    
    //MARK:- IBActions
    
}

//MARK:- UITableViewDelegate,UITableViewDataSource
extension ViewController: UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.arrUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.identifier) as? UsersCell else{return UITableViewCell()}
        
        cell.config(index: viewModel.arrUserData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.viewModel.arrUserData =  viewModel.arrUserData.filter { $0.fullName.contains(searchText) }
        tblEmployee.reloadData()
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.getUsersApi()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.getUsersApi()
    }
}
