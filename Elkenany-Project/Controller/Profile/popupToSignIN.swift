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

    @IBAction func toLogin(_ sender: Any) {
//        self.navigationController!.popToRootViewController(animated: true)
//        navigationController?.popViewController(animated: true)
//        navigationController?.popToRootViewController(animated: true)
//        dismiss(animated: true, completion: nil)
        
        if let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }

    }
    
    
    
    @IBAction func exite(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
