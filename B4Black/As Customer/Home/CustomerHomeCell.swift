//
//  CustomerHomeCell.swift
//  B4Black
//
//  Created by eWeb on 22/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class CustomerHomeCell: UICollectionViewCell {

    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var splashImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var collectImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BottomView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
    }

}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
