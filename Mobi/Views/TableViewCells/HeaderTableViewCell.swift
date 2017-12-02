//
//  HeaderTableViewCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/6/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(title: String) {
        self.lbTitle.text = NSLocalizedString(title, comment: "")
    }

}
