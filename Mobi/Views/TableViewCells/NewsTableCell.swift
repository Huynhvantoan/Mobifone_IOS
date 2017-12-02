//
//  NewsTableCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsTableCell: UITableViewCell {

    @IBOutlet weak var viewMains: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewMains.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.2, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(cateObj: CategoryObj) {
        self.lbTitle.text = cateObj.name
        self.imgTitle.af_setImage(withURL: URL(string: cateObj.image!)!)
    }
}
