//
//  UpdateProfileVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/14/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class UpdateProfileVC: BaseViewController {

//    @IBOutlet weak var txtPassword: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btUpdateProfile: UIButton!
    @IBOutlet weak var btChangePassword: UIButton!
    
    static func initWithStoryboard() -> UpdateProfileVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btUpdateProfile.defaultButton()
        self.btChangePassword.defaultButton()
        self.navigationItem.title = "Thay đổi thông tin"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Action
    @IBAction func onTapbtUpdate(_ sender: UIButton) {
    }
    
    @IBAction func onTapbtChangePass(_ sender: UIButton) {
        let changePassVC = ChangePassVC.initWithStoryboard()
        
        self.pushVC(changePassVC)
    }

}
