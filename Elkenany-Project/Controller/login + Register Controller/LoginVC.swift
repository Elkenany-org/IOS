//
//  homeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/21/21.
//

import UIKit
import Alamofire
import JGProgressHUD
import AuthenticationServices
class LoginVC: UIViewController, ASAuthorizationControllerDelegate {
    
    
    
    //Outlets in screen
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- handel validation for textfield
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "خطا", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Handel button actions
    @IBAction func toHomeVC(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "TabBarVC"))! as TabBarVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion:nil)
    }
    
    @IBAction func log(_ sender: Any) {
        handleAuthorizationAppleIDButtonPress()
        
    }
    
    
    //MARK:- Handel button to Register VC actions
    @IBAction func toRegisterVC(_ sender: Any) {
        let registerVC = (storyboard?.instantiateViewController(identifier: "RegisterVC"))! as RegisterVC
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true, completion: nil)
    }
    
    
    //MARK:- Handel Validation and login button
    @IBAction func loginBTN(_ sender: Any) {
        
        if emailTF.text?.isEmpty == true {
            
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else if passwordTF.text?.isEmpty == true {
            ErrorHandeling(errorMessage: "برجاء اداخال البيانات في الحقول الفارغة ")
        }
        else {
            loginTap()
        }
        
    }
    
    
    
    
    
    //MARK:- Handel Forget button in login screen
    @IBAction func ForgetPassword(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "ForgetPasswordVC"))! as ForgetPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion:nil)
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
    
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleCredential.user
            let fullName = appleCredential.fullName
            let email = appleCredential.email
            
            print("userrrrr \(userIdentifier) ----------- \(String(describing: fullName)) ---------- \(String (describing: email) )")
            
            let vc = (storyboard?.instantiateViewController(identifier: "LoginVC"))! as LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion:nil)
        }
        
        
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    
    
    
    
    
    //MARK:- Handel Login Data To Server
    
    func loginTap() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        //Handel Parametars
        let parmm = [
            "email": emailTF.text ?? "",
            "password":passwordTF.text ?? ""]
        //Handel Parametars
        let headers = [ "Accept": "application/json"]
        //Networking
        APIServiceForQueryParameter.shared.fetchData(url: LoginURL, parameters: parmm , headers: headers, method: .post) { (loginSuccess:LoginModel?, loginFailed:LoginModel?, error) in
            if let error = error {
                // Internet Offline
                print(error)
                hud.dismiss()
                self.ErrorHandeling(errorMessage: error.localizedDescription)
            }
            else if let loginError = loginFailed {
                //Data Wrong From Server
                hud.dismiss()
                self.ErrorHandeling(errorMessage: loginError.error ?? "خطآ في تسجيل الدخول تاكد من البيانات الرقم السري او البريد الالكتروني ")
                print(loginError)
            }
            else {
                hud.dismiss()
                print("hello world login")
                let vc = (self.storyboard?.instantiateViewController(identifier: "TabBarVC"))! as TabBarVC
                vc.modalPresentationStyle = .fullScreen
                let apiToken = loginSuccess?.data?.apiToken ?? ""
                UserDefaults.standard.set(apiToken, forKey: "API_TOKEN")
                print("- toke - ", apiToken)
                UserDefaults.standard.set(true, forKey: "LOGIN_STAUTS")
                print("LOGGGG", UserDefaults.standard.bool(forKey: "LOGIN_STAUTS" ) )
                
                self.present(vc, animated: true, completion:nil)
                
            }
        }
    }
}


