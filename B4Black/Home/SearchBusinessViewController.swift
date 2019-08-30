//
//  SearchBusinessViewController.swift
//  B4Black
//
//  Created by administrator on 30/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchBusinessViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UITextFieldDelegate

{
   
    @IBOutlet var searchTextfield: UITextField!
    @IBOutlet var searchUIview: UIView!
    @IBOutlet var searchCollection: UICollectionView!
    
    var mainArray = NSMutableArray()
    var searchedArray = NSMutableArray()
    var arrayToBeSearched = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getBusinessListApi()
        searchCollection.register(UINib(nibName: "searchBusinessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchBusinessCollectionViewCell")
        searchTextfield.addTarget(self, action: #selector(searchTyping), for: .allEditingEvents)
        searchUIview.layer.borderWidth = 2
        searchUIview.layer.borderColor = UIColor.lightGray.cgColor
        searchUIview.layer.cornerRadius = 15
        searchTextfield.delegate = self
        searchTextfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    @objc func textFieldDidChange(textfield: UITextField)
    {
     
       
    }
    @objc func searchTyping(_ textfield:UITextField)
    {
        
        print("textfield typing =  \(textfield.text!)")
        
        if (textfield.text == nil) {
            // self.searchedArray = self.mainArray//.mutableCopy() as! NSMutableArray
            
               self.searchedArray.removeAllObjects()
        }
        else
        {
            if(self.searchedArray.count>=1)
            {
                
                
                self.searchedArray.removeAllObjects()
            }
            for  i in 0..<self.mainArray.count
            {
                var dic = NSDictionary();
                dic = self.mainArray[i] as! NSDictionary
                
                let data = "\(dic.value(forKey: "business_name") as! String)"
                if ((data.range(of: textfield.text!, options: .caseInsensitive, range: nil, locale: nil)) != nil)
                {
                    self.searchedArray.add(dic)
                }
            }
        }
        
        // calling here
        searchCollection.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchBusinessCollectionViewCell", for: indexPath) as! searchBusinessCollectionViewCell
        
        
        cell.ImgView.sd_setShowActivityIndicatorView(true)
        cell.ImgView.sd_setIndicatorStyle(.gray)
        
        cell.nameLabel.text = (searchedArray.object(at: indexPath.row) as? NSDictionary)!.value(forKey: "business_name") as? String
        
        if let imageArray = (searchedArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as? NSArray
        {
            if imageArray.count>0
            {
                let image = (((searchedArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_path") as! String
                
                let image_id = (((searchedArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_id") as! String
                
                if image.lowercased().range(of:"https") != nil
                {
                    let url = URL(string: image)
                    print("exists")
                    cell.ImgView.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                }
                else
                {
                    let url = URL(string: image)
                    cell.ImgView.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
                }
                
            }
            else
            {
                
                cell.ImgView.image = UIImage(named: "rectImage")
                
                
            }
        }
        else
        {
            cell.ImgView.image = UIImage(named: "rectImage")
            
        }
        
        
        return cell
        
        
        
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelSearch(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
                                                
                                                self.mainArray = (mainArray1.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                                              
                                               // self.searchedArray = mainArray1.mutableCopy() as! NSMutableArray
                                                
                                                
                                                self.searchCollection.reloadData()
                                                
                                                ////  *******  USER PROFILE IMAGE AT HOME PAGE
                                                
                                                if  let userData2 = ((json as NSDictionary).value(forKey: "user_data") as? NSDictionary)
                                                { }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let businessID = (searchedArray.object(at: indexPath.row) as? NSDictionary)!.value(forKey: "business_id") as? String
            
            if let imageArray = (searchedArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as? NSArray
            {
                if imageArray.count>0
                {
                    let image_id = (((searchedArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "business_images") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_id") as? String
                    
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
}
extension SearchBusinessViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        print("screen size = \(UIScreen.main.bounds.width)")
        
        
        return CGSize(width: UIScreen.main.bounds.width - 20,height: UIScreen.main.bounds.height/3 - 30)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 3.0
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 3.0
    }
}
