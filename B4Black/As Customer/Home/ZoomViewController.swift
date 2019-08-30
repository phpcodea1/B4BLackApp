//
//  ZoomViewController.swift
//  B4Black
//
//  Created by administrator on 10/05/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
    @IBOutlet var imgezomm: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 2.0, animations: {() -> Void in
            self.imgezomm?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 2.0, animations: {() -> Void in
                self.imgezomm?.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
        })
        
        
    }

  

}
