//
//  ViewController.swift
//  B4Black
//
//  Created by eWeb on 19/12/18.
//  Copyright © 2018 eWeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   
    @IBOutlet weak var getStartOutlet: UIButton!
    let imagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getStartOutlet.layer.cornerRadius = 20
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
  
    @IBAction func getStarted(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func TestingBtnAct(_ sender: UIButton)
    {
        let imagePickerController = UIImagePickerController ()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any])
    {
        let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
        print(videoURL!)
        self.dismiss(animated: true, completion: nil)
    }

}

