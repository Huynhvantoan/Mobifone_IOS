//
//  SimObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/26/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import ObjectMapper

class SimObj: Mappable {
    
    var name: String?
    var originPrice: String?
    var price: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["sdtview"]
        originPrice <- map["goicuoc"]
        price <- map["gia"]
    }
}


class SimMapper: BaseObj {
    var detail: [SimObj]?
    var totalrows: String?
    var nextLink: String?
    
    
    override func mapping(map: Map) {
        detail <- map["data"]
        idk <- map["idk"]
        totalrows <- map["totalrows"]
        nextLink <- map["page.nextLink"]
//        error <- map["error"]
        reason <- map["reason"]
    }
}
