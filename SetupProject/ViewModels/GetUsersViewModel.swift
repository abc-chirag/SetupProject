//
//  GetUsersViewModel.swift
//  SetupProject
//
//  Created by macbook on 23/08/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

class GetUsersViewModel : BaseViewModel {
    
    // MARK:- Properties
    var  id:String = ""
    
    var users_info = UsersInfo(json: [:])
    
    
    var arrUserData = [UserData]()

    
    
    //MARK:- API call
    func getUsers(completionHandeler:@escaping ((_ success:Bool, _ message:String)->()) ){
        let params = ParameterRequest()
        _ = apiClient.get_Users(params: params){ (response, error) in
            
            guard error == nil else{
                completionHandeler(false, error!.messageForNetworking)
                return
            }
            
            guard let responseObj = response as? [String: Any]  else{
                completionHandeler(false, "")
                return
            }
            
            
            self.arrUserData.removeAll()
            if let users = responseObj["data"] as? [[String : Any]] {
                
                self.arrUserData.append(contentsOf: UserData.toArray(arrJson: users))
            }
            self.users_info = UsersInfo(json: responseObj)
            
            completionHandeler(true, self.users_info.msg)
            
        }
    }
    
}
