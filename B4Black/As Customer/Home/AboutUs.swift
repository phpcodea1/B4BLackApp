//
//  AboutUs.swift
//  B4Black
//
//  Created by administrator on 30/07/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController

class AboutUs: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func GoBack(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
}
