//
//  CustomerBusinessDetailTableViewCell.swift
//  B4Black
//
//  Created by eWeb on 16/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class CustomerBusinessDetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingImg: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
