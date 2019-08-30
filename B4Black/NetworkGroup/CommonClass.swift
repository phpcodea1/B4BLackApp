//
//  CommonClass.swift
//  KLshee
//
//  Created by Apple on 14/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import SystemConfiguration
import SVProgressHUD
class commonClass
{
    static let commonObj = commonClass()
    let myAppDel = UIApplication.shared.delegate as! AppDelegate
    var loaderView:NVActivityIndicatorView!
    var blurView = UIView()
    //1. MARK : Check Internet Connection

    func isConnectedToNetwork() -> Bool
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
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        print(ret)
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
    
    //2. MARK : Alert Method
    func showAlert(messageToShow:String,title:String)
    {
        let alert = UIAlertController(title: title, message: messageToShow, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .cancel)
        {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okBtn)
        myAppDel.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    //3.  check Is Empty
    func checkIsEmpty(str:String) -> Bool
    {
        return (str.trimmingCharacters(in: NSCharacterSet.whitespaces).count == 0)
    }
    // 4. MARK : Valid Email
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    // 5. MARK:---loader start
    func addLoader
        (viewToAdd:UIView)
    {
        
        let width = CGFloat(100.0)
        let frameVal = CGRect(x: viewToAdd.frame.width / 2 - width / 2, y: viewToAdd.frame.height / 2 - width / 2, width: width, height: width)
        loaderView = NVActivityIndicatorView(frame: frameVal, type: .ballSpinFadeLoader, color:UIColor.darkGray , padding: 20.0)
        let appDel_ref = UIApplication.shared.delegate as! AppDelegate
        blurView = UIView(frame: viewToAdd.frame)
        blurView.backgroundColor = UIColor.clear
        blurView.alpha = 0.82
        appDel_ref.window?.rootViewController?.view.addSubview(blurView)
        appDel_ref.window?.rootViewController?.view.addSubview(loaderView)
        loaderView.startAnimating()
    }
    // 6. --MARK:-- hideloader----
       func hideLoader()
      {
//        blurView.removeFromSuperview()
//        loaderView.removeFromSuperview()
//        loaderView.stopAnimating()
    }
}
