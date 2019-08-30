//
//  CusmerManagementViewController.swift
//  B4Black
//
//  Created by eWeb on 19/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class CusmerManagementViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
 
    @IBOutlet weak var toptableView: UITableView!
    var count = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toptableView.register(UINib(nibName:"AddCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "AddCollectionTableViewCell")
        
        toptableView.register(UINib(nibName:"HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        toptableView.register(UINib(nibName:"DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        
        toptableView.register(UINib(nibName:"RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        
       toptableView.delegate = self
        toptableView.dataSource = self
        count = 4
       }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else if section == 1
            
        {
            return 1
        }
        else if section == 2
        {
            return 1
        }
        else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if indexPath.section == 0
        {
            
        toptableView.register((UINib(nibName: "HomeTableViewCell", bundle: nil)), forCellReuseIdentifier:"HomeTableViewCell")
            
        let cell = toptableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            
            return cell
        }
       else if indexPath.section == 1
       {
        
          toptableView.register((UINib(nibName: "DescriptionTableViewCell", bundle: nil)), forCellReuseIdentifier:"DescriptionTableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
       return cell
        
       }
        
       else if indexPath.section == 2
        {
        
           toptableView.register((UINib(nibName: "DescriptionTableViewCell", bundle: nil)), forCellReuseIdentifier:"DescriptionTableViewCell")
        let cell = toptableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
        return cell
        
    }
        
       else {
         toptableView.register((UINib(nibName: "RatingTableViewCell", bundle: nil)), forCellReuseIdentifier:"RatingTableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
        return cell
       
        }
  
        
}
    
    func seemoreButton(sender:UIButton)
    {
        
        if sender.tag == 0
        {
            count  = 4
//            self.RatingTableViewHeight.constant = CGFloat(count * 250)
            toptableView.reloadData()
            sender.tag = 1
        }
        else
        {
            count  = 20
//            self.RatingTableViewHeight.constant = CGFloat(count * 250)
            toptableView.reloadData()
            sender.tag = 0
        }
        
        
        
    }

}
