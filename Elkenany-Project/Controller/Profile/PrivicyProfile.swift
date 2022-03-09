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
        handelTap()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
}
