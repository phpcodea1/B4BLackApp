//
//  ChatListVC.swift
//  B4Black
//
//  Created by eWeb on 20/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseCore
import FirebaseDatabase
import JSQMessagesViewController
import KYDrawerController
import SVProgressHUD
import KYDrawerController

class ChatListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate
    {
  
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var blurview: UIView!
    
    var ToDeleteUserId = ""
    var activityIndicator: UIActivityIndicatorView!
    var customView = UIView()
    var chatDB: DatabaseReference!
    var searchedArray = NSMutableArray()
    var arrayToBeSearched = NSMutableArray()
    var chatListArray = NSMutableArray()
    var refreshControl = UIRefreshControl()
    var chatList = NSMutableArray()
    var newMessageRefHandle: DatabaseHandle?
    var updatedMessageRefHandle: DatabaseHandle?
    var newMessageRefHandle2: DatabaseHandle?
    var updatedMessageRefHandle2: DatabaseHandle?
    var searchTextType = ""
    var ref: DatabaseReference!
    var messages = [JSQMessage]()
    var lastMessageArray = NSMutableArray()
    var allData = NSMutableArray()
    var userId = DEFAULT.value(forKey: "USERID") as? String
    var messageArray = NSMutableArray()
    var sendImgUrl = URL(string: "")
    var valueForCell = NSMutableDictionary()
    var CountValueInMessages = NSMutableDictionary()
    var UsrName = ""
    var UsrImg = ""
    var UsrId = ""
    // For Header Of The Cell
    var value = ""
    var sectionName = NSMutableArray()
    var IdForDidSelect = ""
    var NameOfBusiness = ""
    var allBusinessKeyArray = NSMutableArray()
    var finalListArray = NSMutableArray()
    var sendImage = ""
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // blurview.isHidden = true
        userId = DEFAULT.value(forKey: "USERID") as? String
        swipeToPop()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 100, height: CGFloat(100))
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.isHidden = true
        activityIndicator.center = view.center;
        self.view.addSubview(activityIndicator)
        self.chatDB = Database.database().reference()
      }
    /*
    @discardableResult
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.clear//.init(netHex: 0xFFFFFF)
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.black
        viewBackgroundLoading.alpha = 1
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!
        {
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }
        else
        {
            for subview in viewContainer.subviews
            {
                if subview.tag == 789456123
                {
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }
     */
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.tabBarController?.tabBar.isHidden  = false
        let values = UserDefaults.standard
        if self.chatListArray.count>0
        {
            self.chatListArray.removeAllObjects()
            chatTable.reloadData()
            getAllMassage()
        }
        else
        {
        
          getAllMassage()
        }
        values.set("12", forKey: "backValue")
        
    }
    func UTCToLocal2(date:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
      return self.finalListArray.count
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as! ChatListTableViewCell
    
        
         cell1.Backview.layer.cornerRadius = 6
         cell1.Backview.layer.borderWidth = 2
         cell1.Backview.layer.borderColor = UIColor.lightGray.cgColor
        
        
         let dictMainArray = ((self.finalListArray.object(at: indexPath.row) as! NSDictionary).allValues) as NSArray

         if dictMainArray.count>0
         {
            if let fistDict = dictMainArray.object(at: 0) as? NSDictionary
            {
                if let from_user_name = fistDict.value(forKey: "from_user_name") as? String
                {
                     cell1.usernameTF.text = from_user_name
                }
                cell1.profileImg?.layer.cornerRadius = 22.5
              
                if let Img = (fistDict).value(forKey: "profile_image") as? String
                {
                    let url = URL(string: Img)
                    cell1.profileImg!.sd_setShowActivityIndicatorView(true)
                    cell1.profileImg!.sd_setIndicatorStyle(.gray)
                    cell1.profileImg!.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
                   
                }
                else
                {
                    cell1.profileImg?.image = UIImage(named: "BGProfile")
                }
                
            }
        }
        return cell1
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        if tableView.isEditing
        {
            return .none
        }
        
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//      return  80
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "DemoChatController") as! DemoChatController
        
        // CUSTOMER SIDE
        
      //  targetVc.dataFromChatList = dict
        print(chatListArray)
        
        let id =  ""
        let name = ""
        var img = ""
        targetVc.recieverId = id
        targetVc.recieverName = name
        var USERID = "66"
       
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        
        let userId = USERID
        targetVc.dict = CountValueInMessages as NSDictionary as! NSMutableDictionary
        
        let dictMainArray = ((self.finalListArray.object(at: indexPath.row) as! NSDictionary).allValues) as NSArray
        let dictMainArray2 = ((self.finalListArray.object(at: indexPath.row) as! NSDictionary).allKeys) as NSArray
        if dictMainArray.count>0
        {
            if let fistDict = dictMainArray.object(at: 0) as? NSDictionary
            {
                if let from_user_name = fistDict.value(forKey: "from_user_name") as? String
                {
                targetVc.B_nameFromList = from_user_name
                }
                if let to_user_id = fistDict.value(forKey: "to_user_id") as? String
                {
                    targetVc.B_IDFromList = to_user_id
                }
                if let Img = (fistDict).value(forKey: "profile_image") as? String
                {
                   
                   
                    targetVc.profileImageUrl = Img
                }
               
            }
        }
        if self.allBusinessKeyArray.count>0
        {
            
            let id = self.allBusinessKeyArray.object(at: indexPath.row) as! String
            
               targetVc.workingBusinesId = id
        }
        
        
        targetVc.fromChatList = "yes"
        self.navigationController?.pushViewController(targetVc, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell1 = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as! ChatListTableViewCell
//        let  dict = (((self.chatListArray.object(at: section) as! DataSnapshot).value) as! NSDictionary)
//        print(dict)
//
//
//        IdForDidSelect = (((((dict).allValues as NSArray).object(at: section) as! NSMutableDictionary).allValues as NSArray).object(at: 0) as! NSDictionary).value(forKey: "to_user_id") as! String
//
//        NameOfBusiness = (((((dict).allValues as NSArray).object(at: section) as! NSMutableDictionary).allValues as NSArray).object(at: 0) as! NSDictionary).value(forKey: "to_user_name") as! String
//
//
//
//        cell1.usernameTF.text = NameOfBusiness
//        return cell1
//    }
    func swipeToPop()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer
        {
            return true
        }
        return true
    }
    func deleteAlert()
    {
        let alert = UIAlertController.init(title: "Delete", message:"Are you sure want to delete chat?", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default)
        {
            UIAlertAction in
            
            let dbRef = self.chatDB.child("chat_data")
            dbRef.child(self.userId!+"_"+self.ToDeleteUserId)
            print(dbRef.child(self.userId!+"_"+self.ToDeleteUserId))
            print(dbRef.child(self.ToDeleteUserId+"_"+self.userId!))
            
        }
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: UIButton)
    {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
    }
    
    //--MARK:---refresh click-----
    
    func refresh()
    {
        chatTable.reloadData()
        refreshControl.endRefreshing()
        
    }
    func getAllMassage()
    {
        _ = NSMutableArray()
        let dbRef = Constants.refs.databaseChats
        
        if self.chatList.count>0
        {
            self.chatList.removeAllObjects()
            
        }
        if self.allData.count>0
        {
            self.allData.removeAllObjects()
            
        }
        
        _ = dbRef.observe(.childAdded, with: { [weak self] snapshot in
            print("snapshot in fist \(snapshot)")
            
            let key = (snapshot.key ).split(separator: "_")
            
            self?.chatList.add(key)
            self?.allData.add(snapshot)
            print("chatlist = \(String(describing: self?.chatList))")
            self?.filter()
            
            })
        
    }
    func filter()
    {
        if self.chatListArray.count>0
        {
            self.chatListArray.removeAllObjects()
        }
        if self.finalListArray.count>0
        {
            self.finalListArray.removeAllObjects()
        }
        if self.allBusinessKeyArray.count>0
        {
            self.allBusinessKeyArray.removeAllObjects()
        }
        for i in 0..<self.chatList.count
        {
            let subarray = self.chatList.object(at: i) as! NSArray
            
            if subarray.contains(userId)
            {
                if self.chatListArray.contains(self.allData.object(at: i))
                {
                    
                }
                else
                {
                    self.chatListArray.add(self.allData.object(at: i))
                   
                }
                
                SVProgressHUD.dismiss()
                
            }
            else
            {
                
            }
            
        }
        self.searchedArray = self.chatListArray
        self.arrayToBeSearched = self.chatListArray
        print("self.chatListArray = \(self.chatListArray)")
        
        for i in 0..<self.chatListArray.count
        {
         var dict = (((self.chatListArray.object(at: i) as! DataSnapshot).value) as! NSDictionary)
            var allKeys1 = dict.allKeys as! NSArray
            for j in 0..<allKeys1.count
            {
                self.allBusinessKeyArray.add(allKeys1.object(at: j))
                self.finalListArray.add(dict.value(forKey: allKeys1.object(at: j) as! String))
            }
            
        }
        if chatListArray.count > 0
        {
           // blurview.isHidden = true
        }
        else
        {
         // blurview.isHidden = false
            
            
        }
        
    self.chatTable.reloadData()
       
        
    }
    
    
    func dateDiff(dateStr:String) -> String
    {
        let f:DateFormatter = DateFormatter()
        f.timeZone = NSTimeZone.local
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = f.string(from: NSDate() as Date)
        let startDate = f.date(from: dateStr)
        let endDate = f.date(from: now)
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        
        let calendarUnits:NSCalendar.Unit = [.weekOfMonth,.day, .hour, .minute, .second]
        let dateComponents = calendar.components(calendarUnits, from: startDate!, to: endDate!, options: [])
        let weeks = abs(Int32(dateComponents.weekOfMonth!))
        let days = abs(Int32(dateComponents.day!))
        let hours = abs(Int32(dateComponents.hour!))
        let min = abs(Int32(dateComponents.minute!))
        let sec = abs(Int32(dateComponents.second!))
        
        var timeAgo = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        dateFormatter.dateFormat = "dd/MM/yy"
        let str =  dateFormatter.string(from: date!)
        
        
        let ln = Locale.preferredLanguages[0]
        if (ln == "el")
        {
            if (sec > 0)
            {
                if (sec > 1)
                {
                    timeAgo = "Μόλις τωρα"
                } else {
                    timeAgo = "Μόλις τωρα"
                }
            }
            
            if (min > 0){
                if (min > 1) {
                    timeAgo = "Πρίν " + "\(min)" + " λεπτό"
                } else {
                    timeAgo = "Πρίν " + "\(min)" + " λεπτό"
                }
            }
            
            if(hours > 0){
                if (hours > 1) {
                    timeAgo = "Πρίν "  + "\(hours) "+" ώρες"
                } else {
                    timeAgo = "Πρίν " + "\(hours) "+" ώρες"
                }
            }
            
            if (days > 0) {
                if (days > 1) {
                    timeAgo = "Πρίν " + "\(days)" + " μέρες"
                } else {
                    timeAgo = "Πρίν " + "\(days)" + " μέρες"
                }
                
            }
            
            if(weeks > 0){
                if (weeks > 1) {
                    timeAgo = "Πρίν " + "\(weeks)" + " εβδομάδα"
                }
                else
                {
                    // timeAgo = "Πρίν" + "\(weeks)" + " εβδομάδα"
                    timeAgo = str
                }
            }
        }
        else
        {
            if (sec > 0)
            {
                if (sec > 1)
                {
                    timeAgo = "\(sec) Seconds Ago"
                } else {
                    timeAgo = "\(sec) Second Ago"
                }
            }
            
            if (min > 0){
                if (min > 1) {
                    timeAgo = "\(min) Minutes Ago"
                } else {
                    timeAgo = "\(min) Minute Ago"
                }
            }
            
            if(hours > 0){
                if (hours > 1) {
                    timeAgo = "\(hours) Hours Ago"
                } else {
                    timeAgo = "\(hours) Hour Ago"
                }
            }
            
            if (days > 0) {
                if (days > 1) {
                    timeAgo = "\(days) Days Ago"
                } else {
                    timeAgo = "\(days) Day Ago"
                }
            }
            
            if(weeks > 0){
                if (weeks > 1) {
                    timeAgo = "\(weeks) Weeks Ago"
                } else {
                    timeAgo = str
                }
            }
        }
        
        print("massage date = \(str)")
        
        print("timeAgo is===> \(timeAgo)")
        return timeAgo;
    }

}
