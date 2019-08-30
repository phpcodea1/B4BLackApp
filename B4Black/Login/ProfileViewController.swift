//
//  ProfileViewController.swift
//  B4Black
//
//  Created by eWeb on 16/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import Photos
import Alamofire
import Foundation
import SVProgressHUD
import ALCameraViewController
import KYDrawerController

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    @IBOutlet weak var imagr: UIImageView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var contactPersonTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
  
    /// ImageEditing
    
    var libraryEnabled:Bool = true
    var croppingEnabled: Bool = true
    var allowResizing: Bool = true
    var allowMoving:Bool = true
    var imagePicker: UIImagePickerController!
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    
   // var imagePicker = UIImagePickerController()
    var choosenImage:UIImage!
    var imgArray = NSMutableArray()
    
    //  IMAGE EDITING
    var croppingPerameters: CroppingParameters
    {
        return CroppingParameters(isEnabled: true, allowResizing: allowResizing, allowMoving: allowMoving, minimumSize: minimumSize)
    }
    override func viewDidLoad()
    {
         super.viewDidLoad()
         self.customerViewProfileAPI()
        /*
                let CameraVc = CameraViewController
                { [weak self] image, asset in
                    
                    self?.dismiss(animated: true, completion: nil)
                }
                
                present(CameraVc, animated: true, completion: nil)
        */
    }
   
    @IBAction func backButton(_ sender: Any)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    @IBAction func imageBtnAct(_ sender: Any)
    {
            
            let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
            {
                UIAlertAction in
                self.openCamera()
            }
            let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
            {
                UIAlertAction in
                self.openGallary()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            {
                UIAlertAction in
            }
            // Add the actions
          //  imagePicker.delegate = self
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
    
    }
    func openCamera()
    {
        let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.imagr.image = image
             self?.choosenImage = image
            self!.dismiss(animated: true, completion: nil)
        }
        present(cameraViewController,animated: true, completion:  nil)

    }
    func openGallary()
    {
        
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.imagr.image = image
            self?.choosenImage = image
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
    }
    
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
       if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
       {
        imagr.image = choosenImage
        imagr.layer.cornerRadius = imagr.frame.size.height/2
        picker.dismiss(animated: true, completion: nil)
       }
       else if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
       {
          imagr.image = choosenImage
         // imagr.image = choosenImage.resizableImage()
          imagr.layer.cornerRadius = imagr.frame.size.height/2
          picker.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func HideShowPassAct(_ sender: UIButton)
    {
       if sender.isSelected
        {
            sender.setImage(UIImage(named: "hidePassword"), for: .normal)
            passwordTF.isSecureTextEntry = true
            sender.isSelected = false
        }
        else
        {
            sender.setImage(UIImage(named: "showPassword"), for: .normal)
            passwordTF.isSecureTextEntry = false
            sender.isSelected = true
        }
    }
    
    @IBAction func SaveButton(_ sender: Any)
    {
        if self.nametextField.text ==  "" || self.contactPersonTF.text == "" || self.mobileNumberTextField.text == "" || self.emailtextField.text == "" || self.passwordTF.text == ""
        {
            let alert = UIAlertController.init(title: "Alert", message: "please fill all the field", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.EditProfileApiCall()
        }
     }
    
    //  Customer View profile
    
    func customerViewProfileAPI()
    {
        SVProgressHUD.show()
    var USERID = "66"
    if  let id = DEFAULT.value(forKey: "USERID") as? String
    {
        USERID = id
    }
        print("Para in view profile \(USERID)")
        ApiHandler.callApiWithParameters(url: viewprofileURL, withParameters: ["user_id" : USERID]  as [String : AnyObject],
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
          self.nametextField.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "company_name") as? String
            
            self.contactPersonTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_fname") as? String
            
            self.mobileNumberTextField.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_mobile") as? String
            
            self.emailtextField.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_email") as? String
            
            self.passwordTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_password") as? String
   
             if let pic1 = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_profile_image") as? String

            {
                let finalImage = imageBaseURL + pic1
                let url = URL(string: finalImage)
                
                self.imagr.sd_setShowActivityIndicatorView(true)
                self.imagr.sd_setIndicatorStyle(.gray)
                
                self.imagr.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
            }
             else
            {
                self.imagr.image = UIImage(named: "rectImage")
            }
            SVProgressHUD.dismiss()
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
            },
            method: .POST, img: nil, imageParamater: "", headers: [ : ])
    
  }
  // *****************  EDIT PROFILE
    
    func EditProfileApiCall()
    {
        SVProgressHUD.show()
        
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let para = ["user_id" : USERID,
         "company_name" : nametextField.text!,
         "user_fname" : contactPersonTF.text!,
         "user_mobile" : mobileNumberTextField.text!,
         "user_email" : emailtextField.text!,
         "user_password" : passwordTF.text!,
         "co_registeration_id_password" : "",
         "bee_number" : "",
         "gender" : "",
         "race" : ""]
      
        print(para)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
    
            if self.choosenImage != nil
            {
                
                multipartFormData.append(UIImageJPEGRepresentation(self.choosenImage, 0.6)!, withName: "pro_images", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
               
            }
            for (key, value) in para {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            print(para)
        }, to:"http://a1professionals.net/blackbusiness/api/upd_Business_User")
        { (result) in
            switch result
            {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    
                })
                
                upload.responseJSON { response in
                    
                    if let JSON = response.result.value! as? NSDictionary
                    {
                        print(JSON)
                        
                        if(JSON.value(forKey: "code") as!String == "200")
                        {
                            SVProgressHUD.dismiss()
                        let alert = UIAlertController(title: "Alert", message: (JSON.value(forKey: "code") as!String), preferredStyle: .alert)
                        let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                        alert.addAction(submitAction)
                        self.present(alert, animated: true, completion: nil)
                           
                        }
                        else if (JSON.value(forKey: "code") as!String == "201")
                        {
                            SVProgressHUD.dismiss()
                            
                            if let img = ((JSON as! NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "user_profile_image") as? String
                            {
                                let finalImage = imageBaseURL + img
                                let url = URL(string: finalImage)
                                
                                self.imagr.sd_setImage(with: url, placeholderImage: nil, options: .progressiveDownload, completed: nil)
                            }
                            else
                            {
                                self.imagr.image = UIImage(named: "rectImage")
                            }
                            
                            let v = self.storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC") as? CustomerHomeVC
                            self.navigationController?.pushViewController(v!, animated: true)
                            
                        }
                        SVProgressHUD.dismiss()
                    }
                }
                
                break
                
            case .failure(let encodingError):
                break
                print(encodingError)
                
            }
        }
    }
    
    
   
} // Close class
