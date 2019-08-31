//
//  LoginVC.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
import Alamofire
import FacebookLogin
import TwitterKit
import InstagramLogin
import FBSDKCoreKit
import SVProgressHUD
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController
{
    @IBOutlet var passImg: UIImageView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var loginOut: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    
    let myAppDel = UIApplication.shared.delegate as! AppDelegate
    var loginType = ""
    var fusername1 = ""
    var fuseremail1 = ""
    var tusername1 = ""
    var tuseremail1 = ""
    
    // like:- FaceBook, Instagram Or Twiter
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTxt.text = "karanveer@gmail.com"
        passwordTxt.text = "123456"
        loginOut.layer.cornerRadius = 20
        
        
    }
    @IBAction func showHidePassword(_ sender: UIButton)
    {
        
        if sender.isSelected
        {
            sender.setImage(UIImage(named: "hidePassword"), for: .normal)
            passwordTxt.isSecureTextEntry = true
            sender.isSelected = false
            
        }
        else
        {
            sender.setImage(UIImage(named: "showPassword"), for: .normal)
            passwordTxt.isSecureTextEntry = false
            sender.isSelected = true
        }
        
    }
    
    @IBAction func forgetAction(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "forgetPasswordVC") as! forgetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginAction(_ sender: UIButton)
    {
        if ((emailTxt.text?.isEmpty)! || (passwordTxt.text?.isEmpty)!)
        {

                let alert = UIAlertController.init(title: "Alert", message: "Please enter email and password", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
        }
    
        else
        {
            self.LoginApi()
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupVC
        
        vc.from = "Signup"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func faceBookButton(_ sender: Any)
    {
        
        /*
         
         facebookId =  testdemo198@gmail.com
         facebookPASS = adminuser@123
         
         */
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    let dict: NSDictionary = result as! NSDictionary
                                    if let token = FBSDKAccessToken.current().tokenString {
                                        print("tocken: \(token)")
                                        
                                        let userDefult = UserDefaults.standard
                                        userDefult.setValue(token, forKey: "access_tocken")
                                        userDefult.synchronize()
                                    }
                                    if let user : NSString = dict.object(forKey:"name") as! NSString? {
                                        let userDefult = UserDefaults.standard
                                        userDefult.setValue(user, forKey: "name")
                                        userDefult.synchronize()
                                        print("user: \(user)")
                                        self.fusername1 = user as String
                                    }
                                    if let id : NSString = dict.object(forKey:"id") as? NSString {
                                        print("id: \(id)")
                                        self.loginType = "facebook"
                                        self.ApiSocialLoginSuccess(getID: "\(id)")
                                    }
                                    if let email : NSString = (result! as AnyObject).value(forKey: "email") as? NSString {
                                        print("email: \(email)")
                                        self.fuseremail1 = email as String
                                        
                                    }
                                    
                                let signup = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupVC
                                    signup.from = "facebook"
                                    signup.fusername = self.fusername1
                                    signup.fuseremail = self.fuseremail1
                                    
                                self.navigationController?.pushViewController(signup, animated: true)
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    ////////////
   /*
    func GetFBUserData()
    {
        if ((FBSDKAccessToken.current())) != nil
        {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,name,first_name,last_name, picture.type(large),email"]).start(completionHandler:{(connection,result,error ) -> Void in
                
                if (error == nil)
                {
                    let faceDict = result as! [String:Any]
                    
                   
                    
//                    self.emailTxt = faceDict["email"] as? String
//
//                    print(self.emailTxt)
//
//                    let faceBookID = faceDict["id"] as? String ?? ""
//                    print(faceBookID)
//                    self.emailTxt = faceDict["name"] as? String

                    print(self.emailTxt)
                    
                }
                
            })
            
        }
        
    }
 */
    // MARK :- Facebook API here.
    
//    func facebookAPI()
//    {
//        let params:[String:Any] = ["email" : emailTxt,
//                                   "username": emailTxt,
//                                   "device_id":"1",
//                                   "device_type":"2",
//                                   "type":"F",
//                                   "profile_image":"ganesh"]
//
//        print(params)
//        WebServices.shared.apiDataPostMethod(url:facebookAPI, parameters: params) { (response, error) in
//            if error == nil
//            {
//                self.facebookModelData = Mapper<FacebookModel>().map(JSONObject: response)
//
//                if self.facebookModelData?.status == "success"
//                {
//                    let tokenObj = self.facebookModelData?.accessToken ?? ""
//                    defaultValues.setValue(tokenObj, forKey: AppLoginToken)
//                    defaultValues.synchronize()
//
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
//                    let navVC = UINavigationController.init(rootViewController: vc)
//                    navVC.setNavigationBarHidden(true, animated: true)
//                    if let window = UIApplication.shared.windows.first
//                    {
//                        window.rootViewController = navVC
//                        window.makeKeyAndVisible()
//                    }
//
//                }
//                else if self.facebookModelData?.status == "fails"
//                {
//                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.facebookModelData?.message ?? "")
//
//                }
//                else{
//                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
//
//                }
//            }
//        }
//
//    }
  
    
    ////////
    /*
    test75741@gmail.com
    plokijuh12345
    */
    @IBAction func twitterButton(_ sender: Any)
    {
        self.loginType = "twitter"
        TWTRTwitter.sharedInstance().logIn
            {
            (session, error) -> Void in
            if (session != nil) {
                print(session!)
                print("signed in as \(session!.userName)");
                print("signed in as \(session!.userID)");
                print("signed in as \(session!.userName)");
                
                let uname = session?.userName
                let uemail = session?.userID
                
                self.tuseremail1 = uname!
                self.tusername1 = uemail!

                
                let twitterClient = TWTRAPIClient(userID: session?.userID)
                twitterClient.loadUser(withID: session?.userID ?? "") {(user, error) in
                    
                    print(user?.profileImageURL ?? "")
                    print(user?.profileImageLargeURL ?? "")
                    print(user?.screenName ?? "")
                    print(user?.name ?? "")
               
                    
            let signup = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupVC
                    
                    signup.from = "twitter"
                    signup.tusername = self.tusername1
                    signup.tuseremail = self.tuseremail1
                    
                    self.navigationController?.pushViewController(signup, animated: true)
                    
                    let userDefult = UserDefaults.standard
                    userDefult.setValue(user!.name, forKey: "name")
                    userDefult.synchronize()
                    
                }
                self.ApiSocialLoginSuccess(getID: "\(session!.userID)")
            }
            else
            {
                print("error: \(error!.localizedDescription)");
//
//let alert = UIAlertController(title: "Alert", message: "\(error!.localizedDescription)", preferredStyle: .alert)
//
//                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
//                alert.addAction(submitAction)
//                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func ApiSocialLoginSuccess(getID: String)
    {
        UserDefaults.standard.setValue(getID, forKey: "facebooke_twitter_id")
        
        let dict1:[String:Any] = ["login_type":self.loginType,
                                  "social_id":getID,
                                  "devicetoken":"",
                                  "app_type":"ios"]
        print(dict1)

        // API here......

    }
    
    @IBAction func instaGramButton(_ sender: Any)
    {
        let go = storyboard?.instantiateViewController(withIdentifier: "InstagramViewController") as! InstagramViewController
        self.navigationController?.pushViewController(go, animated: true)
    }

    ////////////////////////             LOGIN    API
    
    func LoginApi()
    {
       SVProgressHUD.show()

        let params = ["user_email":emailTxt.text!,
                      "user_password":passwordTxt.text!,
                      "user_device_type":"2",
                      "user_device_id":"11231313sfsdfsdf"] as [String : AnyObject]
        
        print(params)
        
    ApiHandler.callApiWithParameters(url: loginURL, withParameters: params ,success:
    {
      json in
      print(json)
        SVProgressHUD.dismiss()
        if   (json as NSDictionary).value(forKey: "status") as! String == "failure"
        {
            let alert = UIAlertController(title: "Alert", message: (json as NSDictionary).value(forKey: "message") as? String, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            SVProgressHUD.dismiss()
            /*
            if   let company_name = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "company_name") as? String
            {
                DEFAULT.set(company_name, forKey: "company_name")
            }
             */
            if   let user_id = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_id") as? String
          {
            DEFAULT.set(user_id, forKey: "USERID")
          }
            
            if let business_id = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "business_id") as? String
          {
            DEFAULT.set(business_id, forKey: "BusinessId")
          }
          if let user_fname = ((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_fname") as? String
            {
                DEFAULT.set(user_fname, forKey: "USERNAME")
            }
            if let user_type1 = (((json as NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_type") as! String) as? String
            {
                if user_type1 == "2"
                {
                    DEFAULT.removeObject(forKey: "BUSINESS")
                    
                    DEFAULT.set("CUSTOMER", forKey: "CUSTOMER")
                    DEFAULT.synchronize()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CUSTOMER") as! KYDrawerController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    DEFAULT.removeObject(forKey: "CUSTOMER")
                    DEFAULT.set("BUSINESS", forKey: "BUSINESS")
                    DEFAULT.synchronize()
                    APPDEL.loadBusinessView()
                }
               
            }
            else
            {
                DEFAULT.set("CUSTOMER", forKey: "CUSTOMER")
                DEFAULT.removeObject(forKey: "BUSINESS")
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
        }, method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
    
    
}
