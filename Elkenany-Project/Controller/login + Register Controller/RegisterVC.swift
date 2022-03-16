//
//  RegisterVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/30/21.
//

import UIKit
import Alamofire
import JGProgressHUD


class RegisterVC: UIViewController {

    //Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    //app toke and this fake confirmation 
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //MARK:- Handeling Back
    @IBAction func backToLoginVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    //MARK:- handel validation for textfield
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "خطا", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
   //MARK:- Register Data
    func registerData() {
        //Handling Loading View
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        //parametars
        let parma = [
            "name": nameTF.text,
            "email":emailTF.text,
            "phone":phoneTF.text,
            "password":passwordTF.text,
            "device_token":confirmPassword.text
        ]
        //headers
        let headers:HTTPHeaders = ["Accept":"application/json"]        
        APIService.shared.fetchData(url: RegisterURL, parameters: parma as Parameters, headers: headers, method: .post) { [self] (RegisterSuccess:RegisterDataModel?, RegisterFailed:RegisterDataModel?, error) in
            if let error = error {
                // internet offline
                print(error)
                hud.dismiss()
            }
            
            else if let loginError = RegisterFailed {
                // data wrong
                hud.dismiss()
                print(loginError)
            }
            
            else {
                
           
                
           print("hello")
                hud.dismiss()
                print(RegisterSuccess?.data?.apiToken)
                //Save it in local storge
                UserDefaults.standard.set(RegisterSuccess?.data?.apiToken, forKey: "API_TOKEN")
                let vc = (storyboard?.instantiateViewController(identifier: "TabBarVC"))! as TabBarVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion:nil)
            }
        }
}

    
    //MARK:- Handeling validation for textfield
    @IBAction func registrationBTN(_ sender: Any) {
        
        if emailTF.text?.isEmpty == true {
            
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else if nameTF.text?.isEmpty == true {
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else if phoneTF.text?.isEmpty == true {
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else if passwordTF.text?.isEmpty == true {
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else if confirmPassword.text?.isEmpty == true {
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else {
            
            if passwordTF.text == confirmPassword.text{
                registerData()
            }else{
                ErrorHandeling(errorMessage:"not matching")

                
            }

            
            
        }
    }
    
}

