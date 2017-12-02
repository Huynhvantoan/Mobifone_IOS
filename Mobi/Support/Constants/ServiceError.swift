//
//  ServiceError.swift
//  uHotel
//
//  Created by HeoConUnIn on 3/28/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import Foundation
import UIKit

enum CodeResponse: Int {
    case CODE_SUCCESS = 200,
    CODE_FAILURE = 400,
    REQUEST_FAIL = 301,
    GO_HOME = 2,
    GO_ACTIVE_PIN = 22,
    NO_RESPONSE = 99,
    NO_DATA = 100
}


