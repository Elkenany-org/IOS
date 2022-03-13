//
//  ForgetPasswordVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/1/21.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var numberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func test(_ sender: Any) {
        
    }
    

    @IBAction func backBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func confirmAction(_ sender: Any) {
        ErrorHandeling(errorMessage: "سوف يتم تاكيد الرقم السري الخاص بك يمكنك العودة وتصفح المحتوي ")
    }
    
    
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "تنويه", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
