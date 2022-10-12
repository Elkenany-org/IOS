//
//  RegisterVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/30/21.
//

import UIKit
import Alamofire
import JGProgressHUD
import AuthenticationServices


class RegisterVC: UIViewController , ASAuthorizationControllerDelegate {

    //Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    //app toke and this fake confirmation 
    @IBOutlet weak var confirmPassword: UITextField!
    
    ///url
//    https://countriesnow.space/api/v0.1/countries/codes
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    //MARK:- Handeling Back
    @IBAction func backToLoginVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logApple(_ sender: Any) {
        handleAuthorizationAppleIDButtonPress()
        
    }
    
    
    
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    

    //MARK:- handel validation for textfield
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "خطا", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
        
            let defaults = UserDefaults.standard
            defaults.set(userIdentifier, forKey: "userIdentifier1")
            
            //Save the UserIdentifier somewhere in your server/database
            let vc = HomeVC()
            vc.userID = userIdentifier
            self.present(vc, animated: true, completion: nil)
            break
        default:
            break
        }
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
//                print(RegisterSuccess?.data?.apiToken)
                //Save it in local storge
              let register =  RegisterSuccess?.data?.apiToken ?? ""
                UserDefaults.standard.set(register, forKey: "API_TOKEN")
                UserDefaults.standard.set(true, forKey: "LOGIN_STAUTS")

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

