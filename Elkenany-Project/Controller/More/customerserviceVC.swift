//
//  customerserviceVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/29/21.
//

import UIKit
import Alamofire
import ProgressHUD

class customerserviceVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBOutlet weak var jobTitle: UITextField!
    
    @IBOutlet weak var companyName: UITextField!
    
    
    
    
    @IBOutlet weak var desc: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handelTap()
    }
    
    
    
    
    
    //MARK:- Handel Login Data To Server
    
    func EditeMainInfoTap() {
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin 
        ProgressHUD.show()
         
        //Handel Parametars
        let parm = [
            "name": name.text,
            "email":email.text,
            "phone":phoneNumber.text,
            "job":jobTitle.text,
            "company":companyName.text,
            "desc":desc.text,
        ]
    
       let CustomerServiceRequestURL =  "https://elkenany.com/api/contuct-us"

        //Networking
        APIService.shared.fetchData(url: CustomerServiceRequestURL, parameters: parm as Parameters, headers: nil, method: .post) { (RequestSuccess:EditeMainInfoModel?, RequestFailed:EditeMainInfoModel?, error) in
            if let error = error {
                // Internet Offline
                print(error)
                ProgressHUD.dismiss()
                
            }
            else if let loginError = RequestFailed {
                //Data Wrong From Server
                ProgressHUD.dismiss()
                print(loginError)
            }
            else {
                ProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    

    fileprivate func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }

    @objc func closePop(){
        dismiss(animated: true)
    }
    
    

    @IBAction func confirmRequest(_ sender: Any) {
        EditeMainInfoTap()
        
        
    }
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
