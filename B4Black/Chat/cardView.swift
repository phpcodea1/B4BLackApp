//
//  cardView.swift
//  Medical Congress App
//
//  Created by admin on 05/10/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

  @IBDesignable class cardView: UIView
  {
   @IBInspectable var cornerRedius:CGFloat = 2
   @IBInspectable   var shadowOffWidth:CGFloat = 0
    @IBInspectable  var shadowoffHeight:CGFloat = 2
   @IBInspectable  var shadowColor:UIColor = UIColor.clear
  @IBInspectable  var shadowOpecity:CGFloat = 1



    override func layoutSubviews()
    {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = Float(shadowOpecity)
     // backgroundColor = UIColor.gray
        layer.shadowOffset = CGSize(width: shadowOffWidth, height: shadowoffHeight)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRedius)
         // layer.shadowPath = path.cgPath
        
        layer.cornerRadius = 10
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
