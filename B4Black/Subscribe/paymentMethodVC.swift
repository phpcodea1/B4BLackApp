//
//  paymentMethodVC.swift
//  B4Black
//
//  Created by eWeb on 20/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
class paymentMethodVC: UIViewController {

    @IBOutlet weak var nameofcardTextField: UITextField!
    
    @IBOutlet weak var cardNumberTextField: UITextField!
        
    @IBOutlet weak var expirydateTextField: UITextField!
    
    @IBOutlet weak var payOut: UIButton!
    
    
    @IBOutlet weak var enterCvvTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 payOut.layer.cornerRadius = 20
    
    }
    @IBAction func back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
//        let elDrawer = navigationController?.parent as? KYDrawerController
//        elDrawer?.setDrawerState(.opened, animated: true)
    }
    @IBAction func payButton(_ sender: Any) {
    }
}
