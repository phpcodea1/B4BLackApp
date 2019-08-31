//
//  HomeVC.swift
//  B4Black
//
//  Created by eWeb on 20/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Alamofire
import Toast_Swift
import KYDrawerController
import SVProgressHUD

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var locationBtnOutlet: UIButton!
    @IBOutlet weak var callButtonOutlet: UIButton!
    @IBOutlet weak var noimageFoundLbl: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var stationarylabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumberlabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var topcollection: UICollectionView!
    @IBOutlet var callBtnOutlet: UIButton!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var descriptionLabelll: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var blurViewEmailTF: UITextField!
    
    var detailImageArray = NSMutableArray()
    var businessid = ""
    var businessName = ""
    var detailMainArray = NSArray()
    var imageID = ""
    var ContactNumber = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.blurView.isHidden = true
        print(imageID)
        print(businessName)
        topcollection.delegate = self
        topcollection.dataSource = self
        self.ShowBusinessDetailAPI()
     
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.blurViewEmailTF.text = ""
    }
    
    @IBAction func side(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return detailImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCollectionViewCell", for: indexPath) as! TopCollectionViewCell
        
        if let img =  detailImageArray[indexPath.row] as? NSDictionary
        {
            if let img2 = img.value(forKey: "image_path") as? String
            {
                let url = URL(string: img2)
                
                cell.CollectionImageView.sd_setShowActivityIndicatorView(true)
                cell.CollectionImageView.sd_setIndicatorStyle(.gray)
                
                cell.CollectionImageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
            }
          
        }
        else
        {
            cell.CollectionImageView.image = UIImage(named: "rectImage")
        }
        
        return cell
    }
    
    @IBAction func EditButton(_ sender: Any)
    {
    
    let addBusinessvc = self.storyboard?.instantiateViewController(withIdentifier: "AddBusinessVC") as? AddBusinessVC
        addBusinessvc?.fromeditProfile = "yes"
        addBusinessvc?.recivingArray = self.detailMainArray
        addBusinessvc?.immgID = imageID
        addBusinessvc?.fromEditBusnsID = ((detailMainArray as NSArray).object(at: 0) as! NSDictionary).value(forKey: "business_id") as! String
        self.navigationController?.pushViewController(addBusinessvc!, animated: true)
        
    }
    
    /////  LOCATION BUTTON
    
    @IBAction func LocationBtnAct(_ sender: UIButton)
    {
        
        let mapview = self.storyboard?.instantiateViewController(withIdentifier: "MapLocaitonViewControlller") as! MapLocaitonViewControlller
        self.navigationController?.pushViewController(mapview, animated: true)
    }

    ///// CALLING BUTTON
    
    @IBAction func CallBtnAct(_ sender: UIButton)
    {
        
        print("Calling Button")

        if let url = URL(string: "tel://\(self.ContactNumber)"), UIApplication.shared.canOpenURL(url)
        {
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    ////////////        Chat Call And Email Button
    
     // Chat Button
    
    @IBAction func ChatBtnAct(_ sender: UIButton)
    {
        
     let chatView = self.storyboard?.instantiateViewController(withIdentifier: "SectionViewController") as! SectionViewController
        
     self.navigationController?.pushViewController(chatView, animated: true)
        
//     chatView.myBusinessId = businessid
//     chatView.fromChatList = "no"
//     chatView.myBusinessNAME = businessName
//     chatView.profileImageArray = detailImageArray
//     self.navigationController?.pushViewController(chatView, animated: true)
       
    }
    
    //  Call Button
    
    @IBAction func CallingBtnAction(_ sender: UIButton)
    {
        /*
        let alertController = UIAlertController(title: "Alert", message: "You want to Call ?..", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Yes", style: .default)  {(action:UIAlertAction!) in
            //    self.loguotUserAPI()
            
        }
        let OKAction1 = UIAlertAction(title: "Cancel", style: .default)  {(action:UIAlertAction!) in
        }
        alertController.addAction(OKAction1)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
        */
        
    }
    
    // Email Button

    @IBAction func EmailBtnAct(_ sender: UIButton)
    {
     self.blurView.isHidden = false
    }
    @IBAction func BlurViewSendBtn(_ sender: UIButton)
    {
 
        if blurViewEmailTF.text!.isEmpty
        {
          let alert = UIAlertController(title: "Alert", message: "Please type E-mail address", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            })
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if validate(YourEMailAddress: blurViewEmailTF.text!) == false
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter valid email address", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.sendEmailAPI()
        }
    }
    func validate(YourEMailAddress: String) -> Bool
    {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    @IBAction func BlurViewCancelBtn(_ sender: UIButton)
    {
      self.blurViewEmailTF.text = ""
      self.blurView.isHidden = true
    }
    func isValidEmail(testStr:String) -> Bool
    {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    // SENDING EMAIL API
    
    func sendEmailAPI()
    {
        SVProgressHUD.show()
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
       
        let params = ["customer_id"  : USERID,
                      "business_id" : businessid] as [String : AnyObject]
        print(params)
        ApiHandler.callApiWithParameters(url: emailURL, withParameters: params , success: {
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
                print("success")
                let alert = UIAlertController(title: "Notification", message: "Successfully send", preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                alert.addAction(submitAction)
                self.present(alert, animated: true, completion: nil)
                self.blurView.isHidden = true
                
            }
        }, failure: {
            
            string in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            print(string)
        }, method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
        
    }
    
    // API Working  [For This Screen]
    
    func ShowBusinessDetailAPI()
    {
        SVProgressHUD.show()
        var USERID = "66"
        
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let para = ["business_id" : businessid] as [String : AnyObject]
        print(para)
        
    ApiHandler.callApiWithParameters(url:showBusinessDetailURL,withParameters:para,
         success: {
            
         json in
         print(json)
            
         if (json as NSDictionary).value(forKey: "status") as! String == "failure"
         {
             SVProgressHUD.dismiss()
            
        let alert = UIAlertController(title: "Alert", message: (json as NSDictionary).value(forKey: "message") as? String, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
         }
        else
         {
            SVProgressHUD.dismiss()
            
        if let detailMainArray2 = ((json as NSDictionary).value(forKey: "business_data") as? NSArray)
            {
               self.detailMainArray = detailMainArray2
                
            if let dict = (self.detailMainArray.object(at: 0) as? NSDictionary)
                    {
            if let desc = dict.value(forKey: "business_description") as? String
                    {
                      self.descriptionView.text = desc
                    }
            if let Headinglabel = dict.value(forKey: "business_name") as? String
                    {
                        self.namelabel.text = Headinglabel
                    }
            if let location = dict.value(forKey: "business_location") as? String
                    {
                        self.locationBtnOutlet.setTitle(location, for: .normal)
                    }
            if let phoneNmbr = dict.value(forKey: "business_communication_mobile") as? String
                    {
                      //  self.ContactNumber = phoneNmbr
                        self.callButtonOutlet.setTitle(phoneNmbr, for: .normal)
                    }
            if let advertisement = dict.value(forKey: "business_place_advertisment") as? String
                    {
                        self.stationarylabel.text = advertisement
                    }
                    /*
            if let mobile = dict.value(forKey: "business_communication_mobile") as? String
                    {
                        self.callBtnOutlet.titleLabel?.text = mobile
                    }
                     */
            if let advertisement = dict.value(forKey: "business_images") as? NSArray
                    {
                        self.detailImageArray = advertisement.mutableCopy() as! NSMutableArray
                    }
            if self.detailImageArray.count == 0
                    {
                        self.noimageFoundLbl.isHidden = false
                    }
                    else
                    {
                        self.noimageFoundLbl.isHidden = true
                    }
                    self.topcollection.reloadData()
                }
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
extension HomeVC:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        print("screen size = \(UIScreen.main.bounds.width)")
        
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
}
