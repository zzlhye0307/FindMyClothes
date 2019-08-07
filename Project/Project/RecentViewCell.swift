//
//  RecentViewCell.swift
//  Project
//
//  Created by mac on 07/08/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RecentViewCell: UITableViewCell {
    @IBOutlet var recentImgView: UIImageView!
    @IBOutlet var recentCategoryLbl: UILabel!
    @IBOutlet var recentPatternLbl: UILabel!
    @IBOutlet var recentFabricLbl: UILabel!
    @IBOutlet var recentDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
