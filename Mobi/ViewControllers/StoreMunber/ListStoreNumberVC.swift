//
//  ListStoreNumberVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/11/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class ListStoreNumberVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btType: UIButton!
    @IBOutlet weak var btFisrtNumber: UIButton!
    
    var customNavigationController: UINavigationController?
    
    var arrSim : [SimObj]? = []
    var arrTypeSim : [TypeSimObj]? = []
    var storeNumber : StoreNumber = .TraSau
    var pageIndex : Int! = 1
    var firstNumber : String! = ""
    var typeNumber : String! = ""
    var firstNumberIndex : Int! = 0
    var typeNumberIndex : Int! = 0
    
    static func initWithStoryboard() -> ListStoreNumberVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListStoreNumberVC") as! ListStoreNumberVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isShowBanner = false
        self.loadTypeSim()
        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super .setupUI()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTypeSim() {
        ServiceManager.shared.typeSim(_completion: { (codeRespone, typeSim) in
            self.arrTypeSim?.append(contentsOf: typeSim as! [TypeSimObj])
            let firstTypeSim = TypeSimObj()
            firstTypeSim.tenKey = ""
            firstTypeSim.tenName = "Dạng sim"
            self.arrTypeSim?.insert(firstTypeSim, at: 0)
        })
    }

    func loadData() {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.searchSim(bySearch: self.txtSearch.text, byPage: self.pageIndex, byStore: self.storeNumber.getString(), byFirstNumber: self.firstNumber, byTypeNumber: self.typeNumber) { (codeRespone, simObj, nextLink) in
            if self.arrSim == nil {
                self.arrSim = simObj
            } else {
                if simObj != nil {
                    self.arrSim?.append(contentsOf: simObj as! [SimObj])
                }
            }
            self.tableView.reloadData()
            self.dismissLoadingIndicator(inView: self.view)
        }
    }
    
    @IBAction func onTapBtType(_ sender: UIButton) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.tag = 0
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        pickerView.selectRow(self.typeNumberIndex, inComponent: 0, animated: true)
        let editRadiusAlert = UIAlertController(title: "Chọn dạng sim", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    @IBAction func onTapBtFirstNumber(_ sender: UIButton) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.tag = 1
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(self.firstNumberIndex, inComponent: 0, animated: true)
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Chọn đầu số", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
    
    @IBAction func onTapBtSearch(_ sender: UIButton) {
        self.pageIndex = 1
        self.arrSim = nil
        self.loadData()
    }

}

extension ListStoreNumberVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 0: TypeSim
        if pickerView.tag == 0 {
            return (self.arrTypeSim?.count)!
        } else {
            return arrayStringFirstNumber.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 0: TypeSim
        if pickerView.tag == 0 {
            let typeSimObj = self.arrTypeSim![row]
            return typeSimObj.tenName!
        } else {
            return arrayStringFirstNumber[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // 0: TypeSim
        if pickerView.tag == 0 {
            let typeSimObj = self.arrTypeSim![row]
            self.typeNumber = typeSimObj.tenKey
            self.btType.setTitle(typeSimObj.tenName, for: .normal)
            self.typeNumberIndex = row
            
        } else {
            if row == 0 {
                self.firstNumber = ""
                self.btFisrtNumber.setTitle(arrayStringFirstNumber[row], for: .normal)
            } else {
                self.firstNumber = arrayStringFirstNumber[row]
                self.btFisrtNumber.setTitle(arrayStringFirstNumber[row], for: .normal)
            }
            self.firstNumberIndex = row
            
        }
    }
}

extension ListStoreNumberVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrSim == nil {
            return 0
        }
        return (self.arrSim?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let simObj = self.arrSim![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListStoreNumberTableCell.self), for: indexPath) as! ListStoreNumberTableCell
        cell.config(simObj: simObj)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (self.arrSim?.count)! - 1) {
            self.pageIndex = self.pageIndex! + 1
            self.loadData()
        }
    }
}

extension ListStoreNumberVC : ListStoreNumberTableCellDelegate {
    func onTapButtonAddShopping(_ cell: ListStoreNumberTableCell) {
        
        if self.storeNumber == .TraSau || self.storeNumber == .CamKet || self.storeNumber == .TraTruoc {
            let vc = PopupVC.initWithStoryboard()
            vc.customNavigationController = self.customNavigationController
            vc.storeNumber = self.storeNumber
            vc.simObj = cell._simObj
            
            self.presentVC(vc)
        }
    }
}
