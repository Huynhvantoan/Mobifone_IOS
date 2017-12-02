//
//  CongNoTableCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/8/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

class CongNoTableCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbPayMent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewMain.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.3, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(congNoObj: CongNoObj) {
        self.lbPhone.text = congNoObj.phone
        self.lbName.text = congNoObj.name
        self.lbDate.text = congNoObj.date
        self.lbPayMent.text = congNoObj.payment
    }

}
