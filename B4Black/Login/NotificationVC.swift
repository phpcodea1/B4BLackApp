//
//  NotificationVC.swift
//  B4Black
//
//  Created by eWeb on 12/06/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController

class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // https://www.youtube.com/watch?v=1ybusY3R28Y
        
    }
 
    @IBAction func backAct(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
}
