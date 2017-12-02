//
//  RegisterVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/27/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit


class RegisterVC: BaseViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btRegister: UIButton!
    
    static func initWithStoryboard() -> RegisterVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navBar?.isHidden = true
        self.setLeftMenuButtonImage()
        self.btRegister.defaultButton()
        self.navigationController?.title = "Đăng Ký"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    // MARK: - Action
    
    @IBAction func onTapBtRegister(_ sender: UIButton) {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.registerUser(byPassword: self.txtPassword!.text, byUsername: self.txtUserName!.text, byEmail: self.txtEmail!.text, _completion: { (codeResponse, userObj) in
            let loginViewControler = LoginVC.initWithStoryboard()
            self.presentVC(loginViewControler)
            self.dismissLoadingIndicator(inView: self.view)
        }) { (strMessage) in
            self.showToastFailure(message: strMessage!)
            self.dismissLoadingIndicator(inView: self.view)
        }
    }
    
    @IBAction func onTapBtBack(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
