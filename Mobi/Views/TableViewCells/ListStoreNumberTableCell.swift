//
//  ListStoreNumberTableCell.swift
//  Mobi
//
//  Created by HeoConUnIn on 10/11/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit

protocol ListStoreNumberTableCellDelegate {
    func onTapButtonAddShopping(_ cell: ListStoreNumberTableCell)
}

class ListStoreNumberTableCell: UITableViewCell {

    @IBOutlet weak var viewMains: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbGoiCuoc: UILabel!
    
    var delegate: ListStoreNumberTableCellDelegate?
    var _simObj: SimObj!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewMains.makeCornerAndShadowAndBorder(5, shadowRadius: 2, shadowOpacity: 0.2, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(simObj: SimObj) {
        self._simObj = simObj
        self.lbTitle.text = simObj.name
        self.lbPrice.text = "\(String(describing: simObj.price!)) VNĐ"
        self.lbGoiCuoc.text = simObj.originPrice
    }

    @IBAction func onTapbtAddShop(_ sender: UIButton) {
        delegate?.onTapButtonAddShopping(self)
    }
}
