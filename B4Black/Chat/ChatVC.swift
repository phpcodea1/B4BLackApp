//
//  ChatVC.swift
//  B4Black
//
//  Created by eWeb on 21/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatVC: UIViewController,UITableViewDataSource,UITableViewDelegate
{
     @IBOutlet var userSideTable: UITableView!
     @IBOutlet weak var chatView: UIView!
     @IBOutlet weak var textType: UITextView!
    
     override func viewDidLoad()
     {
        super.viewDidLoad()
        
       // clientCell
        
        textType.text = "Type your message"
        textType.textColor = UIColor.lightGray
        textType.layer.borderWidth = 0.0
        userSideTable.register(UINib(nibName:"userCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userSideTable.register(UINib(nibName:"clientCell", bundle: nil), forCellReuseIdentifier: "clientCell")
        
        
        
        //chatTable.register(UINib(nibName:"OtherUserMessage", bundle: nil), forCellReuseIdentifier: "OtherMessage")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       // userSideTable.rowHeight = UITableViewAutomaticDimension
       // userSideTable.estimatedRowHeight = 20
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        // self.navigationController?.isNavigationBarHidden = true
    IQKeyboardManager.shared.enable = false
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        IQKeyboardManager.shared.enable = true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
          //  print("Keyborad size \(keyboardSize.height)")
          //  self.bottomView.constant = -(keyboardSize.height+22)
            //self.sentBtnLy.constant = keyboardSize.height + 22
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification)
    {
        print("Keybord hide")
       // self.bottomView.constant = 0
        // self.sentBtnLy.constant = 22
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // self.uselLbl.text = name + " wants to send you a message."
     
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if(textView.contentSize.height > 35)
        {
            if(textView.contentSize.height > 80){
                //self.constraintHeight.constant = 80 - 35 + 52
            }
            else
            {
                //self.constraintHeight.constant = textView.contentSize.height - 35 + 52
            }
        }
        else{
           // self.constraintHeight.constant = 55
        }
        view.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        //        if (textView.text == "Type your message")
        //        {
        //            textView.text = ""
        //            textView.textColor = UIColor.black
        //        }
        //
        //         self.constraintHeight.constant = 400
        
        //        textView.contentSize.height = 100
        
        
        //        let numLines = (textView.contentSize.height / (textView.font?.lineHeight)!) as? Int
        //
        //        print("content size \(numLines)")
        //
        
        
//        if self.msgArray.count > 0
//        {
//            print(self.msgArray)
//            self.userSideTable.scrollToRow(at: IndexPath(item:self.msgArray.count-1, section: 0), at: .top, animated: true)
//        }
//
        
        if textType.textColor == UIColor.lightGray
        {
            textType.text = ""
            textType.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        // self.constraintHeight.constant = 64
        
        if (textView.text == "")
        {
            textView.text = "Type your message"
            textType.textColor = UIColor.lightGray
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
 
          if indexPath.row == 0
            {
               
           let cell1 = tableView.dequeueReusableCell(withIdentifier: "userCell")as! userCell
                    return cell1
            }
          else  if indexPath.row == 1
          {
            
              let cell1 = tableView.dequeueReusableCell(withIdentifier: "clientCell")as! clientCell
            return cell1
        }
          else  if indexPath.row == 2
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "userCell")as! userCell
            return cell1
          }
          else  if indexPath.row == 3
          {
            
              let cell1 = tableView.dequeueReusableCell(withIdentifier: "clientCell")as! clientCell
            return cell1
          }
            
            
          else  if indexPath.row == 4
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "userCell")as! userCell
            return cell1
          }
          else  if indexPath.row == 5
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "clientCell")as! clientCell
            return cell1
          }
            
          else  if indexPath.row == 6
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "userCell")as! userCell
            return cell1
          }
          else  if indexPath.row == 7
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "clientCell")as! clientCell
            return cell1
          }
         
        else
          {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "userCell")as! userCell
            return cell1
            
            return cell1
            }
        
        }
    
    
    
    @IBAction func back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
       // let elDrawer = navigationController?.parent as? KYDrawerController
      //  elDrawer?.setDrawerState(.opened, animated: true)
    }

}
