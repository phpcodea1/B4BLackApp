//
//  AddBusinessVC.swift
//  B4Blackt
//
//  Created by eWeb on 21/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MapKit
import Photos
import ALCameraViewController
import Foundation
import SVProgressHUD
import KYDrawerController

class AddBusinessVC: UIViewController,UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UITextViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var coRegisterIdTF: UITextField!
    @IBOutlet weak var beeLevelTf: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerUi: UIView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var fifthImage: UIImageView!
    @IBOutlet weak var businessName: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var faceBookTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var placeAdvertTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addservicesTextField: UITextField!
    @IBOutlet weak var addVedioTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveOut: UIButton!
    @IBOutlet weak var usercollectionview: UICollectionView!
    @IBOutlet weak var greyPopupView: UIView!
    @IBOutlet weak var countingLabel: UILabel!
    
    
    var selectCAtgryArray = NSArray()
    var selectCatgryDict = NSDictionary()
    var dataDict = NSDictionary()
    var categoryArray = ["Select Category","Fashions","Foods","Resturent","Category"]
    var selectdCategory = ""
    var imageMutableArray = NSMutableArray()
    var img = ""
    var getVideo = "no"
    var fromeditProfile = "no"
    var busnesID = ""
    var fromEditBusnsID = ""
    var immgID = ""
    var currentArray = [String]()
    var latitudee = Double()
    var longituee = Double()
    var dataArray = NSArray()
    var cat_name = ""
    var cat_id = ""
    var recivingArray = NSArray()
    let manager = CLLocationManager()
   
    /// ImageEditing
    let imagePickerViewController = PhotoLibraryViewController()
    var libraryEnabled:Bool = true
    var croppingEnabled: Bool = true
    var allowResizing: Bool = true
    var allowMoving:Bool = true
    var choosenImage:UIImage!
    var imagePicker: UIImagePickerController!
    var minimumSize: CGSize = CGSize(width: 60, height: 60)
    
    var croppingPerameters: CroppingParameters
    {
        return CroppingParameters(isEnabled: true, allowResizing: allowResizing, allowMoving: allowMoving, minimumSize: minimumSize)
    }

    //  LOCATION EDITING
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let _ :CLLocation = locations[0] as CLLocation
        
        if let lastLocation = locations.last
        {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(lastLocation) { [weak self] (placemarks, error) in
                if error == nil
                {
                    if let firstLocation = placemarks?[0],
                        let cityName1 = firstLocation.locality,   // locality
                        let stateName1 = firstLocation.subLocality,
                        let nationality1 = firstLocation.administrativeArea,
                        let country1 = firstLocation.country,
                        var latitude = firstLocation.location?.coordinate.latitude,
                        var longitude = firstLocation.location?.coordinate.longitude
                    {
                        print(firstLocation)
                        print(cityName1 + stateName1 + nationality1 + country1)
                        print(latitude)
                        print(longitude)
                        self?.latitudee = latitude
                        self?.longituee = longitude
                        /*
                        self?.cityName = cityName1
                        self?.stateName = stateName1
                        self?.nationality = nationality1
                        self?.country = country1
                        var address = stateName1 + ", " + cityName1 + ", " + nationality1 + ", " + country1
                        //    var LatLongValue = Optional(<+30.70460000,+76.71790000>
                        self?.CompanyLocationTF.text = address
                         */
                        self?.manager.stopUpdatingLocation()
                    }
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        selectCAtegoryAPI()
        descriptionTextView.delegate = self
        self.updateCharacterCount()
        greyPopupView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
       
        if imageMutableArray.count>0
        {
            imageMutableArray.removeAllObjects()
        }
        
        
        saveOut.layer.cornerRadius = 20
        // For first Image
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1))
        tap1.delegate = self // This is not required
        firstImage.addGestureRecognizer(tap1)
        firstImage.isUserInteractionEnabled = true
      //  imagePicker.delegate = self
        firstImage.contentMode = UIViewContentMode.scaleAspectFill
        firstImage.clipsToBounds = true
  //      self.firstImage.layer.cornerRadius = 35
        // For second Image
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2))
        tap2.delegate = self // This is not required
        secondImage.addGestureRecognizer(tap2)
        secondImage.isUserInteractionEnabled = true
        secondImage.contentMode = UIViewContentMode.scaleAspectFill
        secondImage.clipsToBounds = true
     //   self.secondImage.layer.cornerRadius = 35
        // For Third Image
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap3))
        tap3.delegate = self // This is not required
        thirdImage.addGestureRecognizer(tap3)
        thirdImage.isUserInteractionEnabled = true
        thirdImage.contentMode = UIViewContentMode.scaleAspectFill
        thirdImage.clipsToBounds = true
       //  self.thirdImage.layer.cornerRadius = 35
        // For Fourth Image
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap4))
        tap4.delegate = self // This is not required
        fourthImage.addGestureRecognizer(tap4)
        fourthImage.isUserInteractionEnabled = true
        fourthImage.contentMode = UIViewContentMode.scaleAspectFill
        fourthImage.clipsToBounds = true
      //  self.fourthImage.layer.cornerRadius = 35
        // For Fifth Image
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap5))
        tap5.delegate = self // This is not required
        fifthImage.addGestureRecognizer(tap5)
        fifthImage.isUserInteractionEnabled = true
        fifthImage.contentMode = UIViewContentMode.scaleAspectFill
        fifthImage.clipsToBounds = true
        // self.fifthImage.layer.cornerRadius = 35
        // busnesID = ((recivingArray as NSArray).object(at: 0) as! NSDictionary).value(forKey: "business_id") as! String
        //print(busnesID)
        
        if recivingArray.count>0
        {
            if let dict = ((recivingArray).object(at: 0) as? NSDictionary)
            {
                if let imgArray = dict.value(forKey: "business_images") as? NSArray
                {
                    print(imgArray)
                    
                    for i in 0..<imgArray.count
                    {
                        
                        if  let picone = ((imgArray).object(at: i) as! NSDictionary).value(forKey: "image_path") as? String
                        {
                            if i == 0
                            {
                                firstImage.sd_setShowActivityIndicatorView(true)
                                firstImage.sd_setIndicatorStyle(.gray)
                                let url1 = URL(string: picone)
                                firstImage.sd_setImage(with: url1, placeholderImage: nil, options: .refreshCached, completed: nil)
                                
                            }
                            if i == 1
                            {
                                secondImage.sd_setShowActivityIndicatorView(true)
                                secondImage.sd_setIndicatorStyle(.gray)
                                let url1 = URL(string: picone)
                                secondImage.sd_setImage(with: url1, placeholderImage: nil, options: .refreshCached,  completed: nil)
                                
                            }
                            if i == 2
                            {
                                thirdImage.sd_setShowActivityIndicatorView(true)
                                thirdImage.sd_setIndicatorStyle(.gray)
                                let url1 = URL(string: picone)
                                thirdImage.sd_setImage(with: url1, placeholderImage: nil, options: .refreshCached, completed: nil)
                                
                            }
                            if i == 3
                            {
                                fourthImage.sd_setShowActivityIndicatorView(true)
                                fourthImage.sd_setIndicatorStyle(.gray)
                                let url1 = URL(string: picone)
                                fourthImage.sd_setImage(with: url1, placeholderImage: nil, options: .refreshCached, completed: nil)
                                
                            }
                            if i == 4
                            {
                                fifthImage.sd_setShowActivityIndicatorView(true)
                                fifthImage.sd_setIndicatorStyle(.gray)
                                let url1 = URL(string: picone)
                                fifthImage.sd_setImage(with: url1, placeholderImage: nil, options: .refreshCached, completed: nil)
                                
                            }
                        }
                        
                    }
                    
                }
                if let business_name = dict.value(forKey: "business_name") as? String
                {
                    businessName.text = business_name
                }
                let editBusinessID = fromEditBusnsID
                
                print(editBusinessID)
                
                if let business_communication_mobile = dict.value(forKey: "business_communication_mobile") as? String
                {
                    phoneNumberTextField.text = business_communication_mobile
                }
                if let business_facebook = dict.value(forKey: "business_facebook") as? String
                {
                    faceBookTextField.text = business_facebook
                }
                if let business_location = dict.value(forKey: "business_location") as? String
                {
                    locationTextField.text = business_location
                }
                if let business_description = dict.value(forKey: "business_description") as? String
                {
                    descriptionTextView.text = business_description
                }
                if let business_website = dict.value(forKey: "business_website") as? String
                {
                    websiteTextField.text = business_website
                }
                if let business_place_advertisment = dict.value(forKey: "business_place_advertisment") as? String
                {
                    placeAdvertTextField.text = business_place_advertisment
                }
                if let business_instagram = dict.value(forKey: "business_instagram") as? String
                {
                    instagramTextField.text = business_instagram
                }
                if let business_communication_email = dict.value(forKey: "business_communication_email") as? String
                {
                    emailTextField.text = business_communication_email
                }
                if let BeeeLevel = dict.value(forKey: "business_bee_number") as? String
                {
                    beeLevelTf.text = BeeeLevel
                }
                if let coRegisterId = dict.value(forKey: "business_co_registeration_id_password") as? String
                {
                    coRegisterIdTF.text = coRegisterId
                }
                if let AddVideo = dict.value(forKey: "business_video") as? String
                {
                    addVedioTextField.text = AddVideo
                }
            }
        }
        print("recivingArray = ", recivingArray)
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    /////////       SELECT CATEGORY
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
         return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.dataArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
       // selectdCategory = currentArray[row]
        self.dataDict = dataArray.object(at: row) as! NSDictionary
        cat_name = dataDict.value(forKey: "cat_name") as! String
        cat_id = dataDict.value(forKey: "cat_id") as! String
        print(cat_id)
 
        if cat_name == "Select Category"
        {
            if fromeditProfile == "no"
            {
               self.addservicesTextField.text = ""
            }
          
        }
        else
        {
            self.addservicesTextField.text = cat_name
        }
        return cat_name
        
    }
    
    @IBAction func PickerCancel(_ sender: UIButton)
    {
        self.addservicesTextField.text = ""
        greyPopupView.isHidden = true
    }
    @IBAction func pickerDone(_ sender: Any)
    {
        greyPopupView.isHidden = true
        self.selectCAtegoryAPI()
        
    }
    
    /////////////////////////           FOR ABOUT ME FIELD
    
    func updateCharacterCount()
    {
        let summaryCount = self.descriptionTextView.text.characters.count
        self.countingLabel.text = "\((0) + summaryCount)/50"
        self.countingLabel.text = "\((0) + summaryCount)/250"
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        
        self.updateCharacterCount()
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(textView == descriptionTextView)
        {
            return textView.text.characters.count +  (text.characters.count - range.length) <= 250
        }
        else if(textView == descriptionTextView)
        {
            return textView.text.characters.count +  (text.characters.count - range.length) <= 500
        }
        return false
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        var textView = descriptionTextView.text
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
      
        firstImage.layer.cornerRadius = firstImage.frame.size.height/2
        firstImage.clipsToBounds = true
        secondImage.layer.cornerRadius = secondImage.frame.size.height/2
        secondImage.clipsToBounds = true
        thirdImage.layer.cornerRadius = thirdImage.frame.size.height/2
        thirdImage.clipsToBounds = true
        fourthImage.layer.cornerRadius = fourthImage.frame.size.height/2
        fourthImage.clipsToBounds = true
        fifthImage.layer.cornerRadius = fifthImage.frame.size.height/2
        fifthImage.clipsToBounds = true
    
      //  self.selectCAtegoryAPI()
        
    }
    
    // IMAGE HANDLING ACTION
    
    @objc func handleTap1()
    {
        // 1 Select Image For Collection View
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera1()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary1()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera1()
    {
        
        
        let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.firstImage.image = image
            self?.choosenImage = image
            self?.img = "1"
           // self?.imageMutableArray.add(self?.choosenImage)
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
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
            img = "1"
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
         */
    }
   
    func openGallary1()
    {
        /*
        imagePickerViewController.onSelectionComplete = { asset in
            
            // The asset could be nil if the user doesn't select anything
            guard let asset = asset else
            {
                return
            }
            
            // Provides a PHAsset object
            // Retrieve a UIImage from a PHAsset using
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { image, _ in
                if let image = image
                {
                    // Do something with your image here
                    let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: self.croppingPerameters) { [weak self] image, assest in
                        self!.firstImage.image = image
                        self?.choosenImage = image
                        self?.img = "1"
                        if self!.choosenImage != nil
                        {
                            self!.imageMutableArray.add(self!.choosenImage)
                        }
                        //  self?.imageMutableArray.add(self?.choosenImage)
                        self!.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
        present(imagePickerViewController, animated: true, completion: nil)
 */
        
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.firstImage.image = image
            self?.choosenImage = image
            self?.img = "1"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
          //  self?.imageMutableArray.add(self?.choosenImage)
            self!.dismiss(animated: true, completion: nil)
     }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        img = "1"
        imagePicker.delegate = self
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
         */
 
 
 
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
      
        if getVideo == "no"
        {
            
            if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
            {
            
                if img == "1"
                {
                    firstImage.image = choosenImage
                    firstImage.layer.cornerRadius = firstImage.frame.size.height/2
                    firstImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "2"
                {
                    secondImage.image = choosenImage
                    secondImage.layer.cornerRadius = secondImage.frame.size.height/2
                    secondImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "3"
                {
                    thirdImage.image = choosenImage
                    thirdImage.layer.cornerRadius = thirdImage.frame.size.height/2
                    thirdImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "4"
                {
                    fourthImage.image = choosenImage
                    fourthImage.layer.cornerRadius = fourthImage.frame.size.height/2
                    fourthImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "5"
                {
                    fifthImage.image = choosenImage
                    fifthImage.layer.cornerRadius = fifthImage.frame.size.height/2
                    fifthImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
            
            }
            else if let choosenImage = info[UIImagePickerControllerEditedImage] as? UIImage
            {
                
                if img == "1"
                {
                    firstImage.image = choosenImage
                    firstImage.layer.cornerRadius = firstImage.frame.size.height/2
                    firstImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "2"
                {
                    secondImage.image = choosenImage
                    secondImage.layer.cornerRadius = secondImage.frame.size.height/2
                    secondImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "3"
                {
                    thirdImage.image = choosenImage
                    thirdImage.layer.cornerRadius = thirdImage.frame.size.height/2
                    thirdImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "4"
                {
                    fourthImage.image = choosenImage
                    fourthImage.layer.cornerRadius = fourthImage.frame.size.height/2
                    fourthImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
                else if img == "5"
                {
                    fifthImage.image = choosenImage
                    fifthImage.layer.cornerRadius = fifthImage.frame.size.height/2
                    fifthImage.clipsToBounds = true
                    imageMutableArray.add(choosenImage)
                }
            }
            print(imageMutableArray)
            picker.dismiss(animated: true, completion: nil)
        }
        else
        {
            
            //          let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
            print(info)
            addVedioTextField.text = "\(info["UIImagePickerControllerMediaURL"])"
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    // 2. Image
    
    @objc func handleTap2()
    {
        // Select Image For Collection View
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera2()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary2()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera2()
    {
       let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.secondImage.image = image
            self?.choosenImage = image
            self?.img = "2"
            if self!.choosenImage != nil
            {
            self!.imageMutableArray.add(self!.choosenImage)
            }
           // self?.imageMutableArray.add(self?.choosenImage)
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
            img = "2"
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
        */
    }
    
    func openGallary2()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.secondImage.image = image
            self?.choosenImage = image
            self?.img = "2"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
            //self?.imageMutableArray.add(self?.choosenImage)
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        img = "2"
        self.present(imagePicker, animated: true, completion: nil)
         */
    }
    
    // 3. Image
    
    @objc func handleTap3()
    {
        // Select Image For Collection View
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera3()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary3()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera3()
    {
       let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.thirdImage.image = image
            self?.choosenImage = image
            self?.img = "3"
            if self!.choosenImage != nil
            {
            self!.imageMutableArray.add(self!.choosenImage)
            }
           // self?.imageMutableArray.add(self?.choosenImage)
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
            img = "3"
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
         */
    }
    
    func openGallary3()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.thirdImage.image = image
            self?.choosenImage = image
            self?.img = "3"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
           // self?.imageMutableArray.add(self?.choosenImage)
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        img = "3"
        self.present(imagePicker, animated: true, completion: nil)
        */
    }
    
    
    // 4. Image
    
    @objc func handleTap4()
    {
        // Select Image For Collection View
        
        var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera4()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary4()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera4()
    {
        
        let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.fourthImage.image = image
            self?.choosenImage = image
            self?.img = "4"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
            //self?.imageMutableArray.add(self?.choosenImage)
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
            img = "4"
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
         */
    }
    
    func openGallary4()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.fourthImage.image = image
            self?.choosenImage = image
            self?.img = "4"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
            //self?.imageMutableArray.add(self?.choosenImage)
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        img = "4"
        self.present(imagePicker, animated: true, completion: nil)
        */
    }
    
    // 4. Image
    
    @objc func handleTap5()
    {
        // Select Image For Collection View
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera5()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary5()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera5()
    {
        
        
        let cameraViewController = CameraViewController(croppingParameters: croppingPerameters, allowsLibraryAccess: libraryEnabled) { [weak self] image, assest in
            self!.fifthImage.image = image
            self?.choosenImage = image
            self?.img = "5"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
            //self?.imageMutableArray.add(self?.choosenImage)
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
            img = "5"
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alertWarning = UIAlertView(title:"Alert!", message: "You don't have camera", delegate:nil, cancelButtonTitle:"Ok")
            alertWarning.show()
        }
        */
    }
    
    func openGallary5()
    {
        let libraryViewController = CameraViewController.imagePickerViewController(croppingParameters: croppingPerameters) { [weak self] image, assest in
            self!.fifthImage.image = image
            self?.choosenImage = image
            self?.img = "5"
            if self!.choosenImage != nil
            {
                self!.imageMutableArray.add(self!.choosenImage)
            }
           // self?.imageMutableArray.add(self?.choosenImage)
            self!.dismiss(animated: true, completion: nil)
        }
        present(libraryViewController,animated: true, completion:  nil)
        /*
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        img = "5"
        self.present(imagePicker, animated: true, completion: nil)
         */
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func VideoBtnAct(_ sender: UIButton)
    {
        getVideo = "yes"
        let imagePickerController = UIImagePickerController ()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func SelectCategory(_ sender: UIButton)
    {
        greyPopupView.isHidden = false
    }
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
                self.pickerView.reloadAllComponents()
            }
        }, failure: {
            string in
             SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Alert", message: "JSON", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }, method: .GET, img: nil, imageParamater: "", headers: [ : ])
        
    }
    @IBAction func BeeLevelBtnAct(_ sender: UIButton)
    {
      
        let optionMenuController = UIAlertController(title: nil, message: "Choose your BEE Level for your Business Profile", preferredStyle: .actionSheet)
        
        let Affidavit = UIAlertAction(title: "Affidavit", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.beeLevelTf.text = "Affidavit"
            print("File has been Add")
        })
        let level1 = UIAlertAction(title: "Level 1", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.beeLevelTf.text = "Level 1"
            print("File has been Add")
        })
        let level2 = UIAlertAction(title: "Level 2", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.beeLevelTf.text = "Level 2"
            print("File has been Add")
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(Affidavit)
        optionMenuController.addAction(level1)
        optionMenuController.addAction(level2)
        optionMenuController.addAction(cancel)
        
        self.present(optionMenuController, animated: true, completion: nil)
        
        
    }
    @IBAction func SaveBtnAct(_ sender: UIButton)
    {
        if businessName.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Business Name field is required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if phoneNumberTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Contact Number field is required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if emailTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Email field is must required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        /*
        else if instagramTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Instagram field is Required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if faceBookTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Facebook field is required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
      else if websiteTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Website field is required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        } */
        else if placeAdvertTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Place field is must Required", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if locationTextField.text == ""
        {
            
            let alert = UIAlertController(title: "Alert", message: "Please set your location ", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if addservicesTextField.text == ""
        {

            let alert = UIAlertController(title: "Alert", message: "Please select your category service", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if descriptionTextView.text == ""
        {
            let alert = UIAlertController(title: "Alert", message: "Please write description of your Business", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if beeLevelTf.text == ""
        {
            let alert = UIAlertController(title: "Alert", message: "Please type your BEEE Level in the field", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if coRegisterIdTF.text == ""
        {
            let alert = UIAlertController(title: "Alert", message: "Please type your Co registration/ID/passport in the field", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if firstImage.image == UIImage(named: "Untitled-13_0004_") || secondImage.image == UIImage(named: "Untitled-13_0004_") || thirdImage.image == UIImage(named: "Untitled-13_0004_") || fourthImage.image == UIImage(named: "Untitled-13_0004_") || fifthImage.image == UIImage(named: "Untitled-13_0004_")
        {
            let alert = UIAlertController(title: "Alert", message: "Please choose Image for your Business", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            if fromeditProfile == "yes"
            {
                self.EditBusinessApiCall1()
            }
            else
            {
                self.AddBusinessApiCall()
            }
        }
    }
    
    /////////////////    new add business
    
    func AddBusinessApiCall()
    {
        
        SVProgressHUD.show()
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        var businessid = "66"
        if let business_id = DEFAULT.value(forKey: "BusinessId") as? String
        {
            businessid = business_id
        }
        SVProgressHUD.show()
        
        let para =  ["user_id": USERID,
                     "business_name": businessName.text!,
                     "business_description": descriptionTextView.text!,
                     "business_category_id": cat_id,
                     "business_location": locationTextField.text!,
                     "business_location_lat": "\(latitudee)",
                     "business_location_lng": "\(longituee)",
                     "business_communication_mobile":  phoneNumberTextField.text!,
                     "business_place_advertisments": placeAdvertTextField.text!,
                     "business_website": websiteTextField.text!,
                     "business_communication_email": emailTextField.text!,
                     "business_facebook": faceBookTextField.text!,
                     "business_instagram": instagramTextField.text!,
                     "business_bee_number" : beeLevelTf.text!,
                     "business_co_registeration_id_password" : coRegisterIdTF.text!,
                     "businessvideo": ""] as! [String : String]
        
            print(para)
            SVProgressHUD.show()
        
            Alamofire.upload(multipartFormData:
            {        (multipartFormData) in
                for i in 0..<self.imageMutableArray.count
            {
                multipartFormData.append(UIImageJPEGRepresentation(self.imageMutableArray.object(at: i) as! UIImage, 0.6)!, withName: "businessImages[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            for (key, value) in para
            {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:"http://a1professionals.net/blackbusiness/api/Business/BusinessProfile")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    
                })
                
                upload.responseJSON { response in
                    
                    print(response)
                    print(response.result.value)
                    
                if let JSON = response.result.value as? NSDictionary  // Crashing bcz NIL
                    {

                        print(JSON)
                        if(JSON.value(forKey: "code") as!String == "200")
                        {
                            SVProgressHUD.dismiss()

                            let alert = UIAlertController(title: "Alert", message: JSON.value(forKey: "message") as?String, preferredStyle: .alert)
                            let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                            alert.addAction(submitAction)
                            self.present(alert, animated: true, completion: nil)

                        }
                        else if (JSON.value(forKey: "code") as!String == "201")
                        {

                            SVProgressHUD.dismiss()

                            let v = self.storyboard?.instantiateViewController(withIdentifier: "BusinessHomeViewController") as? BusinessHomeViewController
                            self.navigationController?.pushViewController(v!, animated: true)

                        }
                        SVProgressHUD.dismiss()
                    }
                else{
                    
                     SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Alert", message: "Something went wrong. Please check your internet connection", preferredStyle: .alert)
                    let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                    alert.addAction(submitAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    }
                    
                }
                
            break
            case .failure(let encodingError):
            print(encodingError)
            break
            }
        }
    }
    
     //// EDIT
     
     func EditBusinessApiCall1()
     {
     
     SVProgressHUD.show()
     var USERID = "66"
     if  let id = DEFAULT.value(forKey: "USERID") as? String
     {
     USERID = id
     }
     let para = ["user_id": USERID,
                 "business_id":fromEditBusnsID,
                 "business_name":businessName.text!,
                 "business_description":descriptionTextView.text!,
                 "business_category_id": cat_id,
                 "business_location":locationTextField.text!,
                 "business_location_lat": "\(latitudee)",
                 "business_location_lng": "\(longituee)",
                 "business_communication_mobile":phoneNumberTextField.text!,
                 "business_place_advertisments":placeAdvertTextField.text!,
                 "business_website":websiteTextField.text!,
                 "business_communication_email":emailTextField.text!,
                 "business_facebook":faceBookTextField.text!,
                 "business_instagram":instagramTextField.text!,
                 "business_image_id":immgID,
                 "business_bee_number" : beeLevelTf.text!,
                 "business_co_registeration_id_password" : coRegisterIdTF.text!,
                 "businessvideo":""] as! [String : String]
     
     print(para)
     
     SVProgressHUD.show()
     
     Alamofire.upload(multipartFormData: { (multipartFormData) in
     
     for i in 0..<self.imageMutableArray.count
     {
        
       multipartFormData.append(UIImageJPEGRepresentation(self.imageMutableArray.object(at: i) as! UIImage, 0.6)!, withName: "businessImages[]", fileName: "file.jpg", mimeType:"jpg/png/jpeg")
       multipartFormData.append(UIImageJPEGRepresentation(self.imageMutableArray.object(at: i) as! UIImage, 0.6)!, withName: "business_image_update[]", fileName: "file.jpg", mimeType:"jpg/png/jpeg")
        
     }
     for (key, value) in para
     {
     print(para)
     multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
     }
     print(para)
    },
     
     usingThreshold: UInt64.init(), to: EditBusinessURL, method: .post) { (result) in
     switch result
     {
        case .success(let upload, _, _):
        
        upload.uploadProgress(closure: { (progress) in
        
        })
        
        upload.responseJSON { response in
        
        print(response)
        print(response.result.value)
        
        if let JSON = response.result.value as? NSDictionary  // Crashing bcz NIL
        {
        
        print(JSON)
        if(JSON.value(forKey: "code") as!String == "200")
        {
        SVProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Alert", message: JSON.value(forKey: "message") as?String, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)
        
        }
        else if (JSON.value(forKey: "code") as!String == "201")
        {
        
        SVProgressHUD.dismiss()
        
        let v = self.storyboard?.instantiateViewController(withIdentifier: "BusinessHomeViewController") as? BusinessHomeViewController
        self.navigationController?.pushViewController(v!, animated: true)
        
        
        }
        SVProgressHUD.dismiss()
        }
        else
        {
        SVProgressHUD.dismiss()
        let alert = UIAlertController(title: "Alert", message: "Something went wrong. Please check your internet connection", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)
        }
      }
        break
        case .failure(let encodingError):
        print(encodingError)
        break
        }
     }
     }
     }

