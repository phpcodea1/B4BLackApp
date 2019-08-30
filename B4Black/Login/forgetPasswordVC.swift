//
//  forgetPasswordVC.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class forgetPasswordVC: UIViewController {

    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var nextOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
 nextOut.layer.cornerRadius = 20
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func netAction(_ sender: UIButton) {
        
        if self.enterEmailTextField.text ==  ""
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
