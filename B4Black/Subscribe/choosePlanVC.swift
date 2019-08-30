//
//  choosePlanVC.swift
//  B4Black
//
//  Created by eWeb on 21/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController

class choosePlanVC: UIViewController {

    @IBOutlet weak var nextOut: UIButton!
    @IBOutlet weak var monthlylabel: UILabel!
    
    @IBOutlet weak var yearlylabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
nextOut.layer.cornerRadius = 20
      
    }
    @IBAction func back(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    @IBAction func nextAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "paymentMethodVC") as! paymentMethodVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func monthlybutton(_ sender: UIButton) {
        
        if sender.isSelected
        {
            sender.isSelected = false
        }
        else
        {
          sender.isSelected = true
        }
        
        
    }
    
    
    @IBAction func yearlyButton(_ sender: UIButton) {
        
        if sender.isSelected
        {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
        }
        
    }
    
}
