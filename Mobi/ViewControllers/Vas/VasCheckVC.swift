//
//  VasCheckVC.swift
//  Mobi
//
//  Created by Hoang Do on 11/1/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class VasCheckVC: UIViewController {

    static func initWithStoryboard() -> VasCheckVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VasCheckVC") as! VasCheckVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
