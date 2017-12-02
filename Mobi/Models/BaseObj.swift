//
//  BaseObj.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/25/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseObj: NSObject, Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }

    var idk : String?
    var error : Int!
    var reason : String?
}
