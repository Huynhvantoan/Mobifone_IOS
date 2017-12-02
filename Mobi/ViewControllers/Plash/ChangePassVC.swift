//
//  ForgetPassVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 9/27/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class ChangePassVC: BaseViewController {

    @IBOutlet weak var txtPasswordOld: UITextField!
    @IBOutlet weak var txtPasswordNew: UITextField!
    @IBOutlet weak var btForgetPass: UIButton!
    
    static func initWithStoryboard() -> ChangePassVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassVC") as! ChangePassVC
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btForgetPass.defaultButton()
        self.navigationItem.title = "Thay đổi mật khẩu"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action
    @IBAction func onTapbtChangePass(_ sender: UIButton) {
        self.showLoadingIndicator(inView: self.view)
        ServiceManager.shared.changePassword(byNewPassword: self.txtPasswordNew.text, byOldPassword: self.txtPasswordOld.text, byUserObj: UserObj.currentUserProfile) { (condeRespond, message) in
            self.dismissLoadingIndicator(inView: self.view, completion: {
                self.showToastSuccess(message: message == nil ? "" : message!)
            })
        }
    }

}
