//
//  SeeMoreReviewVC.swift
//  B4Black
//
//  Created by administrator on 25/07/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class SeeMoreReviewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var reviewArray = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(reviewArray)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerBusinessDetailTableViewCell") as! CustomerBusinessDetailTableViewCell
        let dict = self.reviewArray.object(at: indexPath.row) as! NSDictionary
        cell.descriptionLabel.text = dict.value(forKey: "review_description") as? String
        let rating = dict.value(forKey: "review_star") as! String
        print(rating)
        cell.ratingImg.rating = Double(rating)!
        return cell
    }
    @IBAction func GoBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
