//
//  AppDelegate.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Alamofire
import Toast_Swift
import KYDrawerController
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore
import FacebookShare
import FBSDKShareKit
import FBSDKLoginKit
import TwitterKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
  class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    var myView:UIView? = nil
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
      
       //  Messaging.messaging().delegate = self as! MessagingDelegate
       UITextField.appearance().defaultFont = UIFont.init(name: "Comfortaa", size: 17.0)
    // Amar IOS Dept. git test
    
        if let str = DEFAULT.value(forKey: "BUSINESS") as? String
        {
             loadBusinessView()
        }
        else
        {
            if let str = DEFAULT.value(forKey: "CUSTOMER") as? String
            {
            loadCustomerView()
            }
            else
            {
                loadLoginView()
                DEFAULT.set("CUSTOMER", forKey: "CUSTOMER")
                DEFAULT.synchronize()
                loadCustomerView()
                
        }

        }

        TWTRTwitter.sharedInstance().start(withConsumerKey:"28tzZBg4ogkuLBUL9HM535vMo", consumerSecret:"6uiZZIQuHXXWzbErJ9W6X2ehonmchp8o1gAr26UOoJcnXeEUGU")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    private func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
    
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation:annotation)
    
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
//
//    func showLoader()
//    {
//        let mainView1 = UIScreen.main.bounds
//        myView = UIView(frame: mainView1)
//        let myView2 = UIView(frame: mainView1)
//        myView2.backgroundColor = .black
//        myView2.alpha = 0.5
//        myView? .addSubview(myView2)
//        let loaderFrame = CGRect(x: 0, y: 0, width: 60, height: 60)
//        let activityIndicatorView =  NVActivityIndicatorView(frame: loaderFrame, type: .ballRotateChase, color: .white, padding: 5)
//        //activityIndicatorView.backgroundColor = .red
//        activityIndicatorView.center = (self.window?.rootViewController?.view.center)!
//        myView?.addSubview(activityIndicatorView)
//        activityIndicatorView.startAnimating()
//        self.window?.rootViewController?.view.addSubview(myView!)
//        //        self.perform(#selector(HideLoader), with: nil, afterDelay: 2.0)
//    }
//    func HideLoader()
//    {
//        myView?.removeFromSuperview()
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "B4Black")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loadBusinessView()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "KYDrawerController") as! KYDrawerController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    func loadLoginView()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    func loadCustomerView()
    {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "CUSTOMER") as! KYDrawerController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }

}
extension UITextField
{
    var defaultFont: UIFont?
    {
    get
    {
      return self.font
     }
     set
     {
      self.font = newValue
     }
    }
}
