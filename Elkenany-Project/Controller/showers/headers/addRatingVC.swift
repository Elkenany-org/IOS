//
//  addRatingVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit
import Cosmos

class addRatingVC: UIViewController {

    @IBOutlet weak var nameTFF: UITextField!
    @IBOutlet weak var emailTFF: UITextField!
    @IBOutlet weak var detailsTFF: UITextField!
    @IBOutlet weak var rating: CosmosView!
    var addplaceModel:AddPlaces?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    func sendMessageServicesss(){
        let parm = [
            "name": nameTFF.text ?? "",
            "email": emailTFF.text ?? "",
            "desc": detailsTFF.text ?? "",
            "rate" : "\(rating.rating)",
            "show_id": "5"
            ]
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://elkenany.com/api/showes/one-show-reat"
            
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
        
        sendMessageServicesss()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    

}
