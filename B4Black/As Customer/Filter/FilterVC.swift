//
//  FilterVC.swift
//  B4Black
//
//  Created by eWeb on 22/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
import Toast_Swift
class FilterVC: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var chooseCatagoryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    @IBAction func chooseCategory(_ sender: UIButton) {
        self.view.makeToast("category....")
    }
    
}
