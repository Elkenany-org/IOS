//
//  popupToSignIN.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/14/22.
//

import UIKit

class popupToSignIN: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handelTap()
    }
    

    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }

}
