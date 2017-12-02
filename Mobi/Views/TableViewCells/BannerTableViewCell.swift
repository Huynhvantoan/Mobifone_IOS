//
//  BannerTableViewCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/6/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var imgAvarta: UIImageView!
    
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if !UserObj.currentUserProfile.isGuest {
            self.lbUserName.text = UserObj.currentUserProfile.username
            self.lbEmail.text = UserObj.currentUserProfile.email
        }
        
        self.imgAvarta.layer.cornerRadius = self.imgAvarta.bounds.size.width / 2
        self.imgAvarta.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func height() -> CGFloat {
        return 200
    }
    
    
    
    @IBAction func onTapBtInfo(_ sender: UIButton) {
        
    }
}
