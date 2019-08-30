//
//  settingVC.swift
//  B4Black
//
//  Created by eWeb on 21/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import KYDrawerController

class settingVC: UIViewController {

    @IBOutlet weak var logOut: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // logOut.layer.cornerRadius = 20
   
    }
    @IBAction func back(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    @IBAction func logoutbutton(_ sender: Any)
    {
        
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout..?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Logout", style: .default)  {(action:UIAlertAction!) in
            
            
             self.loguotUserAPI()
            
//            let delegate = UIApplication.shared.delegate as? AppDelegate
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            let nav = UINavigationController(rootViewController: vc)
//            UserDefaults.standard.set(nil, forKey: "AcessToken")
//            UserDefaults.standard.synchronize()
//            delegate?.window?.rootViewController = nav
           
            
        }
        let OKAction1 = UIAlertAction(title: "Cancel", style: .default)  {(action:UIAlertAction!) in
        }
        alertController.addAction(OKAction1)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
        
       ////////// self.loguotUserAPI()
        
//        if let str = DEFAULT.value(forKey: "BUSINESS") as? String
//        {
//            DEFAULT.removeObject(forKey: "BUSINESS")
//            DEFAULT.synchronize()
//        }
//        else
//        {
//            if let str = DEFAULT.value(forKey: "CUSTOMER") as? String
//            {
//                DEFAULT.removeObject(forKey: "CUSTOMER")
//                DEFAULT.synchronize()
//            }
//        }
//
//        APPDEL.loadLoginView()
//
        
    }
    
    func loguotUserAPI()
    {
        SVProgressHUD.show()
        var USERID = "66"
        
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let params = ["user_id" : USERID]   as [String : AnyObject]
        
        print(params)
        
        ApiHandler.callApiWithParameters(url: logoutUserURL, withParameters: params, success:
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
                
                DEFAULT.removeObject(forKey: "USERID")
                DEFAULT.removeObject(forKey: "CUSTOMER")
                DEFAULT.removeObject(forKey: "BUSINESS")
          
                DEFAULT.synchronize()
  
                APPDEL.loadLoginView()
                print("Success")

            }
            
        },failure:
        {
          string in
            print(string)
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            print(string)
            
            
        }, method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
}
