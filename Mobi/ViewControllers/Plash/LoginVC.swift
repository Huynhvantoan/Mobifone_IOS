//
//  LoginVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/27/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btLoginForGuest: UIButton!
    
    static func initWithStoryboard() -> LoginVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar?.isHidden = true
        // Do any additional setup after loading the view.
        
        self.btLogin.defaultButton()
        self.btLoginForGuest.defaultButton()
        
    
//        emailField.detail = "Error, incorrect email"
//        emailField.textColor = .black
//        emailField.isClearIconButtonEnabled = true
//        emailField.delegate = self
//        emailField.isPlaceholderUppercasedWhenEditing = true
//        //        emailField.placeholderAnimation = .hidden
//
//        // Set the colors for the emailField, different from the defaults.
//        emailField.placeholderNormalColor = Color.red.darken4
//        emailField.placeholderActiveColor = Color.pink.base
//        emailField.dividerNormalColor = Color.grey.base
//        emailField.dividerActiveColor = Color.red.base
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapBtLogin(_ sender: UIButton) {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.loginUser(byPassword: self.txtPassword!.text, byUsername: self.txtUserName!.text, _completion: { (CodeRespone, userObj) in
            userObj?.isGuest = false
            UserObj.currentUserProfile = userObj!
            APPDELEGATE.resetToRootViewHome(onComplete: nil)
            
            self.dismissLoadingIndicator(inView: self.view)
        }, _failed: { (strMessage) in
            self.showToastFailure(message: strMessage!)
            self.dismissLoadingIndicator(inView: self.view)
        })
        
        
    }
    
    @IBAction func onTapBtLoginGuest(_ sender: UIButton) {
        let user = UserObj()
        user.isGuest = true
        UserObj.currentUserProfile = user
        
        (UIApplication.shared.delegate as! AppDelegate).resetToRootViewHome { (ok) in
            
        }
    }
    
    @IBAction func onTapBtForGetPassword(_ sender: UIButton) {
        
    }

    @IBAction func onTapBtRegister(_ sender: UIButton) {
        let registerViewControler = RegisterVC.initWithStoryboard()
        self.pushVC(registerViewControler)
    }
    
}



