//
//  signupVC.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
import SVProgressHUD

class signupVC: UIViewController, UIActionSheetDelegate
{

    
    @IBOutlet weak var signupOut: UIButton!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var cifcView: UIView!
    @IBOutlet weak var registerAsOut: UIButton!
    @IBOutlet weak var beeeView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var contactPersonTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var CoRegisterIdTextField: UITextField!
    @IBOutlet weak var BEEElevelTextField: UITextField!
    @IBOutlet weak var racetextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    
    // For Busines Login
    var fromSignUP = "no"
    var coRegisterId = ""
    var beeLevel = ""
    var race = ""
    var gender = ""
    var raceValue = ""
    var from = ""
    //  for facebook
    
    var fuseremail = ""
    var fusername = ""
    
    //  for twitter
    
    var tuseremail = ""
    var tusername = ""
    
    //  for insta
    
    var iuseremail = ""
    var iusername = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        signupOut.layer.cornerRadius = 20
        cifcView.isHidden = true
        beeeView.isHidden = true
        self.view1.isHidden = true
        self.view2.isHidden = true
        
        if from == "Signup"
        {
            self.emailTextField.text! = ""
            self.contactPersonTextField.text! = ""
        }
        else if from == "facebook"
        {
            self.emailTextField.text! = fuseremail
            self.contactPersonTextField.text! = fusername
            
        }
        else if from == "instagram"
        {
            self.emailTextField.text! = iuseremail
            self.contactPersonTextField.text = iusername

        }
        else if from == "twitter"
        {
            self.emailTextField.text! = tuseremail
            self.contactPersonTextField.text! = tusername
            
        }
        else
        {
            self.emailTextField.text! = ""
            self.contactPersonTextField.text! = ""
            
        }
        
    }
    
    @IBAction func showHidePassword(_ sender: UIButton)
    {
        
        if sender.isSelected
        {
            sender.setImage(UIImage(named: "hidePassword"), for: .normal)
            passwordTextField.isSecureTextEntry = true
            sender.isSelected = false
            
        }
        else
        {
            sender.setImage(UIImage(named: "showPassword"), for: .normal)
            passwordTextField.isSecureTextEntry = false
            sender.isSelected = true
        }
        
    }
    @IBAction func showHidePassword2(_ sender: UIButton)
    {
        
        if sender.isSelected
        {
            sender.setImage(UIImage(named: "hidePassword"), for: .normal)
            confirmpasswordTextField.isSecureTextEntry = true
            sender.isSelected = false
            
        }
        else
        {
            sender.setImage(UIImage(named: "showPassword"), for: .normal)
            confirmpasswordTextField.isSecureTextEntry = false
            sender.isSelected = true
        }
        
    }
    @IBAction func signUpAction(_ sender: UIButton)
    {
         Validationdata()
    }
    @IBAction func registerAsAction(_ sender: UIButton)
    {
        let optionMenu = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Customer", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            
            self.registerAsOut.setTitle("Customer", for: .normal)
            self.cifcView.isHidden = true
            self.beeeView.isHidden = true
            self.view1.isHidden = true
            self.view2.isHidden = true
            
            
        })
        let saveAction = UIAlertAction(title: "Business", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.registerAsOut.setTitle("Business", for: .normal)
            self.cifcView.isHidden = false
            self.beeeView.isHidden = false
            self.view1.isHidden = false
            self.view2.isHidden = false
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func goToLogin(_ sender: UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func Validationdata()
    {
        if ((emailTextField.text?.isEmpty)! && (contactNumberTextField.text?.isEmpty)!)
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        else  if ((passwordTextField.text?.isEmpty)! && (CoRegisterIdTextField.text?.isEmpty)!)
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        else  if (passwordTextField.text?.isEmpty)!
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            if registerAsOut.titleLabel?.text == "Customer"
            {
                CoRegisterIdTextField.text = ""
                BEEElevelTextField.text = ""
                racetextField.text = "'"
                genderTextField.text = ""
                self.sigupApi()
            }
            else
            {
                if ((CoRegisterIdTextField.text?.isEmpty)!) && ((BEEElevelTextField.text?.isEmpty)!)
                {
                    let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
                    let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else if  ((racetextField.text?.isEmpty)!) && ((genderTextField.text?.isEmpty)!)
                {
                    let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
                    let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    self.sigupApi()
                }
              
            }
        }
    }
    
    @IBAction func selectBeeLevel(_ sender: UIButton)
    {
        
        let optionMenuController = UIAlertController(title: nil, message: "Choose your BEE Level for your Business Profile", preferredStyle: .actionSheet)
        
        let Affidavit = UIAlertAction(title: "Affidavit", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.BEEElevelTextField.text = "Affidavit"
            print("File has been Add")
        })
        let level1 = UIAlertAction(title: "Level 1", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.BEEElevelTextField.text = "Level 1"
            print("File has been Add")
        })
        let level2 = UIAlertAction(title: "Level 2", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.BEEElevelTextField.text = "Level 2"
            print("File has been Add")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(Affidavit)
        optionMenuController.addAction(level1)
        optionMenuController.addAction(level2)
        optionMenuController.addAction(cancel)
        
        self.present(optionMenuController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func selectGender(_ sender: UIButton)
    {
        let optionMenuController = UIAlertController(title: nil, message: "Choose Option from the Sheet", preferredStyle: .actionSheet)
        
        
        let male = UIAlertAction(title: "Male", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.genderTextField.text = "Male"
            print("File has been Add")
        })
        let female = UIAlertAction(title: "Female", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.genderTextField.text = "Female"
            print("File has been Edit")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(male)
        optionMenuController.addAction(female)
        optionMenuController.addAction(cancel)
        
        self.present(optionMenuController, animated: true, completion: nil)
        
    }
    @IBAction func RaceDropDownAct(_ sender: UIButton)
    {
        
        let optionMenuController = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let African = UIAlertAction(title: "African", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.racetextField.text = "African"
            UserDefaults.standard.set("African", forKey: "race")
            print("File has been Add")
        })
        let Black = UIAlertAction(title: "Black", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
             self.racetextField.text = "Black"
            UserDefaults.standard.set("Black", forKey: "race")
            print("File has been Edit")
        })
        
        let White = UIAlertAction(title: "White", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
             self.racetextField.text = "White"
            UserDefaults.standard.set("White", forKey: "race")
            print("File has been Delete")
        })
        let Coloured = UIAlertAction(title: "Coloured", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
             self.racetextField.text = "Coloured"
              UserDefaults.standard.set("Coloured", forKey: "race")
            print("File has been Delete")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(African)
        optionMenuController.addAction(Black)
        optionMenuController.addAction(White)
        optionMenuController.addAction(Coloured)
        optionMenuController.addAction(cancel)
        
       
        self.present(optionMenuController, animated: true, completion: nil)
       
    }
    
    ////////////////////////             SIGNUP API
    
    func sigupApi()
    {
        
        SVProgressHUD.show()
        var userType = "2" // User
        if ((registerAsOut.titleLabel?.text!) == "Business")
            {
                userType = "3"
            }
            else
            {
            userType = "2"
            }
        
        let param = ["user_type" : userType,
                     "company_name" : companyNameTextField.text!,
                     "user_fname" : companyNameTextField.text!,
                     "user_mobile" : contactNumberTextField.text!,
                     "user_email" : emailTextField.text!,
                     "user_password" : passwordTextField.text!,
                     "confirm_password" : confirmpasswordTextField.text!,
                     "co_registeration_id_password" : CoRegisterIdTextField.text!,
                     "bee_number" : BEEElevelTextField.text!,
                     "gender" : genderTextField.text!] as [String : AnyObject]
        
        print(param)
        
    ApiHandler.callApiWithParameters(url: SignUpURL, withParameters: param,success:
        {
     json in
     print(json)
                                        
        
    if   (json as NSDictionary).value(forKey: "status") as! String == "failure"
    {
        SVProgressHUD.dismiss()
    let alert = UIAlertController(title: "Alert", message: (json as NSDictionary).value(forKey: "message") as! String, preferredStyle: .alert)
    let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
    alert.addAction(submitAction)
    self.present(alert, animated: true, completion: nil)
    }
    else
    {

    SVProgressHUD.dismiss()
        
         if let user_id = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_id") as? String
        {
        DEFAULT.set(user_id, forKey: "USERID")
        }
 
        if let user_type = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_type") as? String
        {
        if user_type == "2"
        {
            SVProgressHUD.dismiss()
            DEFAULT.set("CUSTOMER", forKey: "CUSTOMER")
            DEFAULT.synchronize()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CUSTOMER") as! KYDrawerController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            SVProgressHUD.dismiss()
            DEFAULT.set("BUSINESS", forKey: "BUSINESS")
            DEFAULT.synchronize()
            APPDEL.loadBusinessView()
        }
        
    }
    else
    {
        SVProgressHUD.dismiss()
        DEFAULT.set("CUSTOMER", forKey: "CUSTOMER")
        DEFAULT.synchronize()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CUSTOMER") as! KYDrawerController
        self.navigationController?.pushViewController(vc, animated: true)
    }
        }
    },failure:
        {
    
            string in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            print(string)
        },method: .POST, img: nil, imageParamater: "", headers: [ : ])
    
    }

}




