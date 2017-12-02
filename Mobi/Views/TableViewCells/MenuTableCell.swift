//
//  MenuTableCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/6/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(title: String, imgName: String) {
        self.lbTitle.text = NSLocalizedString(title, comment: "")
        self.imgIcon.image = UTIL.getImageByName(imageName: imgName)
    }
}
