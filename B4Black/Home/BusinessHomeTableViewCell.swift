//
//  BusinessHomeTableViewCell.swift
//  B4Black
//
//  Created by eWeb on 15/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class BusinessHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    
    @IBOutlet weak var namelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
