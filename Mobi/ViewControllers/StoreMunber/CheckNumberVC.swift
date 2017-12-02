//
//  CheckNumberVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/12/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class CheckNumberVC: BaseViewController {

    @IBOutlet weak var txtCheckPhone: UITextField!
    @IBOutlet weak var lbError: UILabel!
    
    static func initWithStoryboard() -> CheckNumberVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheckNumberVC") as! CheckNumberVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super .setupUI()
        self.navigationItem.title = NSLocalizedString("M_STORE", comment: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTapCheck(_ sender: Any) {
        ServiceManager.shared.checkNumberPhone(byString: self.txtCheckPhone.text!) { (codeRespond, strError) in
            self.lbError.text = strError
        }
    }

}
