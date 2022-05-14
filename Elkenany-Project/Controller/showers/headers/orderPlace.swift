//
//  orderPlace.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class orderPlace: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var detailsTF: UITextField!

    var addplaceModel:AddPlaces?
//    var subModel:[AddPlaces] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func sendMessageServices(){
        let chatID = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""
        let parm = [
            "name": nameTF.text ?? "",
            "email": emailTF.text ?? "",
            "phone": phoneTF.text ?? "",
            "company": companyNameTF.text ?? "",
            "desc": detailsTF.text ?? "",
            "show_id": "5"
            ]
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://elkenany.com/api/showes/one-show-place"
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .post) { (success:AddPlaces?, filier:AddPlaces?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.addplaceModel = success
                    DispatchQueue.main.async {
                        print("hhhhhhhhhhhhhhh")
                        print(success.message ?? "")
                    }
                }
            }
        }
    }

    
    
    @IBAction func confirmRequest(_ sender: Any) {
        
        sendMessageServices()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
