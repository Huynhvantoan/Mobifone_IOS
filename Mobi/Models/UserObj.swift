//
//  ModelUser.swift
//  uHotel
//
//  Created by HungLe-iMac on 9/13/16.
//  Copyright © 2016 uHotel. All rights reserved.
//

import Foundation
import ObjectMapper


/// <#Description#>
class UserObj: NSObject, Mappable, NSCoding {
    
    var id : String?
    var username : String?
    var email : String?
    var auth_code : String?
    var phone : String?
    var lastName : String?
    var firstName : String?
    var isGuest : Bool!
    
    class var currentUserProfile: UserObj {
        set {
            let encodeData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            UserDefaults.standard.set(encodeData, forKey: userKey)
            UserDefaults.standard.set(true, forKey: loginKey)
        }
        get {
            if let dataEncode = UserDefaults.standard.object(forKey: userKey) as? Data{
                if let userProfile = NSKeyedUnarchiver.unarchiveObject(with: dataEncode) as? UserObj{
                    return userProfile
                }
            }
            
            return UserObj()
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        auth_code <- map["auth_code"]
    }

    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "ID") as? String
        self.username = aDecoder.decodeObject(forKey: "username") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.auth_code = aDecoder.decodeObject(forKey: "auth_code") as? String
        self.lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        self.firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
        self.isGuest = aDecoder.decodeBool(forKey: "isGuest")
    }
    
    func encode(with aCoder: NSCoder) {
        if let id = self.id {
            aCoder.encode(id, forKey: "ID")
        }
        if let username = self.username {
            aCoder.encode(username, forKey: "username")
        }
        if let email = self.email {
            aCoder.encode(email, forKey: "email")
        }
        if let auth_code = self.auth_code {
            aCoder.encode(auth_code, forKey: "auth_code")
        }
        if let lastName = self.lastName {
            aCoder.encode(lastName, forKey: "lastName")
        }
        if let firstName = self.firstName {
            aCoder.encode(firstName, forKey: "firstName")
        }
        if let phone = self.phone {
            aCoder.encode(phone, forKey: "phone")
        }
        if let isGuest = self.isGuest {
            aCoder.encode(isGuest, forKey: "isGuest")
        }
    }
}


 /// <#Description#>
 class UserMapper: BaseObj {
    var detail: UserObj?

    override func mapping(map: Map) {
        detail <- map["0"]
        idk <- map["idk"]
//        error <- map["error"]
        reason <- map["reason"]
    }
}
