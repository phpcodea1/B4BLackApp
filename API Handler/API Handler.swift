//
//  API Handler.swift
//  B4Black
//
//  Created by eWeb on 5/21/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift

enum ApiMethod
{
    case GET
    case POST
    case PUT
}

class ApiHandler : NSObject
{
    
    static func callApiWithParameters(url: String, withParameters parameters:[String:AnyObject], success:@escaping ([String:Any])->(), failure: @escaping (String)->(), method: ApiMethod, img: UIImage? , imageParamater: String,headers: [String:String])
   {
    
    switch method
    {
    case .GET:
        print("Api get method")
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("Resposnse in api =\(response)")
            
            let statusCode = response.response?.statusCode
            //                let json = JSON(data: response.data!)
            
            do {
                
                let json = try JSON(data: response.data!)
                
                
                switch response.result
                {
                    
                case .success(_):
                    if(statusCode==200)
                    {
                        if let data = response.result.value
                        {
                            print (data)
                            DispatchQueue.main.async
                                {
                                    success(response.result.value as! [String:Any])
                            }
                            
                        }
                    }
                    else{
                        if let data = response.result.value{
                            let dict=data as! NSDictionary
                            
                            
                            if statusCode == 593{
                                DispatchQueue.main.async {
                                    failure("Forgot Password")
                                }
                                
                            }else{
                                DispatchQueue.main.async {
                                    failure(dict.value(forKey: "error_description") as! String)
                                }
                                
                            }
                            
                        }
                    }
                    break
                case .failure(_):
                    if let error = response.result.error{
                        let str = error.localizedDescription as String
                        if str.isEqual("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format.")
                        {
                            return
                        }
                        DispatchQueue.main.async {
                            failure(str)
                        }
                        
                    }
                    
                }
            }
            catch _ {
                failure("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format.")
                // Error handling
            }
            
        }
        
    case .POST:
        print("Api get method")
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("Resposnse in api =\(response)")
            
            let statusCode = response.response?.statusCode
            //                let json = JSON(data: response.data!)
            
            do {
                
                let json = try JSON(data: response.data!)
                
                
                switch response.result
                {
                    
                case .success(_):
                if(statusCode==200)
                {
                if let data = response.result.value
                {
                print (data)
                DispatchQueue.main.async
                {
               success(response.result.value as! [String:Any])
                }
                }
                }
                 else
                {
                 if let data = response.result.value{
                 let dict=data as! NSDictionary
                 if statusCode == 593{
                 DispatchQueue.main.async
                {
                failure("Forgot Password")
                }
                }
                else
                {
                 DispatchQueue.main.async
                {
                 failure(dict.value(forKey: "error_description") as! String)
                }
                }
                }
                }
                break
                case .failure(_):
                if let error = response.result.error{
                let str = error.localizedDescription as String
                if str.isEqual("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format."){
                return
                }
                DispatchQueue.main.async
                {
                failure(str)
                }
                }
                }
            }
            catch _
            {
            print(response)
            failure("JSON could not be serialized because of error:\nThe data couldn’t be read because it isn’t in the correct format.")
                // Error handling
            }
            
        }
        
        
        
    case .PUT:
        print("Api put method")
    default:
        print("other  method")
    }
 
    } // Close Static Function
    
    
    // Headding: -   ===== Alert Message ============
    static func showLoginAlertMessage() -> Void
    {
        let alert = UIAlertController(title: "Alert!", message: "Before doing to any actoion,User must be logged in", preferredStyle: UIAlertController.Style.alert);
       
        
        alert.addAction(UIAlertAction.init(title: "Login", style: .default, handler: { (A) in
            
            let app = UIApplication.shared.delegate as? AppDelegate
            app?.loadLoginView()
        }))
        
        let action2 = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(action2)
        
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window
            {
                window.rootViewController?.present(alert, animated: true, completion: nil)
            }
        
       
    }
    
    
    
} // Close Class
