//
//  DemoChatController.swift
//  B4Black
//
//  Created by eWeb on 08/08/19.
//  Copyright © 2019 eWeb. All rights reserved.
//
// https://gist.github.com/frankgumeta/1367105d30a9e4476fe5


import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import CoreData
import SDWebImage
import FirebaseStorage
import FileProvider
import FirebaseDatabase
import FirebaseMessaging
import JSQMessagesViewController
import IQKeyboardManagerSwift

class DemoChatController:JSQMessagesViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate
{
    var recivingArrayFormChatList = NSDictionary()
    var fromChatList = "no"
    var messages = [JSQMessage]()
    var recieverId = ""
    var recieverName = ""
    var fromCamera = ""
    var firstMsgDate = "yes"
    var arrayDate = [String]()
    var choosenImage:UIImage! = nil
    var isImageChoosen = false
    var myBusinessId = ""
    var myBusinessNAME = ""
    var picker:UIImagePickerController?=UIImagePickerController()
    var allChatData = NSMutableArray()
    var userId = DEFAULT.value(forKey: "USERID") as! String
    var customView = UIView()
    var StatusView = UIView()
    var img = ""
    
    //   For Profile Image
    
    var FetchDataFromChatList = NSMutableArray()
    var dpURL = URL(string: "")
    var mahImg = ""
    var recieveImgUrl = ""
    var myDpImgg = URL(string: "")
    var BUSNES_User_ID = ""
    var RECIEVERID = ""
    var nameChatList = ""
    var ImgChatlist = ""
    var IdChatList = ""
    var dict = NSMutableDictionary()
    var heading = ""
    var customerListID = ""
    
    // CUSTOMER SIDE DATA
    
    var TheBusinesProfileArray = NSArray()
    var profileImage = ""
    var B_Name = ""
    var dataFromChatList = NSDictionary()
    var B_nameFromList = ""
    var B_IDFromList = ""
    var workingBusinesId = ""
    var profileImageUrl = ""
    
    // From Business ChatList Data
    
    var fromBusiensChatList = "no"
    var headingName = ""
    var headingImage = ""
    var BusinesIDFromChatList = ""
    var B_user_id = ""
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
            
    return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.init(red: 76/255.0, green: 106/255.0, blue: 219/255.0, alpha: 1))
        
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
            
     return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.init(red: 240/255.0, green: 242/255.0, blue: 244/255.0, alpha: 1))
        
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // FROM CUSTOMER
        print(dataFromChatList)
        if let myBusinessNAME1 = DEFAULT.value(forKey: "BUSNES_NAME") as? String
        {
        myBusinessNAME = myBusinessNAME1
        print(myBusinessNAME)
        }
        print(dataFromChatList)
        print(recivingArrayFormChatList)
        print(profileImage)
        print(TheBusinesProfileArray)
        //
        
        senderId = userId
        senderDisplayName = "dave"
        customView.frame = CGRect.init(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: 60)
        picker?.delegate = self
        StatusView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height)
        StatusView.backgroundColor = UIColor(red: 98/255.0, green: 196/255.0, blue: 195/255.0, alpha: 1)
        StatusView.layer.borderWidth = 1
        StatusView.layer.borderColor = UIColor(red: 88/255.0, green: 180/255.0, blue: 185/255.0, alpha: 1).cgColor
        self.view.addSubview(StatusView)
        let backBtn = UIButton()
        backBtn.frame = CGRect.init(x: 8, y: 18, width: 25, height: 25)
        backBtn.setImage(UIImage(named: "Goback"), for: .normal)
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        customView.addSubview(backBtn)
        
        let imageName = "clientProfile"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 45, y: 10, width: 40, height: 40)
        customView.addSubview(imageView)
       
        let label = UILabel(frame: CGRect(x: 95, y: 18, width: 200, height: 25))
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        customView.addSubview(label)
        customView.addSubview(backBtn)
        self.view.addSubview(customView)
       
        self.tabBarController?.tabBar.isHidden  = true
        customView.backgroundColor = UIColor(red: 98/255.0, green: 196/255.0, blue: 195/255.0, alpha: 1)
        
        inputToolbar.barStyle = .black
        print("inputToolbar.contentView.leftBarButtonItem.currentImage \(String(describing: inputToolbar.contentView.leftBarButtonItem.currentImage))")
        inputToolbar.contentView.leftBarButtonItem.imageView?.image = nil
        self.inputToolbar.contentView.backgroundColor = UIColor.black
        inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "plus-20"), for: .normal)
        inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "plus-20"), for: .focused)
        inputToolbar.contentView.leftBarButtonItem.setImage(UIImage(named: "plus-20"), for: .selected)
        inputToolbar.contentView.backgroundColor = UIColor.white
        inputToolbar.contentView.textView.layer.backgroundColor = UIColor.clear.cgColor
        inputToolbar.contentView.textView.backgroundColor = UIColor.white // CHATBACKCOLOR
        inputToolbar.contentView.textView.layer.cornerRadius = inputToolbar.contentView.textView.frame.height/2
        inputToolbar.contentView.rightBarButtonItem.setTitle("", for: .normal)
        inputToolbar.contentView.textView.isUserInteractionEnabled = true
        inputToolbar.contentView.textView.placeHolder = "  Message"
        inputToolbar.contentView.rightBarButtonItem.isEnabled = true
        inputToolbar.contentView.rightBarButtonItem.isHidden = false
        inputToolbar.contentView.rightBarButtonItem.isUserInteractionEnabled = true
        inputToolbar.contentView.leftBarButtonItem.isHidden = true
        inputToolbar.contentView.rightBarButtonItem.setImage(UIImage(named: "BGCamera"), for: .normal)
        inputToolbar.contentView.rightBarButtonItem.setImage(UIImage(named: "sendBtn"), for: .normal)
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        inputToolbar.contentView.textView.delegate = self
        inputToolbar.contentView.textView.addDoneOnKeyboardWithTarget(self, action: #selector(firstResponderAction), shouldShowPlaceholder: true)
        inputToolbar.contentView.textView.contentInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
      
        
        if fromChatList == "yes"
        {
              label.text = B_nameFromList
              print(profileImageUrl)
            
            if profileImageUrl != ""
            {
                let url = URL(string: profileImageUrl)
              
                imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
            }
           
              print(FetchDataFromChatList)
              print(customerListID)
              print(workingBusinesId)
        }
        else if fromBusiensChatList == "yes"
        {
            label.text = headingName
            print(BusinesIDFromChatList)
            print(B_user_id)
            if headingImage != ""
            {
                let url = URL(string: headingImage)
                
                imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
            }
        }
        else
        {
            print("My Business Id = ", myBusinessId)
            print("My Business NAME = ", myBusinessNAME)
            label.text = myBusinessNAME
            print(profileImage)
            var mainArray = TheBusinesProfileArray as! NSMutableArray
            if mainArray.count == nil
            {
               imageView.image = UIImage(named: "BGProfile")
            }
            else
            {
                print(TheBusinesProfileArray)
                if  TheBusinesProfileArray.count > 0
                {
                    let value = ((TheBusinesProfileArray as NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_path") as! String
                    let url = URL(string: value)
                    imageView.sd_setShowActivityIndicatorView(true)
                    imageView.sd_setIndicatorStyle(.gray)
                    imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
                    self.img = "\(imageView.image!)"
                    self.dpURL = url
                    // self.mahImg = profileImage
                    self.mahImg = "\(dpURL!)"
                }
                let value = ((TheBusinesProfileArray as NSArray).object(at: 0) as! NSDictionary).value(forKey: "image_path") as! String
                let url = URL(string: value)
                imageView.sd_setShowActivityIndicatorView(true)
                imageView.sd_setIndicatorStyle(.gray)
                imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: nil)
                self.img = "\(imageView.image!)"
                self.dpURL = url
                // self.mahImg = profileImage
                 self.mahImg = "\(dpURL!)"
                }
            
        }
        
        getAllMassage()
    
        IQKeyboardManager.shared.enable = false
        
    }
    func saveImageDocumentDirectory()
    {
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("newMsg-20")
        let image = UIImage(named: "newMsg-20")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        inputToolbar.contentView.textView.contentInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        IQKeyboardManager.shared.enable = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        IQKeyboardManager.shared.enable = false
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        IQKeyboardManager.shared.enable = true
    }
    @objc func firstResponderAction()
        
    {
        inputToolbar.contentView.textView.contentInset = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        inputToolbar.contentView.textView.resignFirstResponder()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        cell.textView!.textColor = UIColor.black
        cell.avatarContainerView.backgroundColor = UIColor.green
        cell.avatarImageView.image = UIImage(named: "user")
        cell.textView?.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.blue , NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        let message = messages[indexPath.item]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let DateDataBase = dateFormatter.string(from: message.date)
        print("\(DateDataBase)")
        cell.cellTopLabel.isHidden = false
        cell.cellTopLabel.textColor = UIColor.black
       
        if messages[indexPath.item].senderId == senderId
        {
            cell.textView!.textColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        }
        else
        {
            cell.textView!.textColor = UIColor.init(red: 84/255.0, green: 84/255.0, blue: 87/255.0, alpha: 1)
        }
        return cell
        
    }
    @objc func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        
        let message = messages[indexPath.item]
        
        if let snap = allChatData.object(at: indexPath.item) as? DataSnapshot
        {
            print("snap= \(snap)")
            if let date = (snap.value as! NSDictionary).value(forKey: "message_time") as? String
            {
                let newDate = date.replacingOccurrences(of: " +0000", with: "")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let date = dateFormatter.date(from: newDate)
                if date != nil
                {
                    let DateDataBase = dateFormatter.string(from: date!)
                    
                    print("\(String(describing: date))")
                    return NSAttributedString(string: UTCToLocal(date: DateDataBase))
                }
                    
                else
                {
                    return NSAttributedString(string: "")
                }
            }
            else
                
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss" // superset of OP's format
                
                let DateDataBase = dateFormatter.string(from: message.date)
                return NSAttributedString(string: "\(DateDataBase)")
            }
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss" // superset of OP's format
            
            let DateDataBase = dateFormatter.string(from: message.date)
            return NSAttributedString(string: "\(DateDataBase)")
        }
        
        
    }
 
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        
        let j = indexPath.item
        
        var time1  = ""
        var time2  = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if j == 0
        {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        else
        {
            
            if let snap1 = allChatData.object(at: j) as? DataSnapshot
            {
                print("snap= \(snap1)")
                if let date = (snap1.value as! NSDictionary).value(forKey: "message_time") as? String
                {
                    time1 = date
                }
            }
            
            if (j-1)>0
            {
                if let snap2 = allChatData.object(at: j-1) as? DataSnapshot
                {
                    print("snap= \(snap2)")
                    if let date = (snap2.value as! NSDictionary).value(forKey: "message_time") as? String
                    {
                        time2 = date
                    }
                }
            }
            else
            {
                if let snap1 = allChatData.object(at: j) as? DataSnapshot
                {
                    print("snap= \(snap1)")
                    if let date = (snap1.value as! NSDictionary).value(forKey: "message_time") as? String
                    {
                        time2 = date
                    }
                }
            }
            
            _ = time1.replacingOccurrences(of: " +0000", with: "")
            _ = time2.replacingOccurrences(of: " +0000", with: "")
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        
        let j = indexPath.item
        var time1  = ""
        _  = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if j == 0
        {
            if let snap1 = allChatData.object(at: j) as? DataSnapshot
            {
                print("snap= \(snap1)")
                if let date = (snap1.value as! NSDictionary).value(forKey: "message_time") as? String
                {
                    time1 = date
                }
            }
            
            _ = time1.replacingOccurrences(of: " +0000", with: "")
            return NSMutableAttributedString(string: "Today")
        }
        else
        {
            return NSMutableAttributedString(string: "")
           // return NSMutableAttributedString(string: "Today")
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return 20
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date)
    {
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        var ref = DatabaseReference()
        if fromChatList == "yes"
        {
            ref = Constants.refs.databaseChats.child(USERID + "_" + B_IDFromList).child(workingBusinesId).childByAutoId()
        }
        else if fromBusiensChatList == "yes"
        {
          ref = Constants.refs.databaseChats.child(B_user_id + "_" + USERID).child(BusinesIDFromChatList).childByAutoId()
        }
        else
        {
            ref = Constants.refs.databaseChats.child(USERID + "_" + BUSNES_User_ID).child(myBusinessId).childByAutoId()
        }
        
        print("ref",ref)
        
        var device_token = "fbe36f51edbb131c98b70d52b4c58fc82549106ec4e2d2dec03a08a82b326b94"
        
        if let token = DEFAULT.value(forKey: "DEVICETOKEN") as? String
        {
            device_token = token
        }
        var message = ["":""]
        
        if fromChatList == "yes"
        {
            message = ["from_user_id": USERID, "from_user_name": senderDisplayName, "message": text,"to_user_id": B_IDFromList, "to_user_name": recieverName, "to_deviceid": device_token,"message_time":"\(date)","profile_image": self.mahImg]
        }
        else if fromBusiensChatList == "yes"
        {
            message = ["from_user_id": B_user_id, "from_user_name": senderDisplayName, "message": text,"to_user_id": USERID, "to_user_name": recieverName, "to_deviceid": device_token,"message_time":"\(date)","profile_image": self.mahImg]
        }
        else
        {
            message = ["from_user_id": USERID, "from_user_name": B_Name, "message": text,"to_user_id": BUSNES_User_ID, "to_user_name": myBusinessNAME, "to_deviceid": device_token,"message_time":"\(date)","profile_image": self.mahImg]
        }
        
        ref.setValue(message)
      
        finishSendingMessage()
    }
    
    private func uploadToFirebaseStorageUsingImage(image: UIImage)
    {
        let imageName = NSUUID().uuidString
        
        let ref = Storage.storage().reference().child("message_images").child(imageName)
        if let uploadData = UIImageJPEGRepresentation(image, 0.3)
        {
            
            ref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    
                    print("failed to load:", error as Any)
                    return
                }
                
                if (metadata?.name) != nil{
                    
                    
                }
                
                ref.downloadURL(completion: { (url, error) in
                    if let urlText = url?.absoluteString
                    {
                      print("///////////tttttttt//////// \(urlText)   ////////")
                        // self.sendMessageWithImageUrl(imageUrl: urlText)
                        
                    }
                })
            }
            )
            
        }
        
    }
    
    private func sendMessageWithImageUrl(imageUrl: String)
    {
        
        let ref = Constants.refs.databaseChats.child(self.IdChatList + "_" + self.userId).childByAutoId()
        var device_token = "fbe36f51edbb131c98b70d52b4c58fc82549106ec4e2d2dec03a08a82b326b94"
        if let token = DEFAULT.value(forKey: "DEVICETOKEN") as? String
        {
            device_token = token
        }
        
        let message = ["from_user_id": "1", "from_user_name": senderDisplayName, "message": imageUrl,"to_user_id": BUSNES_User_ID, "to_user_name": recieverName, "to_deviceid": device_token,"message_time":"2019-05-29 13:54:22 +0000","profile_image": self.mahImg] as [String : Any]
        
        ref.setValue(message)
        
        return self.finishSendingMessage(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func getAllMassage()
    {
        
        if allChatData.count>0
        {
            self.allChatData.removeAllObjects()
        }
        var USERID = "66"
        if  let id = DEFAULT.value(forKey: "USERID") as? String
        {
            USERID = id
        }
        _ = Constants.refs.databaseChats.queryLimited(toLast: 100)
         var nextRef = DatabaseReference()
        
        if fromChatList == "yes"
        {
            nextRef = Constants.refs.databaseChats.child(USERID + "_" + B_IDFromList).child(workingBusinesId)
        }
        else if fromBusiensChatList == "yes"
        {
            nextRef = Constants.refs.databaseChats.child(B_user_id + "_" + USERID).child(BusinesIDFromChatList)
        }
        else
        {
            nextRef = Constants.refs.databaseChats.child(USERID + "_" + BUSNES_User_ID).child(myBusinessId)
        }
        
        print("nextRef = ", nextRef)
        
        let query = nextRef.queryLimited(toLast: 10)
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            
            print("data snap = \(String(describing: snapshot.value as? [String: String]))")
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["to_user_id"],
                let name        = data["to_user_name"],
                let text        = data["message"],
                !text.isEmpty
            {
                
                if let message = JSQMessage(senderId: id, senderDisplayName: name, date: Date(), text: text)
                {
                    self?.messages.append(message)
                    
                    self?.allChatData.add(snapshot)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
        
    }
    func localToUTC(date:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: dt!)
    }
    func UTCToLocal(date:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: dt!)
    }
    func dateDiff2(dateStr:String) -> Int32
    {
        let f:DateFormatter = DateFormatter()
        f.timeZone = NSTimeZone.local
        
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //   f.dateFormat = "MMM d"
        let now = f.string(from: NSDate() as Date)
        let startDate = f.date(from: dateStr)
        let endDate = f.date(from: now)
        let calendar: NSCalendar = NSCalendar.current as NSCalendar
        
        let calendarUnits:NSCalendar.Unit = [.weekOfMonth,.day,.year]
        let dateComponents = calendar.components(calendarUnits, from: startDate!, to: endDate!, options: [])
        let weeks = abs(Int32(dateComponents.weekOfMonth!))
        let days = abs(Int32(dateComponents.day!))
        
        var timeAgo = Int32()
        if (days > 0) {
            if (days > 1) {
                timeAgo = days //"\(days) Day Ago"
            } else {
                timeAgo = days //"\(days) Days Ago"
            }
        }
        
        if(weeks > 0)
        {
            if (weeks > 1)
            {
                timeAgo = weeks //"\(weeks) Week Ago"
            }
            else
            {
                timeAgo =  weeks//"\(weeks) Weeks Ago"
            }
        }
        
        print("timeAgo is===> \(timeAgo)")
        return timeAgo;
    }
    
    func firstMessageOfTheDay(indexOfMessage: IndexPath) -> Bool
    {
        let messageDate = messages[indexOfMessage.item].date
        guard let previouseMessageDate = messages[indexOfMessage.item - 1].date else
        {
            return true // because there is no previous message so we need to show the date
        }
        let day = Calendar.current.component(.day, from: messageDate!)
        let previouseDay = Calendar.current.component(.day, from: previouseMessageDate)
        if day == previouseDay
        {
            return false
        }
        else
        {
            return true
        }
    }
    
}
extension Date {
    
    func currentTimeZoneDate() -> String
    {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dtf.string(from: self)
    }
}

