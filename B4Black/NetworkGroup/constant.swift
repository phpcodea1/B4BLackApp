//
//  constant.swift
//  B4Black
//
//  Created by eWeb on 22/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

let DEFAULT = UserDefaults.standard
let APPDEL = UIApplication.shared.delegate  as! AppDelegate
struct Constants
{
    
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chat_data")
        
    }
}
