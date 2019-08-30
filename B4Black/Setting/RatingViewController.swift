//
//  RatingViewController.swift
//  B4Black
//
//  Created by eWeb on 15/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import KYDrawerController
class RatingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var RatingtableView: UITableView!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var AddCommentView: UIView!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        RatingtableView.dataSource = self
        RatingtableView.delegate = self
        RatingtableView.isHidden = true
        AddCommentView.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let vc = RatingtableView.dequeueReusableCell(withIdentifier: "Cell", for:
            indexPath) as! RatingTableViewCell
        return vc
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  200
    }
    
    @IBAction func backButton(_ sender: Any) {
        let elDrawer = navigationController?.parent as? KYDrawerController
        elDrawer?.setDrawerState(.opened, animated: true)
        
    }
    
    @IBAction func SubmitBtnAct(_ sender: UIButton)
    {
        
    }

    
    
}



