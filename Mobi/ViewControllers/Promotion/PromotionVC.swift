//
//  PromotionViewController.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/9/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class PromotionVC: BaseViewController {
    
    
    var pageMenu : CAPSPageMenu?
    
    static func initWithStoryboard() -> PromotionVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        
        let newsTraSauCaNhanVC = NewsVC.initWithStoryboard()
        newsTraSauCaNhanVC.title = "TRA SAU CÁ NHÂN"
        newsTraSauCaNhanVC.categoryType = .CTKM_KMTS_Ca_Nhan
        newsTraSauCaNhanVC.customNavigationController = self.navigationController
        controllerArray.append(newsTraSauCaNhanVC)
        
        let newsTraSauCongTyVC = NewsVC.initWithStoryboard()
        newsTraSauCongTyVC.title = "TRA SAU CÔNG TY"
        newsTraSauCongTyVC.categoryType = .CTKM_KMTS_Doanh_Nghiep
        newsTraSauCongTyVC.customNavigationController = self.navigationController
        controllerArray.append(newsTraSauCongTyVC)
        
        let newsCamKetSoDepVC = NewsVC.initWithStoryboard()
        newsCamKetSoDepVC.title = "CAM KẾT SỐ ĐẸP"
        newsCamKetSoDepVC.categoryType = .CTKM_Cam_Ket_So_Dep
        newsCamKetSoDepVC.customNavigationController = self.navigationController
        controllerArray.append(newsCamKetSoDepVC)
        
        let newsNapTheNgayVC = NewsVC.initWithStoryboard()
        newsNapTheNgayVC.title = "NẠP THẺ NGAY"
        newsCamKetSoDepVC.categoryType = .CTKM_KM_Nap_The_Theo_Ngay
        newsCamKetSoDepVC.customNavigationController = self.navigationController
        controllerArray.append(newsNapTheNgayVC)
        
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
        
        self.view.addSubview((pageMenu?.view)!)
        
    }
    
    override func setupUI() {
        super .setupUI()
        self.navigationItem.title = NSLocalizedString("M_PROMOTION", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PromotionVC: CAPSPageMenuDelegate {
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moving to page \(index)")

    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moved to page \(index)")
        
    }
}
