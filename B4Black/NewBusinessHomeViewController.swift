//
//  NewBusinessHomeViewController.swift
//  B4Black
//
//  Created by administrator on 01/08/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import KYDrawerController
import LocalAuthentication
import SDWebImage
import SVProgressHUD

class NewBusinessHomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    var mainArray = NSArray()
    var AddBusnsFirstImg = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        topCollectionView.isHidden = true
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.register(UINib(nibName: "NewBusinessHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewBusinessHomeCollectionViewCell")
        self.getBusinessListApi()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.getBusinessListApi()
    }
    @IBAction func goToSearch(_ sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchBusinessViewController") as! SearchBusinessViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
         return mainArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = topCollectionView.dequeueReusableCell(withReuseIdentifier: "NewBusinessHomeCollectionViewCell", for: indexPath) as! NewBusinessHomeCollectionViewCell
        
        cell.collectImg.sd_setShowActivityIndicatorView(true)
        cell.collectImg.sd_setIndicatorStyle(.gray)
        
        cell.NameLbl.text = (mainArray.object(at: indexPath.row) as? NSDictionary)!.value(forKey: "business_name") as? String
        
        if let imageArray = (mainArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as? NSArray
        {
            if imageArray.count>0
            {
                let image = (((mainArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_path") as! String
                
                let image_id = (((mainArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_id") as! String
                
                if image.lowercased().range(of:"https") != nil
                {
                    let url = URL(string: image)
                    print("exists")
                    cell.collectImg.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                }
                else
                {
                    let url = URL(string: image)
                    cell.collectImg.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                }
                
            }
            else
            {
                
                cell.collectImg.image = UIImage(named: "rectImage")
                
                
            }
        }
        else
        {
            cell.collectImg.image = UIImage(named: "rectImage")
            
        }
        
        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let businessID = (mainArray.object(at: indexPath.row) as? NSDictionary)!.value(forKey: "business_id") as? String
            
            if let imageArray = (mainArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as? NSArray
            {
                if imageArray.count>0
                {
                    let image_id = (((mainArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_id") as? String
                    
                    vc.imageID = image_id!
                }
            }
            vc.businessid = businessID!
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            ApiHandler.showLoginAlertMessage()
        }
        
        
    }
    @IBAction func side(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
    
    /////////    Api
    func getBusinessListApi()
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
        print("Home Api \(allBusinessListURL)")
        print("Home para \(para)")
        ApiHandler.callApiWithParameters(url: allBusinessListURL, withParameters:para,
        success: {
        json in
        print(para)
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
                                                
            //// ******* HOME PAGE DATA
                                                
            let mainArray1 = ((json as NSDictionary).value(forKey: "business_data") as? NSArray)!
            
            if mainArray1.count == 0
            {
                let alert = UIAlertController(title: "Alert", message: "You can create your own multiple businesses by using this Application. Go to the side bar then select the Add Business and then Create your Business.", preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                let goToAddBusiness = UIAlertAction(title: "Add New Business", style: .default, handler:
                { (action) -> Void in
                    
                    var go = self.storyboard?.instantiateViewController(withIdentifier: "AddBusinessVC") as! AddBusinessVC
                    self.navigationController?.pushViewController(go, animated: true)
                    
                })
                alert.addAction(submitAction)
                alert.addAction(goToAddBusiness)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
              self.mainArray = (mainArray1.reversed() as NSArray).mutableCopy() as! NSMutableArray
              self.topCollectionView.reloadData()
                ////  *******  USER PROFILE IMAGE AT HOME PAGE
                
                if  let userData2 = ((json as NSDictionary).value(forKey: "user_data") as? NSDictionary)
                {
                    
                    if let userData = userData2.value(forKey: "user_profile_image") as? String
                    {
                        let displayimg = imageBaseURL + userData
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
      }
  },failure:
            {
                string in
                SVProgressHUD.show()
                let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                alert.addAction(submitAction)
                self.present(alert, animated: true, completion: nil)
                print(string)
        },method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
}
extension NewBusinessHomeViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        print("screen size = \(UIScreen.main.bounds.width)")
        /*
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
            */
            return CGSize(width: UIScreen.main.bounds.width/2 - 18,height: UIScreen.main.bounds.height/3 - 30)
       // }
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
