//
//  ResetPasswordVC.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var resetOut: UIButton!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetOut.layer.cornerRadius = 20
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func netAction(_ sender: UIButton) {
        
        if self.newPasswordTextField.text ==  "" || self.confirmPassword.text == "" || self.oldPassword.text == ""
        {
            
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
}
