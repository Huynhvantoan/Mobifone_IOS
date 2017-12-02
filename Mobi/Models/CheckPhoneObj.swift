//
//  CheckPhoneObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/12/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import ObjectMapper

class CheckPhoneObj: NSObject {

}

class CheckPhoneMapper: BaseObj {
    
    override func mapping(map: Map) {
        
        idk <- map["idk"]
        reason <- map["reason"]
    }
}
