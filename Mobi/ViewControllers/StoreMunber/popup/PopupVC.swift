//
//  PopupVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/17/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class PopupVC: BaseViewController {

    @IBOutlet weak var LayoutConstraintCenter: NSLayoutConstraint!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewDropdown: UIView!
    @IBOutlet weak var lbDropDown: UILabel!
    @IBOutlet var arrTextField: [UITextField]!
    
    var simObj : SimObj?
    var cateObj : CategoryObj?
    var arrCate : [CategoryObj]? = []
    var customNavigationController: UINavigationController?
    var cateIndex : Int! = 0
    var storeNumber : StoreNumber = .TraSau
    
    static func initWithStoryboard() -> PopupVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        return viewController;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PopupVC.keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PopupVC.keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
        
        self.loadCate()
        self.viewDropdown.makeCornerAndShadowAndBorder(3, shadowRadius: 1, shadowOpacity: 0.2, borderWidth: 1)
        self.viewMain.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.2, borderWidth: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCate() {
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.category(byType: .Get_Cate, _completion: { (codeRespond, listCate) in
            self.arrCate = listCate
            self.cateObj = listCate?[self.cateIndex]
            self.lbDropDown.text = (listCate?[self.cateIndex])?.name
            self.dismissLoadingIndicator(inView: self.view)
        })
    }
    
    // maMARK: - KeyBoard
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.size.height)
            self.LayoutConstraintCenter.constant = -(((SCREEN_HEIGHT() - keyboardSize.size.height - self.viewMain.frame.size.height)/2))
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.LayoutConstraintCenter.constant = 0
            print(keyboardSize.size.height)
        }
    }
    
    // maMARK: - Action
    @IBAction func onTapBtDissmis(_ sender: UIButton) {
        self.view.endEditing(true)
        self.dismissVC(completion: nil)
    }
    
    @IBAction func onTapBtOk(_ sender: UIButton) {
        if self.arrTextField[0].text?.length == 0 || self.arrTextField[1].text?.length == 0 || self.arrTextField[2].text?.length == 0 {
            self.showToastFailure(message: NSLocalizedString("iToast_PopupVC_Input_all", comment: ""))
            return
        }
        
        self.dismissVC(completion: {
            
            if self.storeNumber == .TraTruoc || self.storeNumber == .CamKet {
                let uploadVC = UploadImageVC.initWithStoryboard()
                uploadVC.simObj = self.simObj
                uploadVC.cateObj = self.cateObj
                uploadVC.typeVC = UploadImageType.ImageShopCard
                self.customNavigationController?.pushViewController(uploadVC, animated: true)
                
            } else if self.storeNumber == .TraSau {
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
                
                tabBarVC.navigationItem.title = NSLocalizedString("M_STORE", comment: "")
                tabBarVC.viewControllers = [tabViewController1, tabViewController2]
                self.customNavigationController?.pushViewController(tabBarVC, animated: true)
            }
            
            
        })
    }
    
    @IBAction func onTapBtCate(_ sender: UIButton) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.tag = 0
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        pickerView.selectRow(self.cateIndex, inComponent: 0, animated: true)
        let editRadiusAlert = UIAlertController(title: "Chọn thể loại", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Chọn", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }
}

extension PopupVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.arrCate?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Montserrat", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.left
        }
        let typeSimObj = self.arrCate![row]
        pickerLabel?.text = typeSimObj.name
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cateObj = self.arrCate![row]
        self.lbDropDown.text = self.cateObj?.name
        self.cateIndex = row
    }
}

extension PopupVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            self.view.endEditing(true)
            return true
        }
        
        let txtNext = self.arrTextField[textField.tag + 1]
        txtNext.becomeFirstResponder()
        return true
    }
}
