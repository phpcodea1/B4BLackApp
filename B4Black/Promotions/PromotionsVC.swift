//
//  PromotionsVC.swift
//  B4Black
//
//  Created by eWeb on 21/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
class PromotionsVC: UIViewController {

    @IBOutlet weak var doneOut: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var addimageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
doneOut.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    @IBAction func back(_ sender: UIButton)
    {
        //self.navigationController?.popViewController(animated: true)
                let elDrawer = navigationController?.parent as? KYDrawerController
                elDrawer?.setDrawerState(.opened, animated: true)
    }
 
    @IBAction func DoneButton(_ sender: Any) {
        
        
    }
    
}
