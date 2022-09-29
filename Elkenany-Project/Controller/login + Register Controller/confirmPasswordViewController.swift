//
//  confirmPasswordViewController.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 9/27/22.
//

import UIKit

class confirmPasswordViewController: UIViewController {
    var forgetPasswordCodeModel: passwordCodeData?
    
    @IBOutlet weak var changeTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    var emailll = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func forgetPasswordServicee(){
        let sectorsUrl = "https://elkenany.com/api/forget-password-code"
        let param = ["code": "\(changeTextField.text ?? "")" , "email": "\(emailll)" , "password" : "\(newPasswordTextField.text ?? "")" ]
        let headerss = ["Accept": "application/json"]
        APIServiceForQueryParameter.shared.fetchData(url: sectorsUrl , parameters: param, headers: headerss, method: .post) {[weak self] (NewsSuccess:passwordCodeData?, NewsError:passwordCodeData?, error) in
            guard let self = self else {return}
            if let error = error{
                print("error ===========================")
                print(error.localizedDescription)
            }else{
                guard let success = NewsSuccess else {return}
                self.forgetPasswordCodeModel = success
                DispatchQueue.main.async {
                    print("تم الارسال ")
                    self.ErrorHandeling(errorMessage: "تم تغيير الرقم السري بنجاح")
                    
                    
                }    }
        }
    }
    
    
    @IBAction func confirChanges(_ sender: Any) {
        forgetPasswordServicee()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc , animated: true, completion: nil)
        
    }
    
    
    @IBAction func backToConfirmation(_ sender: Any) {
    }
    
    
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "تنويه", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
