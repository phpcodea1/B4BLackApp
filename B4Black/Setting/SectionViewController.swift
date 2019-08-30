//
//  SectionViewController.swift
//  B4Black
//
//  Created by eWeb on 27/08/19.
//  Copyright © 2019 eWeb. All rights reserved.
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


class SectionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate
{

    @IBOutlet weak var tab: UITableView!
    @IBOutlet weak var blurView: UIView!
    
    var detailCell =  ["1","2","3","4","5","6"]
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
    var headerCell = NSMutableArray()
    var haederData = ""
    var a = ""
    var sectionName = NSMutableArray()
    // For Cell
    var cellData = ""
    var rowDataDict = NSMutableDictionary()
    var key = NSArray()
    var MainSectionArray = NSMutableArray()
    var dataDict = NSMutableDictionary()
    var NAME = ""
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tab.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        if chatListArray.count != nil
        {
            blurView.isHidden = true
        }
        else
        {
            blurView.isHidden = false
        }
        swipeToPop()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 100, height: CGFloat(100))
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.isHidden = true
        activityIndicator.center = view.center;
        self.view.addSubview(activityIndicator)
        self.chatDB = Database.database().reference()
        getAllMassage()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.tabBarController?.tabBar.isHidden  = false
        let values = UserDefaults.standard
        
        if chatListArray.count != nil
        {
            blurView.isHidden = true
        }
        else
        {
            blurView.isHidden = false
        }
        swipeToPop()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
            UIActivityIndicatorViewStyle.gray)
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 100, height: CGFloat(100))
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.isHidden = true
        activityIndicator.center = view.center;
        self.view.addSubview(activityIndicator)
        self.chatDB = Database.database().reference()
        getAllMassage()
        
        
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
    func refresh()
    {
        tab.reloadData()
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
        if self.MainSectionArray.count>0
        {
            self.MainSectionArray.removeAllObjects()
        }
        
        for i in 0..<self.chatList.count
        {
            let subarray = self.chatList.object(at: i) as! NSArray
            
            if subarray.contains(userId!)
            {
                if self.chatListArray.contains(self.allData.object(at: i))
                {
                    
                }
                else
                {
                    self.chatListArray.add(self.allData.object(at: i))
                    sectionName = chatListArray
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
        MainSectionArray = chatListArray
        headerCell = chatListArray
        
        for i in 0..<self.chatListArray.count
        {
            haederData = ((chatListArray).object(at: i) as! DataSnapshot).key
            print(haederData)
            rowDataDict = ((chatListArray).object(at: i) as! DataSnapshot).value as! NSMutableDictionary
        }
        self.tab.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
         return chatListArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
//        let KEY = ((((chatListArray).object(at: indexPath.row) as! DataSnapshot).value as! NSMutableDictionary).allKeys as NSArray).object(at: indexPath.row) as! String
//
//       let VALUE =  (((((((chatListArray).object(at: indexPath.row) as! DataSnapshot).value as! NSMutableDictionary).allValues as! NSArray).object(at: 0) as! NSDictionary).allValues as! NSArray).object(at: 0) as! NSMutableDictionary).value(forKey: "to_user_name") as! String
        
        let val1 = ((chatListArray).object(at: indexPath.row) as! DataSnapshot).key
        cell.userName.text = val1
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
            return MainSectionArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.contentView.backgroundColor = UIColor.white
        cell.userName.textColor = UIColor.darkGray
        print(MainSectionArray)
        
        let allKeys = ((((MainSectionArray).object(at: section) as! DataSnapshot).value as! NSMutableDictionary).allKeys as NSArray)
        print(allKeys)
        if allKeys.count>0
        {
            cell.userName.text = "\(allKeys.object(at: 0))"
        }
        
        cell.userImage.image = UIImage(named: "profileImage")
        cell.userImage.backgroundColor = UIColor.clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "DemoChatController") as! DemoChatController
        targetVc.FetchDataFromChatList = chatListArray
        targetVc.heading = "a"
        targetVc.fromBusiensChatList = "yes"
        self.navigationController?.pushViewController(targetVc, animated: true)
        
    }
    
    //// Extra
    
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
                } else {
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
