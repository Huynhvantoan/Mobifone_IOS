//
//  CategoryObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/26/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryObj: Mappable {
    
    var url: String?
    var image: String?
    var name: String?
    var idloai: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["tenloai"]
        image <- map["image"]
        url <- map["url"]
        idloai <- map["idloai"]
    }
}


class CategoryMapper: BaseObj {
    var detail: [CategoryObj]?
    
    override func mapping(map: Map) {
        detail <- map["data"]
        idk <- map["idk"]
//        error <- map["error"]
        reason <- map["reason"]
    }
}
