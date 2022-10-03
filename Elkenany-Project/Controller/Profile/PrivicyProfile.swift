//
//  PrivicyProfile.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit

class PrivicyProfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    @IBAction func confirem(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
