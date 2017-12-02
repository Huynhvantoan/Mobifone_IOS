//
//  CongNoObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import ObjectMapper

class CongNoObj: Mappable {
    var phone: String?
    var name: String?
    var date: String?
    var payment: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        phone <- map["sdt"]
        name <- map["TenLoai"]
        date <- map["date"]
        payment <- map["thanhtoan"]
    }
    

}

class CongNoMapper: BaseObj {
    var detail: [CongNoObj]?
    
    override func mapping(map: Map) {
        detail <- map["data"]
        idk <- map["idk"]
        reason <- map["reason"]
    }
}
