//
//  TableViewCell.swift
//  Project
//
//  Created by mac on 01/08/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    let heartOn = UIImage(named: "heart_on.png")
    let heartOff = UIImage(named: "heart_off.png")
    var tableView:FavoriteViewController?
    var isHeartOn = true

    @IBOutlet var cellImgView: UIImageView!
    @IBOutlet var cellTitleLabel: UILabel!
    @IBOutlet var cellPriceLabel: UILabel!
    @IBOutlet var cellLikeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if isHeartOn {
            cellLikeBtn.setImage(heartOff, for: UIControl.State.normal)
            isHeartOn = false
            tableView?.deleteHeartOffCell(self)
        }
        else {
            cellLikeBtn.setImage(heartOn, for: UIControl.State.normal)
            isHeartOn = true
        }
    }
    
}
