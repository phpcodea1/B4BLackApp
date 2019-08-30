//
//  RatingTableViewCell.swift
//  B4Black
//
//  Created by eWeb on 15/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var userimage: UIImageView!
  @IBOutlet weak var ratingdate: UILabel!
      @IBOutlet weak var ratingdesc: UILabel!
    
    @IBOutlet weak var SeeMoreButton: UIButton!
    @IBOutlet weak var usernamelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
