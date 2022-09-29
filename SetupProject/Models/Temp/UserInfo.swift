//
//  UserInfo.swift
//  Stadbeat
//
//  Created by Kartum Infotech on 05/02/21.
//  Copyright © 2021 Kartum Infotech. All rights reserved.
//

import Foundation

class UserInfo {
    
    var tbUserProfile: TbUserProfile?
    var arrAllocatedUserRoles: [AllocatedUserRoles] = []
    
    init(json: [String : Any]) {
        
        if let arrayjson = json["tbUserProfile"] as? [String:Any] {
            tbUserProfile = TbUserProfile(json: arrayjson)
        }
        
        //        if let tbUserProfileData = dictionary["tbUserProfile"] as? [String:Any]{
        //            tbUserProfile = TbUserProfile(fromDictionary: tbUserProfileData)
        //        }
        
        if let arrayjson = json["allocatedUserRoles"] as? [[String:Any]]{
            arrAllocatedUserRoles = AllocatedUserRoles.toArray(arrJson: arrayjson)
        }
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        dict["tbUserProfile"] = tbUserProfile?.toDictionary()
        
        var arrRolesJson = [[String: Any]]()
        for role in arrAllocatedUserRoles {
            arrRolesJson.append(role.toDictionary())
        }
        dict["arrAllocatedUserRoles"] = arrRolesJson
        
        return dict
    }
    
    class func toArray(arrJson: [[String: Any]]) -> [UserInfo] {
        var arrModels = [UserInfo]()
        for json in arrJson {
            arrModels.append(UserInfo(json: json))
        }
        return arrModels
    }
    
    func valuForString(_ value: Any?) -> String?{
        if let value = value {
            let anyValue = "\(value)"
            return anyValue
        }
        return nil
    }
}

//{
//  "TbUserProfile": {
//    "userId": 19999062,
//    "userType": 1,
//    "userEmail": "qc1@agilemantra.com",
//    "userMobileNo": "6351762990",
//    "userProfilePic": null,
//    "userPassword": "Test@2021",
//    "userBusinessUnitID": 6,
//    "userRegionID": 53,
//    "userProjectID": 127,
//    "userStatus": 1,
//    "userLastLoginOn": "2019-06-20T16:45:47.893",
//    "userProfileLastModifyOn": "2021-07-03T00:45:49.367",
//    "userVerificationCode": null,
//    "userCreatedBy": 1,
//    "userCreatedOn": "2019-06-27T00:28:35.097",
//    "userApprovedBy": 1,
//    "userApprovedOn": "2019-05-10T00:00:00",
//    "userSignUpOTP": null,
//    "userName": "QC Engineer1-Modified",
//    "tncAcceptedOn": null,
//    "guid": "62413BF9-4601-48F7-87E7-8D1DCC1D87A1",
//    "company": null,
//    "errorMessage": null
//  },
//  "allocatedUserRoles": [
//    {
//      "roleAllocatedId": 8923,
//      "userId": 19999062,
//      "roleId": 15,
//      "roleName": "QC Engineer",
//      "parent": 3,
//      "parentId": 346,
//      "roles": null
//    }
//  ]
//}

class TbUserProfile {
    
    var userId: String = ""
    var userType: String = ""
    var userEmail: String = ""
    var userMobileNo: String = ""
    var userProfilePic: String = ""
    var userPassword: String = ""
    var userBusinessUnitID: String = ""
    var userRegionID: String = ""
    var userProjectID: String = ""
    var userStatus: String = ""
    var userLastLoginOn: String = ""
    var userProfileLastModifyOn: String = ""
    var userVerificationCode: String = ""
    var userCreatedBy: String = ""
    var userCreatedOn: String = ""
    var userApprovedBy: String = ""
    var userApprovedOn: String = ""
    var userSignUpOTP: String = ""
    var userName: String = ""
    var tncAcceptedOn: String = ""
    var guid: String = ""
    var company: String = ""
    var errorMessage: String = ""
    
    //    "userId": 19999062,
    //    "userType": 1,
    //    "userEmail": "qc1@agilemantra.com",
    //    "userMobileNo": "6351762990",
    //    "userProfilePic": null,
    //    "userPassword": "Test@2021",
    //    "userBusinessUnitID": 6,
    //    "userRegionID": 53,
    //    "userProjectID": 127,
    //    "userStatus": 1,
    //    "userLastLoginOn": "2019-06-20T16:45:47.893",
    //    "userProfileLastModifyOn": "2021-07-03T00:45:49.367",
    //    "userVerificationCode": null,
    //    "userCreatedBy": 1,
    //    "userCreatedOn": "2019-06-27T00:28:35.097",
    //    "userApprovedBy": 1,
    //    "userApprovedOn": "2019-05-10T00:00:00",
    //    "userSignUpOTP": null,
    //    "userName": "QC Engineer1-Modified",
    //    "tncAcceptedOn": null,
    //    "guid": "62413BF9-4601-48F7-87E7-8D1DCC1D87A1",
    //    "company": null,
    //    "errorMessage": null
    
    init(json: [String:Any]){
        
        userId = self.valuForString(json["userId"] ?? "") ?? ""
        userType = self.valuForString(json["userType"] ?? "") ?? ""
        userEmail = json["userEmail"] as? String ?? ""
        userMobileNo = json["userMobileNo"] as? String ?? ""
        userProfilePic = json["userProfilePic"] as? String ?? ""
        userPassword = json["userPassword"] as? String ?? ""
        userBusinessUnitID = self.valuForString(json["userBusinessUnitID"] ?? "") ?? ""
        userRegionID = self.valuForString(json["userRegionID"] ?? "") ?? ""
        userProjectID = self.valuForString(json["userProjectID"] ?? "") ?? ""
        userStatus = self.valuForString(json["userStatus"] ?? "") ?? ""
        userLastLoginOn = json["userLastLoginOn"] as? String ?? ""
        userProfileLastModifyOn = json["userProfileLastModifyOn "] as? String ?? ""
        userVerificationCode = self.valuForString(json["userVerificationCode"] ?? "") ?? ""
        userCreatedBy = self.valuForString(json["userCreatedBy"] ?? "") ?? ""
        userCreatedOn = json["userCreatedOn"] as? String ?? ""
        userApprovedBy = self.valuForString(json["userApprovedBy"] ?? "") ?? ""
        userApprovedOn = json["userApprovedOn"] as? String ?? ""
        userSignUpOTP = self.valuForString(json["userSignUpOTP"] ?? "") ?? ""
        userName = json["userName"] as? String ?? ""
        tncAcceptedOn = json["tncAcceptedOn"] as? String ?? ""
        guid = json["guid"] as? String ?? ""
        company = json["company"] as? String ?? ""
        errorMessage = json["errorMessage"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        dict["userId"] = userId
        dict["userType"] = userType
        dict["userEmail"] = userEmail
        dict["userMobileNo"] = userMobileNo
        dict["userProfilePic"] = userProfilePic
        dict["userPassword"] = userPassword
        dict["userBusinessUnitID"] = userBusinessUnitID
        dict["userRegionID"] = userRegionID
        dict["userProjectID"] = userProjectID
        dict["userStatus"] = userStatus
        dict["userLastLoginOn"] = userLastLoginOn
        dict["userProfileLastModifyOn"] = userProfileLastModifyOn
        dict["userVerificationCode"] = userVerificationCode
        dict["userCreatedBy"] = userCreatedBy
        dict["userCreatedOn"] = userCreatedOn
        dict["userApprovedBy"] = userApprovedBy
        dict["userApprovedOn"] = userApprovedOn
        dict["userSignUpOTP"] = userSignUpOTP
        dict["tncAcceptedOn"] = tncAcceptedOn
        dict["guid"] = guid
        dict["company"] = company
        dict["errorMessage"] = errorMessage
        
        return dict
    }
    
    class func toArray(arrJson: [[String: Any]]) -> [TbUserProfile] {
        var arrModels = [TbUserProfile]()
        for json in arrJson {
            arrModels.append(TbUserProfile(json: json))
        }
        return arrModels
    }
    
    func valuForString(_ value: Any?) -> String?{
        if let value = value {
            let anyValue = "\(value)"
            return anyValue
        }
        return nil
    }
}

class AllocatedUserRoles {
    //
    //    "roleAllocatedId": 8923,
    //    "userId": 19999062,
    //    "roleId": 15,
    //    "roleName": "QC Engineer",
    //    "parent": 3,
    //    "parentId": 346,
    //    "roles": null
    
    var roleAllocatedId: String = ""
    var userId: String = ""
    var roleId: String = ""
    var roleName: String = ""
    var parent: String = ""
    var parentId: String = ""
    //    var roles: Roles?
    var roles: String = ""
    
    init(json: [String:Any]){
        
        roleAllocatedId = self.valuForString(json["roleAllocatedId"] ?? "") ?? ""
        userId = self.valuForString(json["userId"] ?? "") ?? ""
        roleId = self.valuForString(json["roleId"] ?? "") ?? ""
        roleName = json["roleName"] as? String ?? ""
        parent = self.valuForString(json["parent"] ?? "") ?? ""
        parentId = self.valuForString(json["parentId"] ?? "") ?? ""
        roles = json["roles"] as? String ?? ""
//        if let arrayjson = json["roles"] as? [String:Any] {
//            roles = Roles(json: arrayjson)
//        }
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        dict["roleAllocatedId"] = roleAllocatedId
        dict["userId"] = userId
        dict["roleId"] = roleId
        dict["roleName"] = roleName
        dict["parent"] = parent
        dict["parentId"] = parentId
        dict["roles"] = roles
        //        dict["roles"] = roles?.toDictionary()
        
        return dict
    }
    
    class func toArray(arrJson: [[String: Any]]) -> [AllocatedUserRoles] {
        var arrModels = [AllocatedUserRoles]()
        for json in arrJson {
            arrModels.append(AllocatedUserRoles(json: json))
        }
        return arrModels
    }
    
    func valuForString(_ value: Any?) -> String?{
        if let value = value {
            let anyValue = "\(value)"
            return anyValue
        }
        return nil
    }
}

//class Roles {
//    //    "roles": {
//    //    "roleId": 0,
//    //    "roleName": "string",
//    //    "parentValue": 0
//    //    }
//    var roleId: String = ""
//    var roleName: String = ""
//    var parentValue: String = ""
//
//    init(json: [String:Any]){
//        roleId = self.valuForString(json["roleId"] ?? "") ?? ""
//        roleName = json["roleName"] as? String ?? ""
//        parentValue = self.valuForString(json["parentValue"] ?? "") ?? ""
//    }
//
//    func toDictionary() -> [String: Any] {
//        var dict = [String: Any]()
//        dict["roleId"] = roleId
//        dict["roleName"] = roleName
//        dict["parentValue"] = parentValue
//        return dict
//    }
//
//    class func toArray(arrJson: [[String: Any]]) -> [Roles] {
//        var arrModels = [Roles]()
//        for json in arrJson {
//            arrModels.append(Roles(json: json))
//        }
//        return arrModels
//    }
//
//    func valuForString(_ value: Any?) -> String?{
//        if let value = value {
//            let anyValue = "\(value)"
//            return anyValue
//        }
//        return nil
//    }
//}

//class UserInfo {
//
//    var allocatedUserRoles : [AllocatedUserRole]!
//    var tbUserProfile : TbUserProfile!
//
//    init(fromDictionary dictionary: [String:Any]){
//        allocatedUserRoles = [AllocatedUserRole]()
//        if let allocatedUserRolesArray = dictionary["allocatedUserRoles"] as? [[String:Any]]{
//            for dic in allocatedUserRolesArray{
//                let value = AllocatedUserRole(fromDictionary: dic)
//                allocatedUserRoles.append(value)
//            }
//        }
//        if let tbUserProfileData = dictionary["tbUserProfile"] as? [String:Any]{
//            tbUserProfile = TbUserProfile(fromDictionary: tbUserProfileData)
//        }
//    }
//
//}
//
//
//class TbUserProfile {
//
//    var company : AnyObject!
//    var errorMessage : AnyObject!
//    var guid : String!
//    var tncAcceptedOn : AnyObject!
//    var userApprovedBy : Int!
//    var userApprovedOn : String!
//    var userBusinessUnitID : Int!
//    var userCreatedBy : Int!
//    var userCreatedOn : String!
//    var userEmail : String!
//    var userId : Int!
//    var userLastLoginOn : String!
//    var userMobileNo : String!
//    var userName : String!
//    var userPassword : String!
//    var userProfileLastModifyOn : String!
//    var userProfilePic : AnyObject!
//    var userProjectID : Int!
//    var userRegionID : Int!
//    var userSignUpOTP : AnyObject!
//    var userStatus : Int!
//    var userType : Int!
//    var userVerificationCode : AnyObject!
//
//    init(fromDictionary dictionary: [String:Any]){
//        company = dictionary["company"] as? AnyObject
//        errorMessage = dictionary["errorMessage"] as? AnyObject
//        guid = dictionary["guid"] as? String
//        tncAcceptedOn = dictionary["tncAcceptedOn"] as? AnyObject
//        userApprovedBy = dictionary["userApprovedBy"] as? Int
//        userApprovedOn = dictionary["userApprovedOn"] as? String
//        userBusinessUnitID = dictionary["userBusinessUnitID"] as? Int
//        userCreatedBy = dictionary["userCreatedBy"] as? Int
//        userCreatedOn = dictionary["userCreatedOn"] as? String
//        userEmail = dictionary["userEmail"] as? String
//        userId = dictionary["userId"] as? Int
//        userLastLoginOn = dictionary["userLastLoginOn"] as? String
//        userMobileNo = dictionary["userMobileNo"] as? String
//        userName = dictionary["userName"] as? String
//        userPassword = dictionary["userPassword"] as? String
//        userProfileLastModifyOn = dictionary["userProfileLastModifyOn"] as? String
//        userProfilePic = dictionary["userProfilePic"] as? AnyObject
//        userProjectID = dictionary["userProjectID"] as? Int
//        userRegionID = dictionary["userRegionID"] as? Int
//        userSignUpOTP = dictionary["userSignUpOTP"] as? AnyObject
//        userStatus = dictionary["userStatus"] as? Int
//        userType = dictionary["userType"] as? Int
//        userVerificationCode = dictionary["userVerificationCode"] as? AnyObject
//    }
//
//}
//
//
//class AllocatedUserRole {
//
//    var parent : Int!
//    var parentId : Int!
//    var roleAllocatedId : Int!
//    var roleId : Int!
//    var roleName : String!
//    var roles : AnyObject!
//    var userId : Int!
//
//
//    /**
//     * Instantiate the instance using the passed dictionary values to set the properties values
//     */
//    init(fromDictionary dictionary: [String:Any]){
//        parent = dictionary["parent"] as? Int
//        parentId = dictionary["parentId"] as? Int
//        roleAllocatedId = dictionary["roleAllocatedId"] as? Int
//        roleId = dictionary["roleId"] as? Int
//        roleName = dictionary["roleName"] as? String
//        roles = dictionary["roles"] as? AnyObject
//        userId = dictionary["userId"] as? Int
//    }
//
//}
