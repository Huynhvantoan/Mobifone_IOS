//
//  BaseTabBarController.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var leftButton:UIButton!
    var rightButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.loadNavigationBar(true)
    }
    
    func loadNavigationBar(_ isLoad: Bool) {
        if isLoad {
            self.configureNavBar()
        }
    }
    
    func configureNavBar() {
        self.setLeftMenuButtonImage()
        self.changeNavigationBarToDefaultStyle()
    }
    
    func changeNavigationBarToDefaultStyle() {
        
        let attributes:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as? [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.colorWithHexString("36609E")
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setLeftMenuButtonImage() {
        // init left button
        self.leftButton = UIButton(frame: CGRect(x: 10, y: 0, width: 44, height: 44))
        self.leftButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
        self.leftButton?.addTarget(self, action: #selector(self.leftMenuButtonClicked(_:)), for: .touchUpInside)
        self.leftButton?.setImage(UIImage(named: "left_arrow"), for: UIControlState())
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftButton!)
    }
    
    @IBAction func leftMenuButtonClicked(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
