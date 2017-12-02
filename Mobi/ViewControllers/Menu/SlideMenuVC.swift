//
//  SlideMenuVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/5/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class SlideMenuVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShowBanner = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SlideMenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayStringMenuLeft.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return arrayStringMenuLeft[section][0].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BannerTableViewCell.self), for: indexPath) as! BannerTableViewCell
            return cell
        
        } else {
            if indexPath.section == 2 && indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableViewCell.self), for: indexPath) as! HeaderTableViewCell
                cell.config(title: arrayStringMenuLeft[indexPath.section][0][indexPath.row])
                return cell
            
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self), for: indexPath) as! MenuTableViewCell
                cell.config(title: arrayStringMenuLeft[indexPath.section][0][indexPath.row], imgName: arrayStringMenuLeft[indexPath.section][1][indexPath.row])
                
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return BannerTableViewCell.height()
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "MenuNavigationVC") as! MenuNavigationVC
        
        
        if indexPath.section == 0 {
            // Profile
            
        } else if indexPath.section == 1{
            // Store Sim
            if indexPath.row == 1 {
                let subHomeVC = SubHomeVC.initWithStoryboard()
                let home = HomeVC.initWithStoryboard()
                navigationController.viewControllers = [home, subHomeVC]
            }
            
            // Promotion
            if indexPath.row == 2 {
                let p = PromotionVC.initWithStoryboard()
                let home = HomeVC.initWithStoryboard()
                navigationController.viewControllers = [home, p]
            }

            // Congno
            if indexPath.row == 3 {
                if UserObj.currentUserProfile.auth_code == nil || UserObj.currentUserProfile.auth_code?.length == 0 {
                    UserObj.currentUserProfile = UserObj()
                    APPDELEGATE.resetToRootViewLogin(onComplete: nil)
                } else {
                    let congNoVC = CongNoVC.initWithStoryboard()
                    let home = HomeVC.initWithStoryboard()
                    navigationController.viewControllers = [home, congNoVC]
                }
            }
            
            // Thu tuc
            if indexPath.row == 4 {
                
                let home = HomeVC.initWithStoryboard()
                
                let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! BaseTabBarController
                let tabViewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
                let tabViewController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
                tabBarVC.navigationItem.title = NSLocalizedString("M_PROCEDURE", comment: "")
                
                tabViewController2.categoryType = .Procedure_HM_Tra_Sau
                tabBarVC.viewControllers = [tabViewController1, tabViewController2]
                
                tabViewController1.tabBarItem = UITabBarItem(
                    title: NSLocalizedString("M_TRA_TRUOC", comment: ""),
                    image: UIImage(named: "ic_home"),
                    tag: 1)
                tabViewController2.tabBarItem = UITabBarItem(
                    title: NSLocalizedString("M_TRA_SAU", comment: ""),
                    image:UIImage(named: "ic_business") ,
                    tag:2)

                navigationController.viewControllers = [home, tabBarVC]
            }
            
            // Upload
            if indexPath.row == 5 {
                let uploadImageVC = MainUploadImageVC.initWithStoryboard()
                let home = HomeVC.initWithStoryboard()
                navigationController.viewControllers = [home, uploadImageVC]
            }
            
            // Profile
            if indexPath.row == 6 {
                if UserObj.currentUserProfile.auth_code == nil || UserObj.currentUserProfile.auth_code?.length == 0 {
                    UserObj.currentUserProfile = UserObj()
                    APPDELEGATE.resetToRootViewLogin(onComplete: nil)
                } else {
                    let updateProfileVC = UpdateProfileVC.initWithStoryboard()
                    let home = HomeVC.initWithStoryboard()
                    navigationController.viewControllers = [home, updateProfileVC]
                }
            }
            
        } else {
            // ConTact
            if indexPath.row == 1 {
                let contactVC = ContactVC.initWithStoryboard()
                let home = HomeVC.initWithStoryboard()
                navigationController.viewControllers = [home,contactVC]
            }
            
            if indexPath.row == 2 {
                UserObj.currentUserProfile = UserObj()
                APPDELEGATE.resetToRootViewLogin(onComplete: nil)
            }
        }
        
        self.frostedViewController.contentViewController = navigationController
        self.frostedViewController.hideMenuViewController()
    }
}
