//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class UsersInfo {
    
//    "status": true,
//    "code": 200,
//    "msg": "All record fetch successfully",
//    "version": "1.0.0",
    
    var  status : String = ""
    var  code : String = ""
    var  msg : String = ""
    var  version : String = ""
    var data : [UserData] = []
    
    init(json: [String : Any]) {
        
        status = json["status"] as? String ?? ""
        code =  self.valuForString(json["code"] ?? "") ?? ""
        msg = json["msg"] as? String ?? ""
        version = json["version"] as? String ?? ""
        
        if let arrayjson = json["data"] as? [[String:Any]]{
            data = UserData.toArray(arrJson: arrayjson)
        }
        
    }
    
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        dict["status"] = status
        dict["code"] = code
        dict["msg"] = msg
        dict["version"] = version
        dict["data"] = data
        
        return dict
    }
    
    
    class func toArray(arrJson: [[String: Any]]) -> [UsersInfo] {
        var arrModels = [UsersInfo]()
        for json in arrJson {
            arrModels.append(UsersInfo(json: json))
        }
        return arrModels
    }
    
    func valuForString(_ value: Any) -> String?{
        let anyValue = "\(value)"
        return anyValue
    }
    
}

//MARK: - Photos info
class UserData {
    
    //    var address : String!
    //    var createdAt : String!
    //    var designation : String!
    //    var dob : String!
    //    var email : String!
    //    var fullName : String!
    //    var gender : String!
    //    var id : Int!
    //    var phone : String!
    //    var profilePic : String!
    //    var profilePicUrl : String!
    //    var salary : Int!
    //    var updatedAt : String!
    
    var address : String = ""
    var createdAt : String = ""
    var designation : String = ""
    var dob : String = ""
    var email : String = ""
    var fullName : String = ""
    var gender : String = ""
    var id : String = ""
    var phone : String = ""
    var profilePic : String = ""
    var profilePicUrl : String = ""
    var salary : String = ""
    var updatedAt : String = ""
    
    init(json: [String : Any]) {
        address = json["address"] as? String ?? ""
        createdAt = json["created_at"] as? String ?? ""
        designation = json["designation"] as? String ?? ""
        dob = json["dob"] as? String ?? ""
        email = json["email"] as? String ?? ""
        fullName = json["full_name"] as? String ?? ""
        gender = json["gender"] as? String ?? ""
        id =  self.valuForString(json["id"] ?? "") ?? ""
        phone = json["phone"] as? String ?? ""
        profilePic = json["profile_pic"] as? String ?? ""
        profilePicUrl = json["profile_pic_url"] as? String ?? ""
        salary =  self.valuForString(json["salary"] ?? "") ?? ""
        updatedAt = json["updated_at"] as? String ?? ""
    }
    
    func getProfileImageUrl()->URL? {
        return URL(string: self.profilePicUrl.encodedUrlQueryString())
    }
    
    func formattedDate() -> String {
        let date = createdAt.toDate()
        return "\(String(describing: date!.getDateStringWithFormate("d MMM,yyyy | HH:mm:ss", timezone: TimeZone.current.abbreviation()!)))"
    }
        
    func toDictionary() -> [String: Any] {
        var dict = [String: Any]()
        
        dict["address"] = address
        dict["createdAt"] = createdAt
        dict["designation"] = designation
        dict["dob"] = dob
        dict["email"] = email
        dict["fullName"] = fullName
        dict["gender"] = gender
        dict["id"] = id
        dict["phone"] = phone
        dict["profilePic"] = profilePic
        dict["profilePicUrl"] = profilePicUrl
        dict["salary"] = salary
        dict["updatedAt"] = updatedAt
        return dict
    }
    
    class func toArray(arrJson: [[String: Any]]) -> [UserData] {
        var arrModels = [UserData]()
        for json in arrJson {
            arrModels.append(UserData(json: json))
        }
        return arrModels
    }
    
    func valuForString(_ value: Any) -> String?{
        let anyValue = "\(value)"
        return anyValue
    }
}


extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
