//
//  NewPromotionViewController.swift
//  B4Black
//
//  Created by administrator on 11/05/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController

class NewPromotionViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet var popAdView: UIView!
    @IBOutlet var BAddView: UIView!
    @IBOutlet var browserAdHeight: NSLayoutConstraint!
    @IBOutlet var scrollviewHeght: NSLayoutConstraint!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var popAddHeght: NSLayoutConstraint!
    
    var imagePicker = UIImagePickerController()
    var choosenImage:UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        browserAdHeight.constant = 8
        BAddView.isHidden = true
        popAddHeght.constant = 8
        popAddHeght.constant = 850
        imagePicker.delegate = self
        popAdView.isHidden = true
        descTextView.layer.borderWidth = 1
        descTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBAction func browserAds(_ sender: UIButton)
    {
        if sender.isSelected == true{
            sender.isSelected = false
             BAddView.isHidden = true
            browserAdHeight.constant = 8
             popAddHeght.constant = 850
        }
        else
        {
            sender.isSelected = true
            browserAdHeight.constant = 128
             popAddHeght.constant = 950
            BAddView.isHidden = false
        }
    }
    @IBAction func BAOption(_ sender: UIButton)
    {
        if sender.isSelected == true
        {
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
        
    }
    @IBAction func PopupOption(_ sender: UIButton)
    {
        if sender.isSelected == true
        {
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
        
    }
    @IBAction func selctImage(_ sender: UIButton)
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
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func menuAction(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        choosenImage=info[UIImagePickerControllerOriginalImage] as? UIImage
      //  profilePic.image = choosenImage
       // profilePic.layer.cornerRadius = profilePic.frame.size.height/2
        picker.dismiss(animated: true, completion: nil)
      //  UpdateApiCall()
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func popUpAds(_ sender: UIButton)
    {
        if sender.isSelected == true{
            sender.isSelected = false
            popAddHeght.constant = 08
            popAdView.isHidden = true
        }
        else
        {
            sender.isSelected = true
            popAddHeght.constant = 128
            popAdView.isHidden = false
        }
    }
    
}
