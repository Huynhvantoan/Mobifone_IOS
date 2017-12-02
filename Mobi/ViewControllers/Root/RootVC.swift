//
//  RootViewController.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/5/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import REFrostedViewController

protocol RootViewControllerDelegate {
    func didHideMenuViewController()
}

class RootVC: REFrostedViewController {
    
        var delegateRootVC: RootViewControllerDelegate?
        
        override func awakeFromNib() {
            self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuNavigationVC")
            let slideMenu = self.storyboard?.instantiateViewController(withIdentifier: "SlideMenuVC") as! SlideMenuVC
//            delegateRootVC = slideMenu
//            slideMenu.callBackHideSlideMenu = {
//                self.hideMenuViewController(completionHandler: {
//                    self.delegateRootVC?.didHideMenuViewController()
//                })
//            }
//            slideMenu.callbackLogout = {
//                self.hideMenuViewController()
//            }
            self.menuViewController = slideMenu
        }
}
