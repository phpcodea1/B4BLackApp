//
//  sideBarVC.swift
//  B4Black
//
//  Created by eWeb on 20/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
import SVProgressHUD

class sideBarVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isSelected = NSMutableArray()
    var imgSelected = NSMutableArray()
    var forLogin = "Logout"
    var namesArr = ["Home","My profile","Add business","Promotions","Upgrade","Chat lists","Notifications","About","Settings","Log out"]
    var imagesArr = ["011","077","055","044","066","088","099","11-11","1212","logout"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            forLogin = "Logout"
        }
        else
        {
            forLogin = "Login"
        }
        
        
        if let str = DEFAULT.value(forKey: "BUSINESS") as? String
        {
            isSelected = ["0","0","0","0","0","0","0","0","0","0","0","0","0"]
            namesArr = ["Home","My profile","Add business","Promotions","Upgrade","Chat lists","Notifications","About","Settings","Log out"]
            
            var imagesArr = ["011","077","055","044","066","088","099","11-11","1212","logout"]
            
            /*
             namesArr = ["Home","Promotions","Add Business", "Upgrade to premium","My Profile","Chat List","Notification","Contact Us", "About Us","Settings","Logout"]
             
             var imagesArr = ["011","044", "055","066","077", "088","099","1010","11-11", "1212","logout"]
             */
        }
        else
        {
            
            isSelected = ["0","0","0","0","0","0","0","0"]
            namesArr = ["Home","My Profile","Chat List","Notification", "Contact Us","About Us","Settings",forLogin]
            imagesArr = ["011", "077","088","099","1010","11-11","1212","logout"]
            
        }
    }
    /*
     func numberOfSections(in tableView: UITableView) -> Int
     {
     return 5
     }
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imagesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidebarTableViewCell") as! SidebarTableViewCell
        
        cell.icon.image =  UIImage(named: imagesArr[indexPath.row])
        
        cell.title.text = namesArr[indexPath.row]
        
        if isSelected[indexPath.row]as! String == "1"
        {
            
            cell.contentView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 202.0/255.0, blue: 197.0/255.0, alpha: 1)
        }
        else
        {
            
            cell.contentView.backgroundColor = UIColor.init(red: 120.0/255.0, green: 209.0/255.0, blue: 208.0/255.0, alpha: 1)
        }
        
        cell.selectionStyle = .none
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidebarTableViewCell") as! SidebarTableViewCell
        
        for i in 0..<isSelected.count{
            if (i == indexPath.row){
                isSelected.replaceObject(at: i, with: "1")
            }
            else{
                isSelected.replaceObject(at: i, with: "0")
            }
        }
        tableView.reloadData()
        if let str = DEFAULT.value(forKey: "BUSINESS") as? String
        {
            
            if (indexPath.row == 0)
            {
                
                let elDrawer = navigationController?.parent as? KYDrawerController
                let home = storyboard?.instantiateViewController(withIdentifier: "BusinessHomeViewController") as? BusinessHomeViewController
                let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                _nav.isNavigationBarHidden = true
                elDrawer?.mainViewController = _nav
                elDrawer?.setDrawerState(.closed, animated: true)
                
            }
            else if (indexPath.row == 1)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "BusinesProfileViewController") as? BusinesProfileViewController
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
            }
            else if (indexPath.row == 2)
            {
                
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "AddBusinessVC") as? AddBusinessVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
                
            }
            else if (indexPath.row == 3)
            {
                
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "NewPromotionViewController") as? NewPromotionViewController
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
            }
            else if (indexPath.row == 4)
            {
                if let str = DEFAULT.value(forKey: "BUSINESS") as? String
                {
                    
                    if  let id = DEFAULT.value(forKey: "USERID") as? String
                    {
                        let elDrawer = navigationController?.parent as? KYDrawerController
                        let home = storyboard?.instantiateViewController(withIdentifier: "choosePlanVC") as? choosePlanVC
                        let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                        _nav.isNavigationBarHidden = true
                        elDrawer?.mainViewController = _nav
                        elDrawer?.setDrawerState(.closed, animated: true)
                    }
                    else
                    {
                        ApiHandler.showLoginAlertMessage()
                    }
                    
                    
                }
                else
                    
                {
                   if  let id = DEFAULT.value(forKey: "USERID") as? String
                    {
                        let elDrawer = navigationController?.parent as? KYDrawerController
                        let home = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
                        let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                        _nav.isNavigationBarHidden = true
                        elDrawer?.mainViewController = _nav
                        elDrawer?.setDrawerState(.closed, animated: true)
                    }
                    else
                    {
                        ApiHandler.showLoginAlertMessage()
                    }
                  }
              }
             else if (indexPath.row == 5)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
              //      let home = storyboard?.instantiateViewController(withIdentifier: "DemoChatController") as? DemoChatController
                    let home = storyboard?.instantiateViewController(withIdentifier: "SectionViewController") as? SectionViewController
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
            }
            else if (indexPath.row == 6)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
            else
            {
                    ApiHandler.showLoginAlertMessage()
            }
                
            }
            else if (indexPath.row == 7)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "AboutUs") as? AboutUs
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
            }
/////////////
            else if (indexPath.row == 8)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "settingVC") as? settingVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
                
            }
                
            else if (indexPath.row == 9)
            {
                let alertController = UIAlertController(title: "Log out", message: "Are you sure you want to log out..?", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "Logout", style: .default)  {(action:UIAlertAction!) in
                    
                    
                    self.loguotUserAPI()
                    
                }
                let OKAction1 = UIAlertAction(title: "Cancel", style: .default)  {(action:UIAlertAction!) in
                }
                alertController.addAction(OKAction1)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
                
            }
            
            
        }
        else  // CUSTOMER SIDE
        {
            
            
            if (indexPath.row == 0)
            {
                
                let elDrawer = navigationController?.parent as? KYDrawerController
                let home = storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC") as? CustomerHomeVC
                let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                _nav.isNavigationBarHidden = true
                elDrawer?.mainViewController = _nav
                elDrawer?.setDrawerState(.closed, animated: true)
                
            }
            else if (indexPath.row == 1)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
            }
            else if (indexPath.row == 2)
            {
                
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
               //     let home = storyboard?.instantiateViewController(withIdentifier: "DemoChatController") as? DemoChatController
                    let home = storyboard?.instantiateViewController(withIdentifier: "ChatListVC") as? ChatListVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
            }
            else if (indexPath.row == 3)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                    
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
            }
                
            else if (indexPath.row == 4)
            {
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                    
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
            }
            else if (indexPath.row == 5)
            {
                let elDrawer = navigationController?.parent as? KYDrawerController
                let home = storyboard?.instantiateViewController(withIdentifier: "AboutUs") as? AboutUs
                let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                _nav.isNavigationBarHidden = true
                elDrawer?.mainViewController = _nav
                elDrawer?.setDrawerState(.closed, animated: true)
            }
            else if (indexPath.row == 6)
            {
                
                
                if  let id = DEFAULT.value(forKey: "USERID") as? String
                {
                    let elDrawer = navigationController?.parent as? KYDrawerController
                    let home = storyboard?.instantiateViewController(withIdentifier: "settingVC") as? settingVC
                    let _nav = UINavigationController(rootViewController: home ?? UIViewController())
                    _nav.isNavigationBarHidden = true
                    elDrawer?.mainViewController = _nav
                    elDrawer?.setDrawerState(.closed, animated: true)
                    
                }
                else
                {
                    ApiHandler.showLoginAlertMessage()
                }
                
                
            }
            else if (indexPath.row == 7)
            {
                
                if forLogin == "Login"
                {
                    let app = UIApplication.shared.delegate as? AppDelegate
                    app?.loadLoginView()
                }
                else
                {
                    let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout..?", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Logout", style: .default)  {(action:UIAlertAction!) in
                        self.loguotUserAPI()
                        
                    }
                    let OKAction1 = UIAlertAction(title: "Cancel", style: .default)  {(action:UIAlertAction!) in
                    }
                    alertController.addAction(OKAction1)
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
                }
                
                
                
            }
            
        }
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
                    
                    
                    //                    let alert = UIAlertController(title: "Notification", message: (json as! NSDictionary).value(forKey: "message") as! String, preferredStyle: .alert)
                    //                    let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                    //                    alert.addAction(submitAction)
                    //                    self.present(alert, animated: true, completion: nil)
                    
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
