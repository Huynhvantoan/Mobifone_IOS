//
//  TypeSimObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/26/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import ObjectMapper

class TypeSimObj: NSObject, Mappable {
    
    var tenKey: String?
    var tenName: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        tenKey <- map["tenkey"]
        tenName <- map["tends"]
    }
    

}

/// <#Description#>
class TypeSimMapper: BaseObj {
    var detail: [TypeSimObj]?
    
    override func mapping(map: Map) {
        detail <- map["data"]
        idk <- map["idk"]
//        error <- map["error"]
        reason <- map["reason"]
    }
}
