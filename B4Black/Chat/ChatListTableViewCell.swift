//
//  ChatListTableViewCell.swift
//  B4Black
//
//  Created by eWeb on 20/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var Backview: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameTF: UILabel!
    @IBOutlet weak var chatTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

     
    }

}
