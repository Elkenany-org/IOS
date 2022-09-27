//
//  ForgetPasswordVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/1/21.
//

import UIKit

class ForgetPasswordVC: UIViewController {
    
    var forgetModel: [ForgetPasswordData]?
    var forgetPasswordModel: Forget_password_send_phone?
    var emailFromHome = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    

    
    
    @IBOutlet weak var numberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetPasswordService()
        
    }
    
    //MARK: sectores
    func forgetPasswordService(){
        let sectorsUrl = "https://elkenany.com/api/forget-password"
        let param = ["email": "\(emailTextField.text ?? "")" ]
        let headerss = ["Accept": "application/json"]
        APIServiceForQueryParameter.shared.fetchData(url: sectorsUrl , parameters: param, headers: headerss, method: .post) {[weak self] (NewsSuccess:Forget_password_send_phone?, NewsError:Forget_password_send_phone?, error) in
            guard let self = self else {return}
            if let error = error{
                print("error ===========================")
                print(error.localizedDescription)
            }else{
                guard let success = NewsSuccess else {return}
                self.forgetPasswordModel = success
                DispatchQueue.main.async {
                    print("تم الارسال ")
                    print(success.data ?? "" )
                    self.ErrorHandeling(errorMessage: "تم ارسال الكود الخاص بك علي الايميل ")
                    
                  
                    
          }    }
        }
    }
    
    
    @IBAction func test(_ sender: Any) {
        
    }
    
    
    @IBAction func backBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func confirmAction(_ sender: Any) {
        
        if emailTextField.text?.isEmpty == true{
            ErrorHandeling(errorMessage:" برجاء ادخال الايميل")
            
        }else{
            forgetPasswordService()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "confirmPasswordViewController") as! confirmPasswordViewController
            vc.emailll = emailTextField.text ?? ""
            self.present(vc , animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    func ErrorHandeling(errorMessage:String){
        let alert = UIAlertController(title: "تنويه", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
