//
//  CustomerBusinessDetailViewController.swift
//  B4Black
//
//  Created by eWeb on 15/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import KYDrawerController

class CustomerBusinessDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var myDetalView: UIView!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var callIcon: UIImageView!
    @IBOutlet weak var chatIcon: UIImageView!
    @IBOutlet weak var EmailIcon: UIImageView!
    @IBOutlet weak var RecentReviewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var heightForHideView: NSLayoutConstraint!
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var locationImg: UIImageView!
    @IBOutlet weak var callBtnOutlet: UIButton!
    @IBOutlet weak var locationBtnOutlet: UIButton!
    @IBOutlet weak var noImageFoundLbl: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var mobileNumberlabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var chatlabel: UILabel!
    @IBOutlet weak var CustomerBusinessImage: UIImageView!
    @IBOutlet weak var calllabel: UILabel!
    @IBOutlet weak var addressTextField: UILabel!
    @IBOutlet weak var stationarylabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var CollectionViewUser: UICollectionView!
    
    var count = Int()
    var callToNumber = ""
    var businesUserId = ""
    var headingLbl = ""
    var descLbl = ""
    var locatLbl = ""
    var contactLbl = ""
    var addStationaryLbl = ""
    var detailMainArray = NSArray()
    var homePicture = ""
    var dictionaryy = NSDictionary()
    var reviewArray = NSArray()
    var reviewDict = NSDictionary()
    var businessUserName = ""
    var imageAr = NSArray()
    var BUSNES_USER_idForChat = ""
    var businessNAme = ""
    var recieveCustomerProfile = ""

    override func viewDidLoad()
    {
         super.viewDidLoad()
        
       //  TopImageCollection.isHidden = true
      // TopImageCollection.register(UINib(nibName: "CustomerBusinessDetailCell", bundle: nil), forCellWithReuseIdentifier: "CustomerBusinessDetailCell")
       
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
             heightForHideView.constant = 73
             scrollViewHeight.constant = 800
             RecentReviewConstraintOutlet.constant = 53
             self.emaillabel.isHidden = false
             self.mobileNumberlabel.isHidden = false
             self.chatlabel.isHidden = false
             self.callBtnOutlet.isHidden = false
             self.calllabel.isHidden = false
             self.addressTextField.isHidden = false
             self.locationBtnOutlet.isHidden = false
             self.locationImg.isHidden = false
             self.callImage.isHidden = false
             }
            else
            {
              
                heightForHideView.constant = 18
                scrollViewHeight.constant = 700
                RecentReviewConstraintOutlet.constant = 15
                self.locationImg.isHidden = true
                self.callImage.isHidden = true
                self.emaillabel.isHidden = true
                self.mobileNumberlabel.isHidden = true
                self.chatlabel.isHidden = true
                self.callBtnOutlet.isHidden = true
                self.calllabel.isHidden = true
                self.addressTextField.isHidden = true
                self.locationBtnOutlet.isHidden = true
                self.callIcon.isHidden = true
                self.EmailIcon.isHidden = true
                self.chatIcon.isHidden = true
         
            }
        
            self.customerSideBusinessDetailAPI()
            count = 4
            CollectionViewUser.delegate = self
            CollectionViewUser.dataSource = self
            print(recieveCustomerProfile)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerCollectionViewCell", for: indexPath) as! CustomerCollectionViewCell
        return cell1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
    }
    override func viewWillLayoutSubviews()
    {
        super.updateViewConstraints()
    }
    @IBAction func seemoreButton(_ sender: UIButton)
    {
        
        var USERID = ""
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
            
        if reviewArray.count > 0
        {
            print(reviewArray)
            
            let seeMore = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreReviewVC") as! SeeMoreReviewVC
            seeMore.reviewArray = self.reviewArray
            self.navigationController?.pushViewController(seeMore, animated: true)
            
        }
        else
        {
            print("Empty Array")
            
            let alert = UIAlertController(title: "Message", message: "There is no more review for this business", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        }
        else
        {
          ApiHandler.showLoginAlertMessage()
        }
    }
    @IBAction func backButton(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func CheckAllReviews(_ sender: Any)
    {
        
    }
    
    /////////     LOCATION & CALL BUTTON ACT

    @IBAction func LocationBtnAct(_ sender: UIButton)
    {
        var USERID = ""
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
            addressTextField.isHidden = false
            locationBtnOutlet.isHidden = false
            let mapview = self.storyboard?.instantiateViewController(withIdentifier: "MapLocaitonViewControlller") as! MapLocaitonViewControlller
            self.navigationController?.pushViewController(mapview, animated: true)
            
        }
        else
        {
            ApiHandler.showLoginAlertMessage()
        }
    }
    @IBAction func CallBtnAct(_ sender: UIButton)
    {
        
        var USERID = ""
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
            
            print("Calling Button")
            callBtnOutlet.isHidden = false
            calllabel.isHidden = false
            if let url = URL(string: "tel://\(self.callToNumber)"), UIApplication.shared.canOpenURL(url)
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
        else
        {
            ApiHandler.showLoginAlertMessage()
        }
        
    } /////////////////   BTN ACT CLOSE
    
    @IBAction func AddReview(_ sender: UIButton)
    {
        var USERID = ""
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        let addReview = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as! AddReviewVC
        addReview.busniessID = businesUserId
        self.present(addReview, animated: true, completion: nil)
        }
        else
        {
            ApiHandler.showLoginAlertMessage()
        }
    }
    @IBAction func chatBtnAct(_ sender: UIButton)
    {
        
        let chatView = self.storyboard?.instantiateViewController(withIdentifier: "DemoChatController") as! DemoChatController
        
        chatView.profileImage = recieveCustomerProfile
        chatView.TheBusinesProfileArray = imageAr
        chatView.BUSNES_User_ID = BUSNES_USER_idForChat
        chatView.myBusinessId = businesUserId
        chatView.B_Name = businessNAme
        chatView.fromChatList = "no"
        
        self.navigationController?.pushViewController(chatView, animated: true)

    }
    @IBAction func emailBtnAct(_ sender: UIButton)
    {
        
    }
    @IBAction func callBtnAct(_ sender: UIButton)
    {
        
    }
    func customerSideBusinessDetailAPI()
    {
        SVProgressHUD.show()
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let para = ["business_id" : businesUserId] as [String : AnyObject]
        print(para)
        
        ApiHandler.callApiWithParameters(url: showBusinessDetailURL,withParameters:para,
        success:
        {
                json in
                print(json)
                if   (json as NSDictionary).value(forKey: "status") as! String == "failure"
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
                            self.dictionaryy = dict
                            
                            if let desc = dict.value(forKey: "business_description") as? String
                            {
                                self.detailTextView.text = desc
                            }
                            if let Headinglabel = dict.value(forKey: "business_name") as? String
                            {
                                self.headingLabel.text = Headinglabel
                                DEFAULT.set(Headinglabel, forKey: "BUSNES_NAME")
                            }
                            if let location = dict.value(forKey: "business_location") as? String
                            {
                                self.addressTextField.text = location
                            }
                            if let phoneNmbr = dict.value(forKey: "business_communication_mobile") as? String
                            {
                                self.calllabel.text = phoneNmbr
                                self.callToNumber = phoneNmbr
                            }
                            if let advertisement = dict.value(forKey: "business_place_advertisment") as? String
                            {
                                self.stationarylabel.text = advertisement
                            }
                            if let chatlabel = dict.value(forKey: "business_communication_chat") as? String
                            {
                                self.chatlabel.text = chatlabel
                            }
                            if let emaillabel = dict.value(forKey: "business_communication_email") as? String
                            {
                                self.emaillabel.text = emaillabel
                            }
                            if let mobilelabel = dict.value(forKey: "business_communication_mobile") as? String
                            {
                                self.mobileNumberlabel.text = mobilelabel
                            }
                            
                            if  let B_User_Id = (((json as NSDictionary).value(forKey: "business_data") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "business_user_id") as? String
                            {
                                self.BUSNES_USER_idForChat = B_User_Id
                            }
                            
                            if let reviewArray1 = dict.value(forKey: "business_review") as? NSArray
                            {
                               self.reviewArray=reviewArray1
                                
                                if reviewArray1.count > 0
                                {
                                    print(reviewArray1)
                                }
                                else
                                {
                                    print("Empty Array")
                                }
                            }
                            self.imageAr  = (self.dictionaryy.value(forKey: "business_images") as? NSArray)!
                            
                            if self.imageAr.count>0
                            {
                                let imgDict = self.imageAr.object(at: 0) as! NSDictionary
                                let img = imgDict.value(forKey: "image_path") as! String
                                let url1 = URL(string: img)!
                                
                                print("image url \(url1)")
                                self.CustomerBusinessImage.sd_setImage(with: url1, placeholderImage: UIImage(named: "rectImage"), options: .refreshCached, completed: nil)
                                
                            }
                            else
                            {
                                self.CustomerBusinessImage.image = UIImage(named: "rectImage")
                            }
                            
                            
                        } // close Dict
                       
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

/*
 Mentorfy Latest Code
 smb://192.168.1.203/Android_Ios-Dept/April_Month_Code/April_First_week_iOS_Android_Code/Mentrofy/MENTORFY/Mentorfy_30May.zip
 */
