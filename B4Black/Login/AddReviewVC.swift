//
//  AddReviewVC.swift
//  B4Black
//
//  Created by administrator on 24/07/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddReviewVC: UIViewController {
    
    @IBOutlet weak var floatRateImg: FloatRatingView!
    @IBOutlet weak var TypeReview: UITextView!
    var busniessID = ""
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TypeReview.layer.cornerRadius = 8
        TypeReview.layer.borderColor = UIColor.lightGray.cgColor
        TypeReview.layer.borderWidth = 1
        
    }
    
    @IBAction func SubmitAct(_ sender: UIButton)
    {
        if floatRateImg.rating == 0.0
        {
            let alertController = UIAlertController(title: "Alert", message: "Please add Rating", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)  {(action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else if TypeReview.text == ""
        {
           
            let alertController = UIAlertController(title: "Alert", message: "Please type your Review.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)  {(action:UIAlertAction!) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
        }
        else
        {
          self.RatingFeedbackApi()
        }
        
    }
    @IBAction func GoBack(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    ///////   FeedBack APi
    
    func RatingFeedbackApi()
    {
        
        SVProgressHUD.show()
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        var userType = "2"
        if let str = DEFAULT.value(forKey: "BUSINESS") as? String
        {
            userType = str
        }
        let params = ["user_id" : USERID,
                      "user_type" : userType,
                      "business_id" : busniessID,
                      "review_description" : TypeReview.text!,
                      "review_star_rating" : "\(floatRateImg.rating)"] as [String : Any]
        
        print(params)
        
        ApiHandler.callApiWithParameters(url: addReviewCustomerSideURL, withParameters: params as [String : AnyObject] ,success:
            {
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
                    let alertController = UIAlertController(title: "Notification", message: "Your review is added successfully", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .default)
                    {
                        (action:UIAlertAction!) in
                    }
                    alertController.addAction(OKAction)
                    self.navigationController?.popToRootViewController(animated: true)
                    self.present(alertController, animated: true, completion:nil)
                    
                }
                }
                , failure:
                {
                string in
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "", message: string, preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in})
                alert.addAction(submitAction)
                self.present(alert, animated: true, completion: nil)
                print(string)
        }, method: .POST, img: nil, imageParamater: "", headers: [ : ])
        
    }
}
    
    
    
    
    

