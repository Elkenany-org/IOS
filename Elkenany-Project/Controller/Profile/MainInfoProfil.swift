//
//  MainInfoProfil.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit
import Alamofire
import JGProgressHUD
import IQKeyboardManager

class MainInfoProfil: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    var editeMainInfo:EditeMainInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        handelTap()
    }
    

    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    //MARK:- Handel Login Data To Server
    
    func EditeMainInfoTap() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        //Handel Parametars
        let parm = [
            "name": nameTF.text,
            "email":emailTF.text]
        //Handel Parametars
//        let headers:HTTPHeaders = ["lang":"ar", "Content-Type": "application/json"]
        let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
        let headers:HTTPHeaders = ["app-id": "\(api_token ?? "")" ]
       let profileUpdate =  "https://admin.elkenany.com/api/profile-update"

        //Networking
        APIService.shared.fetchData(url: profileUpdate, parameters: parm as Parameters, headers: headers, method: .post) { (EditeSuccess:EditeMainInfoModel?, EditeFailed:EditeMainInfoModel?, error) in
            if let error = error {
                // Internet Offline
                print(error)
                hud.dismiss()
                
            }
            else if let loginError = EditeFailed {
                //Data Wrong From Server
                hud.dismiss()
                print(loginError)
            }
            else {
                hud.textLabel.text = "تم"
                hud.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
 
    @IBAction func dism(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func conformationBTN(_ sender: Any) {
        EditeMainInfoTap()
    }
    
    
    
    
    
}
