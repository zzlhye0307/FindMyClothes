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

    // Cell 선택되면 해당 라벨들 넣어서 다시 한 번 검색 진행하도록
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //present(resultView!, animated: true, completion: nil)
        // Configure the view for the selected state
    }
    
}
