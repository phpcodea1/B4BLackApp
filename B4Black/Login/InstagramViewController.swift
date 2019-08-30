//
//  InstagramViewController.swift
//  B4Black
//
//  Created by eWeb on 31/05/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import InstagramLogin
import Messages
import CoreData
import FacebookLogin
import FacebookCore
import InstagramLogin
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
import WebKit

class InstagramViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var token = ""
    var jsondata1 :AnyObject!
    var data1 :AnyObject!
    var getEmail = ""
    var getID = ""
    var appType = "ios"
    var loginType = "instagram"
    
    
    
    
    // by me
    
        let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
        let INSTAGRAM_CLIENT_ID = "33ea4e2d2e73461f8e06a14eb10e3a16"
        let INSTAGRAM_CLIENTSERCRET = "a80c3ca3c9d3438d935725138fcc9605"
        let INSTAGRAM_REDIRECT_URI = "http://a1professionals.com/"
        let INSTAGRAM_ACCESS_TOKEN = ""    //"access_token"
        let INSTAGRAM_SCOPE = "follower_list+public_content"

    /*
     InstaID =  7696007586
     InstaPASS = eweb12345
     */
    
    
    // demo work
//    let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
//    let INSTAGRAM_CLIENT_ID = "2d6de999a81a4d849d1f3b4a35046919"
//    let INSTAGRAM_CLIENTSERCRET = "7617e8d4cabd4f8c9a362fbb58c5226f"
//    let INSTAGRAM_REDIRECT_URI = "http://www.artra.at"
//    let INSTAGRAM_ACCESS_TOKEN = ""    //"access_token"
//    let INSTAGRAM_SCOPE = "follower_list+public_content"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Insta Step 1:
        title = "Instagram"
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_AUTHURL,INSTAGRAM_CLIENT_ID,INSTAGRAM_REDIRECT_URI, INSTAGRAM_SCOPE])
            let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
            webView.loadRequest(urlRequest)
            self.webView.delegate = self
            print("json data print ==",self.jsondata1)
        
    }
    // Insta Step 2:
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        return checkRequestForCallbackURL(request: request)
    }
    // Insta Step 3:
    func checkRequestForCallbackURL(request: URLRequest) -> Bool
    {
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(INSTAGRAM_REDIRECT_URI)
        {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
             handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    
    
    // Insta Step 4:
    func handleAuth(authToken: String)
    {
        print("Instagram authentication token ==", authToken)
        
        getUserDetail(token: authToken)
        
        
        //        var goNext = storyboard?.instantiateViewController(withIdentifier: "GoToRegisterViewController") as? GoToRegisterViewController
        //
        //        self.navigationController?.pushViewController(goNext!, animated: false)
        
        
        
        //self.navigationController?.popViewController(animated: true)
    }
    
    // Insta Step 5:
    func getUserDetail(token: String)
    {
//      token = InstagramEngine.shared().accessToken!
        guard let url = URL(string: "https://api.instagram.com/v1/users/self/?access_token="+token) else { return }
        print("url=",url)
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                    self.jsondata1 = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                    print(self.jsondata1)
                    self.data1 = self.jsondata1.value(forKey: "data") as AnyObject
                    print(self.data1)
                    let userName = self.data1.value(forKey: "username") as! String
                    print("userName==",userName)
                    let fullname = self.data1.value(forKey: "full_name") as! String
                    print("fullname=",fullname)
                    let id = self.data1.value(forKey: "id") as! String
                    print("id of account=",id)
                    let instaDp = self.data1.value(forKey: "profile_picture") as! String
                    print("instaDp=",instaDp)
                    
                    //                    checkInstaLogin = true
                    UserDefaults.standard.setValue(userName, forKey: "instagram_name")
                    UserDefaults.standard.setValue(fullname, forKey: "instagram_email")
                    UserDefaults.standard.setValue(fullname, forKey: "instagram_password")
                    
                    UserDefaults.standard.setValue(id, forKey: "instagram_id")
                    
                    let alert = UIAlertController(title: "(Instagram) Succefully Login with", message: "(\(userName)),  \(fullname)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
                        let view = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as? signupVC
                        
                        view?.from = "instagram"
                        view?.iusername = self.data1.value(forKey: "username") as! String
                        view?.iuseremail = self.data1.value(forKey: "id") as! String
                        
                        self.navigationController?.pushViewController(view!, animated: true)
                        
                       // self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    //                    let token = Messaging.messaging().fcmToken
                    //                    print("FCM token: \(token ?? "")")
                    //                    if (token != nil)
                    //                    {
                    //                        UserDefaults.standard.setValue(token, forKey: "deviceToken")
                    //                        print("\(UserDefaults.standard.value(forKey: "deviceToken")!)")
                    //                    }
                    //                    else
                    //                    {
                    //                        let token = Messaging.messaging().fcmToken
                    //                        print("FCM token: \(token ?? "")")
                    //                    }
                    //
                    //                    let dict1:[String:Any] = ["login_type":self.loginType,
                    //                                              "social_id":id,
                    //                                              "devicetoken":token!,
                    //                                              "type":type,
                    //                                              "app_type":self.appType]
                    //                    let web1 = WebService.init(tag: SOCIAL_LOGIN_API_TAG)
                    //                    web1.delegate=self
                    //                    web1.postWebServiceSocialLogin(path: SOCIAL_LOGIN_API, parameters: dict1, userID:id)
                    
                    
                    
                    
                    //                                        if(token != nil){
                    //                                            let urlRequest = URLRequest.init(url: URL.init(string: "https://instagram.com/accounts/logout")!)
                    //                                            self.webView.loadRequest(urlRequest)
                    //                                        }else{
                    //                                        }
                    //
                    
                }
                catch
                {
                    print(error)
                }
                
            }
            }.resume()
    }
    
    
    @IBAction func cancelAct(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
} // Class close

