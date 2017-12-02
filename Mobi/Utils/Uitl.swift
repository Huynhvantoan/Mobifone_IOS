//
//  Uitl.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/2/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class Uitl: NSObject {
    
    public static let sharedInstance: Uitl = {
        return Uitl()
    }()
    
    
    func removeUserDefault(forValue _key: String )  {
        UserDefaults.standard.removeObject(forKey: _key)
        UserDefaults.standard.synchronize()
    }
    
    
    func setUserDefault(byValue _value: Any?, forKey _key: String?){
        if (!(_value != nil) || !(_key != nil)) {
            return;
        }
        UserDefaults.standard.set(_value!, forKey: _key!)
        UserDefaults.standard.synchronize()
    }

    func getUserDefaultValue(forValue _key: String?) -> Any?{
        if (!(_key != nil)) {
            return nil;
        }
        return UserDefaults.standard.object(forKey: _key!)
    }
    
    func getImageByName(imageName: String) -> UIImage {

        if "I_HOME" == imageName || "I_PORFILE" == imageName {
            return UIImage(named: "ic_profile")!
        } else if "I_STORE" == imageName {
            return UIImage(named: "ic_sim")!
        } else if "I_PROMOTION" == imageName {
            return UIImage(named: "ic_khuyenmai")!
        } else if "I_LIABILITIES" == imageName {
            return UIImage(named: "ic_congno")!
        } else if "I_PROCEDURE" == imageName {
            return UIImage(named: "ic_thutuc")!
        } else if "I_UPLOAD_PICTURE" == imageName {
            return UIImage(named: "ic_upload")!
        } else if "I_CONTAST" == imageName {
            return UIImage(named: "ic_call")!
        } else if "I_LOGOUT" == imageName {
            return UIImage(named: "ic_exit")!
        } else if "I_VAS" == imageName {
            return UIImage(named: "ic_vas")!
        } else if "I_PAY_THE_BILL" == imageName {
            return UIImage(named: "ic_payment")!
        } else if "I_TRA_TRUOC" == imageName {
            return UIImage(named: "ic_tratruoc")!
        } else if "I_TRA_SAU_DOANH_NGHIEP" == imageName {
            return UIImage(named: "ic_tratruocdoanhnghiep")!
        } else if "I_TRA_SAU" == imageName {
            return UIImage(named: "ic_trasau")!
        } else if "I_CAM_KET_SO_DEP" == imageName {
            return UIImage(named: "ic_camket")!
        } else if "I_KIEM_TRA_TINH_TRANG" == imageName {
            return UIImage(named: "ic_kiemtra")!
        } else  {
            return UIImage()
        }
    }
}
