//
//  NewsVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class NewsVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrCongNo : [CategoryObj]?
    var categoryType : CategoryType = .Procedure_HM_Tra_Truoc
    
    var customNavigationController: UINavigationController?
    
    static func initWithStoryboard() -> NewsVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShowBanner = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func setupUI() {
        super.setupUI();
        pushVC(<#T##vc: UIViewController##UIViewController#>)
    }
    
    func loadData() {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.category(byType: self.categoryType, _completion: { (codeRespond, congnoObj) in
            self.arrCongNo = congnoObj;
            self.tableView.reloadData()
            self.dismissLoadingIndicator(inView: self.view)
        })
    }
}

extension NewsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrCongNo == nil {
            return 0
        }
        return (self.arrCongNo?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryObj = self.arrCongNo![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableCell.self), for: indexPath) as! NewsTableCell
        cell.config(cateObj: categoryObj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryObj = self.arrCongNo![indexPath.row]
        
        let webViewVC = WebViewVC.initWithStoryboard()
        webViewVC.strUrl = categoryObj.url
        webViewVC.setTitlePage(title: categoryObj.name!)
        if self.navigationController != nil {
            self.pushVC(webViewVC)
        } else {
            self.customNavigationController?.pushViewController(webViewVC, animated: true)
        }
        
        
    }
}
