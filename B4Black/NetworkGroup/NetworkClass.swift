//
//  NetworkClass.swift
//  KLshee
//
//  Created by Apple on 14/06/18.
//  Copyright © 2018 Apple. All rights reserved.

import Foundation
import UIKit
import Alamofire
import NVActivityIndicatorView
import SystemConfiguration
import SVProgressHUD
import Toast_Swift
import MBProgressHUD
class NetworkClass
{
    let myAppDel = UIApplication.shared.delegate as! AppDelegate
    let imageBaseUrl =  ""
    // let baseUrl = "http://192.168.1.159/users.json"
    
    //================LIVE DETAILS============================
  //  let baseUrl = "http://192.168.1.159/users.json"
   // let baseUrl = "http://35.162.98.0:3000/"
   // let baseUrl1 = "http://35.162.98.0:3000/api/add_victorypost"
   // let victoryRoomApiUrl = "http://35.162.98.0:3000/api/get_victorypost"
    //let  Tokenid = "Tokenid"
    //==========================================================
    
    //================DEVELOPMENT DETAILS============================
    let baseUrl = "http://34.211.140.7:3000/"
    let baseUrl1 = "http://34.211.140.7:3000/api/add_victorypost"
    let victoryRoomApiUrl = "http://34.211.140.7:3000/api/get_victorypost"
    let  Tokenid = "Tokenid"
    //==========================================================
    
    
    static let NetworkClassObj = NetworkClass()
    
    func isNewworkAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false
        {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    func LOADERSHOW()
    {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.black)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.white)        //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.clear)    //Background Color
        SVProgressHUD.show()
    }
    
    //1)--MARK:-- user_Register
    func userRegister(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string:  baseUrl + "users.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
    
    }
    //2)--MARK:-- login API
    func loginApi(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl + "users/loginu.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
    }
    
    //3)--MARK:-- Forget Password
    //forgetPassword
    func forgetPassword(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string:  baseUrl + "users/forget.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    //4. MARK : Reset Password
    //    resetPassword
    func resetPassword(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl + "users/reset.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    
    // 5. MARK : Change Password
    //    changePassword
    func changePassword(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl  + "users/change_password.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    
    // 6. MARK : logout Api
    func profile(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl +  "users/profile.json")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    // 7. MARK : get Profile Api
    func getProfile(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "User_Profile/profile", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    func Get_victorypost(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl + "api/get_victorypost")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    
    
    
    //1)--MARK:-- user Login ---------
    
    // 8. MARK : homePageData
    //    func homePageData(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    //    {
    //        Alamofire.request(baseUrl + "Restaurant/dish_all", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
    //            switch(response.result)
    //            {
    //            case .success(_):
    //                if response.result.value != nil
    //                {
    //                    print(response.result.value!)
    //                    let JSON = response.result.value!
    //                    completion(JSON as AnyObject)
    //                }
    //                break
    //
    //            case .failure(_):
    //                print(response.result.error!.localizedDescription)
    //                self.myAppDel.HideLoader()
    //                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
    //                break
    //            }
    //        }
    //    }
    // 8. MARK : restaurant
    func restaurant(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "Restaurant/get_record_byid_restaurant", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    func homePageData( completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "Restaurant/dish_all", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
             //   self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    // 6. MARK : logout Api
    func Universal_Posts(dict: NSDictionary, completion:@escaping (AnyObject) -> Void,err:@escaping (String) -> Void) {
        
        var request = URLRequest(url:URL.init(string: baseUrl + "api/universal_posts")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: dict)
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    
                    err("error")
                    
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print(responseString)
                    }
                case .success(let responseObject):
                    print(responseObject)
                    let JSON = response.result.value
                    completion(JSON as AnyObject)
                    
                }
        }
        
        
    }
    //-------------// post data catagories api-------------
    
    func postcatagoriesdata(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl1, method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    //------------------------------------- victoryRoom vc-------------------------
    //-------------// post data catagories api-------------
    
    func victoryRoomApi(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(victoryRoomApiUrl, method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    func favouriteApi(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/add_favourite_post", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    
    func cotactUsApi(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/contactus", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    
    //=====================updateProfil=================================================================================
    
    func updateProfile(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/updateprofile", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    
 //   =================================================== edit profile======================================================
    func EditProfileApi(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/editprofile", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
   //=====================================================universalpost============================================================
    
     func universalpost(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/universal_posts", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
               // self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    
    
    //=======================================comment===================================================================================
    
 
    
    func commentdata(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/comment_universal_post", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    // get all comment
    
    func commentdataGet(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/get_comment_universal_post", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
 // comment universal post
    func commentdataUniversalPost(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/comment_universal_post", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
                //self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    // get comment universal post
    
    func commentdataGetUniversalPost(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/get_comment_universal_post", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
  // volt post comment===========================
    
    func commentdatavoultPost(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "api/comment_vault_posts", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
                case .failure(_):
                print(response.result.error!.localizedDescription)
             //   self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
    
    
    // add comment count response
    
    func commentdataCount(dict: NSDictionary, completion:@escaping (AnyObject) -> Void)
    {
        Alamofire.request(baseUrl + "/api/get_victorypost", method: .post, parameters: (dict as! Parameters), encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch(response.result)
            {
            case .success(_):
                if response.result.value != nil
                {
                    print(response.result.value!)
                    let JSON = response.result.value!
                    completion(JSON as AnyObject)
                }
                break
            case .failure(_):
                print(response.result.error!.localizedDescription)
              //  self.myAppDel.HideLoader()
                commonClass.commonObj.showAlert(messageToShow: "The server is taking too long to respond OR something is wrong with your internet connection. Please try again later.", title: "Alert")
                break
            }
        }
    }
}
