//
//  ada.swift
//  MyNote
//
//  Created by Khoa on 5/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class HUDManager: NSObject {
    
    static func showHUDInView(_ view:UIView, hubTitle title: String, dimBackground flag: Bool = false){
        view.endEditing(true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.contentColor = UIColor.colorWithHexString("b0006d")
        if flag {
            hud.backgroundView.style = .solidColor
            hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        }
    }
    
    static func showLoadMoreHUDInView(_ view:UIView, hubTitle title: String = "DANG_TAI_DU_LIEU", dimBackground flag: Bool = false){
        view.endEditing(true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.contentColor = UIColor.colorWithHexString("b0006d")
        hud.bezelView.backgroundColor = UIColor.clear
        hud.bezelView.color = UIColor.clear
        hud.bezelView.style = .solidColor
        hud.backgroundView.color = UIColor.clear
        hud.backgroundView.style = .solidColor
        if flag {
            hud.backgroundView.style = .solidColor
            hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        }
    }
    
    
    static func showHUDCompleteInView(_ view:UIView, hubTitle title: String = "Loading...", completion:(()->Void)?){
        let triggerTime = (Int64(NSEC_PER_SEC) * 2)
        let hud = MBProgressHUD(for: view)
        let imageView = UIImageView(image: UIImage(named: "HUDCheckmark"))
        hud!.mode = .customView;
        hud!.label.text = title
        hud!.customView = imageView
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.dismissHUD(view, completion: completion)
        })
    }
    
    static func showUploadHUDInView(_ view:UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.margin = 10
        hud.mode = .annularDeterminate
        hud.bezelView.backgroundColor = UIColor.clear
        hud.bezelView.color = UIColor.clear
        hud.bezelView.style = .solidColor
        hud.backgroundView.color = UIColor.clear
        hud.backgroundView.style = .solidColor
    }
    
    static func dismissHUD(_ view:UIView, completion:(()->Void)?){
        if MBProgressHUD.hide(for: view, animated: true){
            completion?()
        }
    }
    
    static func dismissHUD(_ view:UIView){
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
    }
}
