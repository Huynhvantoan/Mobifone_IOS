//
//  UploadImageVC.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/18/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import ALCameraViewController

class UploadImageVC: BaseViewController {

    @IBOutlet weak var viewSend: UIView!
    @IBOutlet weak var btSend: UIButton!
    
    @IBOutlet var arrViewItem: [UIView]!
    @IBOutlet var arrViewImage: [UIImageView]!
    @IBOutlet var arrButtonChooseImage: [UIButton]!
    
    var simObj : SimObj?
    var cateObj : CategoryObj?
    var typeVC : UploadImageType?
    var btIndexSelect : Int?

    var libraryEnabled: Bool = true
    var croppingEnabled: Bool = true
    var allowResizing: Bool = true
    var allowMoving: Bool = true
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    
    var croppingParameters: CroppingParameters {
        return CroppingParameters(isEnabled: croppingEnabled, allowResizing: allowResizing, allowMoving: allowMoving, minimumSize: minimumSize)
    }
    
    static func initWithStoryboard() -> UploadImageVC{
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadImageVC") as! UploadImageVC
        return viewController;
    }
    
    override func viewDidLoad() {
//        self.typeVC = UploadImageType.ImageShopCard
        super.viewDidLoad()
        self.isShowBanner = false
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = NSLocalizedString("M_UPLOAD", comment: "")
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.viewSend.makeCornerAndShadow(self.viewSend.frame.size.height / 2, shadowRadius: 2, shadowOpacity:  0.7)
        for item in arrViewItem {
            if item.tag < (self.typeVC?.getItem())! {
                let btChooseImage = self.arrButtonChooseImage[item.tag]
                btChooseImage.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.2, borderWidth: 1)
                btChooseImage.setTitle(self.typeVC?.getListNameItem()[item.tag], for: .normal)
                item.isHidden = false
                btChooseImage.addTarget(self, action: #selector(self.onTapbtPickerImage(_:)), for: .touchUpInside)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showButtonSend() {
        var flagCheck = true
        for item in arrViewImage {
            if item.tag < (self.typeVC?.getItem())! {
                guard item.image != nil else {
                    flagCheck = false
                    break
                }
            }
        }
        
        self.viewSend.isHidden = !flagCheck
    }

   
// MARK: - Action
    @IBAction func onTapbtSend(_ sender: UIButton) {
        var postImage = [PostingImage]()
        if typeVC == UploadImageType.ImageShopCard || typeVC == UploadImageType.ImageTraTruoc {
            for item in arrViewItem {
                if item.tag < (self.typeVC?.getItem())! {
                    let chooseImage = self.arrViewImage[item.tag]
                    let imageType = ImageKeyTraTruoc(rawValue: item.tag)
                    
                    postImage.append(PostingImage(imageKey: imageType?.getNameItem() , pathImage: nil, image: chooseImage.image, imageName:"image\(item.tag).jpg"))
                }
            }
            
        } else if typeVC == UploadImageType.ImageTraSauCongTy || typeVC == UploadImageType.ImageTraSauCaNhan {
            for item in arrViewItem {
                if item.tag < (self.typeVC?.getItem())! {
                    let chooseImage = self.arrViewImage[item.tag]
                    let imageType = ImageKeyTraTruoc(rawValue: item.tag)
                    
                    postImage.append(PostingImage(imageKey: imageType?.getNameItem() , pathImage: nil, image: chooseImage.image, imageName:"image\(item.tag).jpg"))
                }
            }
            
        }
        
        self.showLoadingIndicator(inView: self.view, title: "")
        ServiceManager.shared.uploadImge(bytype: typeVC!, simObj: self.simObj!, cateObj: self.cateObj!, listImage: postImage, _completion: { (codeRespone, strMessage) in
            self.showToastFailure(message: "Tải ảnh thất bại")
            self.dismissLoadingIndicator(inView: self.view)
        })
    }
    
    @IBAction func onTapbtPickerImage(_ sender: UIButton) {
        self.btIndexSelect = sender.tag
        
        let optionMenu = UIAlertController(title: nil, message: "Chọn thể loại", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Thư Viện", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: self.croppingParameters) { [weak self] image, asset in
                self?.arrViewImage[(self?.btIndexSelect)!].image = image
                self?.dismiss(animated: true, completion: nil)
                self?.showButtonSend()
            }
            
            self.present(libraryViewController, animated: true, completion: nil)
        })
        let saveAction = UIAlertAction(title: "Máy ảnh", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let cameraViewController = CameraViewController(croppingParameters: self.croppingParameters, allowsLibraryAccess: self.libraryEnabled) { [weak self] image, asset in
                self?.arrViewImage[(self?.btIndexSelect)!].image = image
                self?.dismiss(animated: true, completion: nil)
            }
            self.present(cameraViewController, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Đóng", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}
