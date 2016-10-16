//
//  GOTEpisodeTableViewCell.swift
//  AC3.2-GameOfThrones
//
//  Created by Victor Zhong on 10/14/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GOTEpisodeTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
