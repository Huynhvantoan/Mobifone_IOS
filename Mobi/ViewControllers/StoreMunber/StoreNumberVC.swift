//
//  StoreNumberVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/11/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class StoreNumberVC: BaseViewController {
    
    var pageMenu : CAPSPageMenu?
    var indexPage : Int? = 0
    
    
    static func initWithStoryboard() -> StoreNumberVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoreNumberVC") as! StoreNumberVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShowBanner = false
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        
        let newsTraTruocVC = ListStoreNumberVC.initWithStoryboard()
        newsTraTruocVC.title = "TRA TRƯỚC"
        newsTraTruocVC.storeNumber = .TraTruoc
        newsTraTruocVC.customNavigationController = self.navigationController
        controllerArray.append(newsTraTruocVC)
        
        let newsTraSauVC = ListStoreNumberVC.initWithStoryboard()
        newsTraSauVC.title = "TRA SAU"
        newsTraSauVC.storeNumber = .TraSau
        newsTraSauVC.customNavigationController = self.navigationController
        controllerArray.append(newsTraSauVC)
        
        let newsTraSauDoanhNghiepVC = ListStoreNumberVC.initWithStoryboard()
        newsTraSauDoanhNghiepVC.title = "TRA SAU DOANH NGHIỆP"
        newsTraSauDoanhNghiepVC.storeNumber = .TraTruocSoDep
        newsTraSauDoanhNghiepVC.customNavigationController = self.navigationController
        controllerArray.append(newsTraSauDoanhNghiepVC)
        
        let newsCamKetSoDepVC = ListStoreNumberVC.initWithStoryboard()
        newsCamKetSoDepVC.title = "CAM KẾT SỐ ĐẸP"
        newsCamKetSoDepVC.storeNumber = .CamKet
        newsCamKetSoDepVC.customNavigationController = self.navigationController
        controllerArray.append(newsCamKetSoDepVC)
        
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
        self.navigationItem.title = NSLocalizedString("M_STORE", comment: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension StoreNumberVC: CAPSPageMenuDelegate {
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moving to page \(index)")
        
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        print("Moved to page \(index)")
        
    }
}
