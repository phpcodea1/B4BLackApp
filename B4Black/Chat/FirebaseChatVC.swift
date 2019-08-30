//
//  FirebaseChatVC.swift
//  B4Black
//
//  Created by eWeb on 12/08/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class FirebaseChatVC: UIViewController {

    @IBOutlet weak var universityName: UITextField!
    @IBOutlet weak var yourName: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      //  FirebaseApp.configure()
        ref = Database.database().reference().child("New_Students")
        
    }
    func newStudents()
    {
       let value = ref.childByAutoId()
        
        let data  = ["name" : yourName.text!,
                     "universityName": universityName.text!]
        //ref.child(data)
    }
    @IBAction func SubmitBtnAct(_ sender: UIButton)
    {
        newStudents()
    }
}
