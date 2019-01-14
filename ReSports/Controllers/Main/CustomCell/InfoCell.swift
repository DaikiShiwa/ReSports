//
//  InfoCell.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/02.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class InfoCell:UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var detailLabel:UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
