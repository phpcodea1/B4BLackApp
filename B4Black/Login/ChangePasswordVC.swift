//
//  ChangePasswordVC.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var changePWDOut: UIButton!
    
    @IBOutlet weak var enterOTPTextfield: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changePWDOut.layer.cornerRadius = 20
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func netAction(_ sender: UIButton) {
        
        if self.enterOTPTextfield.text ==  "" || self.newPassword.text == "" || self.confirmPassword.text == ""
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
