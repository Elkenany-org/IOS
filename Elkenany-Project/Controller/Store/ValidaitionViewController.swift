//
//  ValidaitionViewController.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/24/22.
//

import UIKit

class ValidaitionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toSignIn(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    

}
