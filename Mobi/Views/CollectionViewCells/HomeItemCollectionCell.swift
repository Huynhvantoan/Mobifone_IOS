//
//  HomeItemCollectionCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class HomeItemCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewMain.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.5, borderWidth: 1)
    }
    
    func config(title: String, imgName: String) {
        self.lbTitle.text = NSLocalizedString(title, comment: "")
        self.imgIcon.image = UTIL.getImageByName(imageName: imgName)
    }
}
