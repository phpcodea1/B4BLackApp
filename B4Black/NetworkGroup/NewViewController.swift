//
//  NewViewController.swift
//  B4Black
//
//  Created by administrator on 30/04/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class NewViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func ClickAct(_ sender: UIButton)
    {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString + Bundle.main.bundleIdentifier!)
        {
            if UIApplication.shared.canOpenURL(appSettings)
            {
                UIApplication.shared.open(appSettings)
            }
        }
        }
    }
