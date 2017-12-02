//
//  MainUploadImageVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/21/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class MainUploadImageVC: BaseViewController {

    var pageMenu : CAPSPageMenu?
    var indexPage : Int? = 0
    
    
    static func initWithStoryboard() -> MainUploadImageVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainUploadImageVC") as! MainUploadImageVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShowBanner = false
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        
        let newsTraTruocVC = UploadImageVC.initWithStoryboard()
        newsTraTruocVC.title = "TRẢ TRƯỚC"
        newsTraTruocVC.typeVC = UploadImageType.ImageTraTruoc
        controllerArray.append(newsTraTruocVC)
        
        
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! BaseTabBarController
        let tabViewController1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadImageVC") as! UploadImageVC
        let tabViewController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadImageVC") as! UploadImageVC
        tabBarVC.title = "TRẢ SAU"
        
        tabViewController1.typeVC = UploadImageType.ImageTraSauCaNhan
        tabViewController1.tabBarItem = UITabBarItem(
            title: NSLocalizedString("M_MYSELF", comment: ""),
            image: UIImage(named: "ic_home"),
            tag: 1)
        
        tabViewController2.typeVC = UploadImageType.ImageTraSauCongTy
        tabViewController2.tabBarItem = UITabBarItem(
            title: NSLocalizedString("M_COMPANY", comment: ""),
            image:UIImage(named: "ic_business") ,
            tag:2)
        
        tabBarVC.navigationItem.title = NSLocalizedString("M_PROCEDURE", comment: "")
        tabBarVC.viewControllers = [tabViewController1, tabViewController2]
        
        controllerArray.append(tabBarVC)
        
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .menuMargin(20.0),
            .menuHeight(50.0),
            .selectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 13.0)!),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.1)
            
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        
        pageMenu?.delegate = self
        
        pageMenu?.moveToPage(self.indexPage!)
        
        self.view.addSubview((pageMenu?.view)!)
        
    }
    
    override func setupUI() {
        super .setupUI()
        self.navigationItem.title = NSLocalizedString("M_UPLOAD", comment: "").uppercased()
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

extension MainUploadImageVC: CAPSPageMenuDelegate {
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moving to page \(index)")
        
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moved to page \(index)")
        
    }
}
