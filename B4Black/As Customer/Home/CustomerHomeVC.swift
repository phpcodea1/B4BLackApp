//
//  CustomerHomeVC.swift
//  B4Black
//
//  Created by eWeb on 22/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import KYDrawerController

class CustomerHomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource
{
   
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet var popView: UIView!
    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var TopCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var titleArray = ["ALL","Style","TV & Movies","Shoping","Comics","Fashion"]
    var popWillShow:String = "false"
    var mainArray1 = NSArray()
    var dict = NSDictionary()
    var dataArray = NSArray()
    var dataDict = NSDictionary()
    var userImageForDetailPage = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.customerHomePageApi()
        self.selectCAtegoryAPI()
        
        
        if let willPopupShow = DEFAULT.value(forKey: "willPopupShow") as? String
        {
            popWillShow = willPopupShow
        }
        collectionView.register(UINib(nibName: "CustomerHomeCell", bundle: nil), forCellWithReuseIdentifier: "CustomerHomeCell")
        if popWillShow == "true"
        {
            self.popView.isHidden = false
        }
        else
        {
            self.popView.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
         self.customerHomePageApi()
    }
    @IBAction func sideMenu(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
    
    @IBAction func goForSearch(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CustomerSearchViewController") as! CustomerSearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == TopCollectionView
            {
                return self.dataArray.count
            }
            else if collectionView == imageCollection
            {
                return self.titleArray.count
            }
            else if collectionView == collectionView
            {
            return self.mainArray1.count
            }
            else
            {
                return 20
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView == TopCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCustCollectionViewCell", for: indexPath) as!  TopCustCollectionViewCell
            
            
            cell.uiView.layer.cornerRadius = 10
            cell.uiView.layer.borderWidth = 1.5
            cell.uiView.layer.borderColor = UIColor.lightGray.cgColor
            self.dataDict = dataArray.object(at: indexPath.item) as! NSDictionary
            let name = dataDict.value(forKey: "cat_name") as! String
            cell.titleLbl.text = name

            return cell
            
            
        }
       else if collectionView == imageCollection
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerImageCollectionViewCell", for: indexPath) as! CustomerImageCollectionViewCell
             cell.titleLbl.text = "Ad  \(indexPath.row+1)" 
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerHomeCell", for: indexPath) as? CustomerHomeCell
            
            self.dict = self.mainArray1.object(at: indexPath.item) as! NSDictionary
            let name = self.dict.value(forKey: "business_name") as! String
            print(name)
            cell?.nameLbl.text = self.dict.value(forKey: "business_name") as? String
            
            if let mainImgArray1 = (mainArray1.object(at: indexPath.item) as! NSDictionary).value(forKey: "business_images") as? NSArray
            {
                if mainImgArray1.count>0
                {
                    let image = ((mainImgArray1 as NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_path") as! String
                    
                    if image.lowercased().range(of:"https") != nil
                    {
                        let url = URL(string: image)
                        print("exists")
                        cell?.collectImg.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                    }
                    else
                    {
                     let url = URL(string: image)
                        
                       cell?.collectImg.sd_setShowActivityIndicatorView(true)
                       cell?.collectImg.sd_setIndicatorStyle(.gray)
                       cell?.collectImg.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                    }
               }
                else
                {
                  cell?.collectImg.image = UIImage(named: "rectImage")
                }
            }
            else
            {
                cell!.collectImg.image = UIImage(named: "rectImage")
                
            }
            
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == imageCollection
        {
            
        }
        else if collectionView == TopCollectionView
        {
            self.dataDict = dataArray.object(at: indexPath.item) as! NSDictionary
            let cat_id = dataDict.value(forKey: "cat_id") as! String
            print(cat_id)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CustomerBusinessDetailViewController") as!CustomerBusinessDetailViewController
            
            vc.businesUserId = ((mainArray1.object(at: indexPath.item) as? NSDictionary)!.value(forKey: "business_id") as? String)!
            vc.businessNAme =  ((mainArray1).object(at: indexPath.row) as! NSDictionary).value(forKey: "business_name") as! String
            vc.recieveCustomerProfile = userImageForDetailPage
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
  
    }

    @IBAction func closePopup(_ sender: UIButton)
    {
        DEFAULT.removeObject(forKey: "willPopupShow")
        DEFAULT.synchronize()
        self.popView.isHidden = true
    }
    
    
    //////         Home Page API
    
    func customerHomePageApi()
    {
        SVProgressHUD.show()
        
        var para:[String : AnyObject]!
        
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
            para = ["user_id" : USERID] as [String : AnyObject]
        }
        else
        {
            para = ["user_login_status" : "true"] as [String : AnyObject]
            
        }
        print(para)
        ApiHandler.callApiWithParameters(url: allBusinessListURL, withParameters:para,
        success: {
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

             //var mainArray1 = ((json as NSDictionary).value(forKey: "business_data") as? NSArray)!
            self.mainArray1 = ((json as NSDictionary).value(forKey: "business_data") as?                         NSArray)!
            self.mainArray1 = (self.mainArray1.reversed() as NSArray).mutableCopy() as! NSMutableArray
            self.collectionView.reloadData()
            
            ////  *******  USER PROFILE IMAGE AT HOME PAGE
            
            if  let userData2 = ((json as NSDictionary).value(forKey: "user_data") as? NSDictionary)
            {
                if let userData = userData2.value(forKey: "user_profile_image") as? String
                {
                    let displayimg = imageBaseURL + userData
                    self.userImageForDetailPage = displayimg
                    let img = URL(string: displayimg)
                    
                    self.userProfileImage.layer.borderWidth = 1.0
                    self.userProfileImage.layer.masksToBounds = false
                    self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.height/2
                    // + self.profileImg2.frame.height/2
                    self.userProfileImage.layer.borderColor = UIColor.clear.cgColor
                    self.userProfileImage.clipsToBounds = true
                    self.userProfileImage.sd_setShowActivityIndicatorView(true)
                    self.userProfileImage.sd_setIndicatorStyle(.gray)
                    self.userProfileImage.sd_setImage(with: img, placeholderImage: UIImage(named: "077"))
                    
                }
            }
       }
        },failure:
            {
                string in
                SVProgressHUD.show()
                let alert = UIAlertController(title: "Alert", message: string, preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                alert.addAction(submitAction)
                self.present(alert, animated: true, completion: nil)
                print(string)
                
        },method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
    
    @IBAction func GoToProfileView(_ sender: UIButton)
    {
        
        let profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profile, animated: true)
        
    }
    
    // CATEGORY SELECTION
    
    func selectCAtegoryAPI()
    {
        SVProgressHUD.show()
        ApiHandler.callApiWithParameters(url: selectCategoryURL, withParameters: [ : ], success: {
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
                print("success")
                SVProgressHUD.dismiss()
                self.dataArray = ((json as NSDictionary).value(forKey: "data") as! NSArray)
                print(self.dataArray)
                self.TopCollectionView.reloadData()
                
            }
        }, failure:
            {
            
            string in
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Alert", message: "JSON", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }, method: .GET, img: nil, imageParamater: "", headers: [ : ])
    
    }
    
}
extension CustomerHomeVC:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        print("screen size = \(UIScreen.main.bounds.width)")
        
        if collectionView == TopCollectionView
        {
            let size = (self.titleArray[indexPath.row] as NSString).size(withAttributes: nil)
            print("Size = \(size)")
            
            return CGSize(width: 100,height: 40)
        }
            else if collectionView == imageCollection
        {
              return CGSize(width: UIScreen.main.bounds.width-28,height: 72)
        }
        else
        {
             return CGSize(width: UIScreen.main.bounds.width/2 - 18,height: UIScreen.main.bounds.height/3 - 55)
        }
    }
  
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.5
    }
    
}
