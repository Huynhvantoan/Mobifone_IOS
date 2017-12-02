//
//  testViewController.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class SubHomeVC: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static func initWithStoryboard() -> SubHomeVC {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubHomeVC") as! SubHomeVC
        return viewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        self.collectionView.reloadData()
        self.navigationItem.title = NSLocalizedString("M_STORE", comment: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SubHomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var i = 0
        if UserObj.currentUserProfile.isGuest {
           i = 1
        }
        return arrayStringSubMenuInSim[0].count - i
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SubHomeItemCollectionCell.self) , for: indexPath) as! SubHomeItemCollectionCell
        cell.config(title: arrayStringSubMenuInSim[0][indexPath.row], imgName: arrayStringSubMenuInSim[1][indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 2) - 1, height: collectionView.frame.size.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row <= 3 {
            let listNumberVC = StoreNumberVC.initWithStoryboard()
            listNumberVC.indexPage = indexPath.row
            self.pushVC(listNumberVC)
        } else {
            let checkNumberVC = CheckNumberVC.initWithStoryboard()
            
            self.pushVC(checkNumberVC)
        }
        
    }
}
