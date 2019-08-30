//
//  BusinesProfileViewController.swift
//  B4Black
//
//  Created by eWeb on 5/22/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
import SVProgressHUD
import Alamofire
import Photos
import ALCameraViewController
import Foundation

class BusinesProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var contactPersonTF: UITextField!
    @IBOutlet weak var contactNoTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var beeLevelTF: UITextField!
    @IBOutlet weak var coRegisterTF: UITextField!
    @IBOutlet weak var GenderTF: UITextField!
    @IBOutlet weak var RaceTF: UITextField!
    
  //  var imagePicker = UIImagePickerController()
    
   
    /// ImageEditing
    
    var libraryEnabled:Bool = true
    var croppingEnabled: Bool = true
    var allowResizing: Bool = true
    var allowMoving:Bool = true
    var choosenImage:UIImage!
    var imagePicker: UIImagePickerController!
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    
    //  IMAGE EDITING
    var croppingPerameters: CroppingParameters
    {
        return CroppingParameters(isEnabled: true, allowResizing: allowResizing, allowMoving: allowMoving, minimumSize: minimumSize)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
         ViewProfileAPI()
    }
    
    @IBAction func SelectImageAct(_ sender: Any)
    {
        
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        // Add the actions
   //     imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        
        let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.imageView.image = image
            self?.choosenImage = image
            self!.dismiss(animated: true, completion: nil)
        }
        present(cameraViewController,animated: true, completion:  nil)
        /*
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
          
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.isEditing = true
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.cameraCaptureMode =  UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.modalPresentationStyle = .custom
            self.present(imagePicker, animated: true, completion: nil)
         
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
        */
    }

    func openGallary()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.imageView.image = image
            self?.choosenImage = image
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
      //  imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        */
    }
    
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imageView.image = choosenImage
            imageView.layer.cornerRadius = imageView.frame.size.height/2
            picker.dismiss(animated: true, completion: nil)
        }
        else if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imageView.image = choosenImage
            imageView.layer.cornerRadius = imageView.frame.size.height/2
            picker.dismiss(animated: true, completion: nil)
        }

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hideShowPass(_ sender: UIButton)
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
    
    @IBAction func savebtnAct(_ sender: UIButton)
    {
        if self.companyNameTF.text ==  "" || self.contactPersonTF.text == "" || self.contactNoTF.text == "" || self.emailTF.text == "" || self.passwordTF.text == "" ||  self.RaceTF.text == "" || self.GenderTF.text == ""
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
    @IBAction func backButton(_ sender: Any)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func SelectGender(_ sender: UIButton)
    {
        let optionMenuController = UIAlertController(title: nil, message: "Choose Option from the Sheet", preferredStyle: .actionSheet)
        
        
        let male = UIAlertAction(title: "Male", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.GenderTF.text = "Male"
            print("File has been Add")
        })
        let female = UIAlertAction(title: "Female", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.GenderTF.text = "Female"
            print("File has been Edit")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(male)
        optionMenuController.addAction(female)
        optionMenuController.addAction(cancel)
        
        self.present(optionMenuController, animated: true, completion: nil)
        
    }
    @IBAction func selectRaceAct(_ sender: UIButton)
    {
        
        let optionMenuController = UIAlertController(title: nil, message: "Choose Option from Action Sheet", preferredStyle: .actionSheet)
        
        
        let African = UIAlertAction(title: "African", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.RaceTF.text = "African"
            print("File has been Add")
        })
        let Black = UIAlertAction(title: "Black", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.RaceTF.text = "Black"
            print("File has been Edit")
        })
        
        let White = UIAlertAction(title: "White", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.RaceTF.text = "White"
            print("File has been Delete")
        })
        let Coloured = UIAlertAction(title: "Coloured", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.RaceTF.text = "Coloured"
            print("File has been Delete")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        // Add UIAlertAction in UIAlertController
        
        optionMenuController.addAction(African)
        optionMenuController.addAction(Black)
        optionMenuController.addAction(White)
        optionMenuController.addAction(Coloured)
        optionMenuController.addAction(cancel)
        
        // Present UIAlertController with Action Sheet
        
        self.present(optionMenuController, animated: true, completion: nil)
        
    }
    
    // View Profile API
    
    
    func ViewProfileAPI()
    {
        SVProgressHUD.show()
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
             USERID = id
        }
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
                    
                    self.companyNameTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "company_name") as? String
                    
                    self.contactPersonTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_fname") as? String
                    
                    self.contactNoTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_mobile") as? String
                    
                    self.emailTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_email") as? String
                    
                    self.passwordTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_password") as? String
                 
                    self.GenderTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "gender") as? String
                  
                    self.RaceTF.text = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "race") as? String
                    
//                    if let race = UserDefaults.standard.value(forKey: "race") as? String
//                    {
//                        self.RaceTF.text = race
//                    }
                    if let pic1 = ((json as NSDictionary).value(forKey: "message") as! NSDictionary).value(forKey: "user_profile_image") as? String
                        
                    {
                        var finalImage = imageBaseURL + pic1
                        let url = URL(string: finalImage)
                        
                        self.imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
                    }
                    else
                    {
                        self.imageView.image = UIImage(named: "rectImage")
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
        },method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
    /// *****************  EDIT PROFILE
    
    func EditProfileApiCall()
    {
        SVProgressHUD.show()
        
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let para = ["user_id" : USERID,
                    "company_name":companyNameTF.text!,
                    "user_fname":contactPersonTF.text!,
                    "user_mobile":contactNoTF.text!,
                    "user_email":emailTF.text!,
                    "user_password":passwordTF.text!,
                   // "co_registeration_id_password":coRegisterTF.text!,
                   // "bee_number":beeLevelTF.text!,
                    "gender":GenderTF.text!,
                    "race":RaceTF.text!]   as? [String : String]
        
        print(para!)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if self.choosenImage != nil
            {
                
                multipartFormData.append(UIImageJPEGRepresentation(self.choosenImage, 0.6)!, withName: "pro_images", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                
                
            }
            for (key, value) in para!
            {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:"http://a1professionals.net/blackbusiness/api/upd_Business_User")
        { (result) in
            switch result {
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
                            let alert = UIAlertController(title: "Alert", message: "Failure", preferredStyle: .alert)
                            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                            alert.addAction(submitAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                            
                        else if (JSON.value(forKey: "code") as!String == "201")
                        {
                            SVProgressHUD.dismiss()
                            
                        if let img = JSON["user_profile_image"] as? String
                            {
                        let finalImage = imageBaseURL + img
                        let url = URL(string: finalImage)
                                
                        self.imageView.sd_setShowActivityIndicatorView(true)
                        self.imageView.sd_setIndicatorStyle(.gray)
                                
                                self.imageView.sd_setImage(with: url, placeholderImage: nil, options: .progressiveDownload, completed: nil)
                                
                            }
                            else
                            {
                                self.imageView.image = UIImage(named: "rectImage")
                            }
                            
                            
                            let company_name = ((JSON as! NSDictionary).value(forKey: "data") as! NSDictionary).value(forKey: "company_name") as! String
                            
                             DEFAULT.set(company_name, forKey: "company_name")
                            
                            let v = self.storyboard?.instantiateViewController(withIdentifier: "BusinessHomeViewController") as? BusinessHomeViewController
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
} // Class Close
