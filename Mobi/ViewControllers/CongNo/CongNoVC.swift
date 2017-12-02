//
//  CongNoVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class CongNoVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrCongNo : [CongNoObj]?
    
    static func initWithStoryboard() -> CongNoVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongNoVC") as! CongNoVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.loadData()
        self.navigationItem.title = NSLocalizedString("M_LIABILITIES", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.listCongNo(_completion: { (codeRespond, congnoObj) in
            self.arrCongNo = congnoObj;
             self.tableView.reloadData()
            self.dismissLoadingIndicator(inView: self.view)
        }) { (strCode) in
            
            self.dismissLoadingIndicator(inView: self.view)
        }
    }
}

extension CongNoVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrCongNo == nil {
            return 0
        }
        return (self.arrCongNo?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let congNoObj = self.arrCongNo![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CongNoTableCell.self), for: indexPath) as! CongNoTableCell
        cell.config(congNoObj: congNoObj)
        return cell
    }
}
