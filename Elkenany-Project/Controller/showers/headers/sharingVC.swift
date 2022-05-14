//
//  sharingVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class sharingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//  
//    func sendMessageServices(){
//        let chatID = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""
//        let parm = [
//            "massage": messageTextFiled.text ?? "السعر"    , "id": "\(chatID)" ]
//        
//        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
//            let headers = ["Authorization": "Bearer \(api_token)" ]
//            let url = "https://elkenany.com/api/store/add-massages"
//            
//            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .post) { (success:SendMessage?, filier:SendMessage?, error) in
//                if let error = error{
//                    //internet error
//                    print("============ error \(error)")
//                    
//                }
//                else if let loginError = filier {
//                    //Data Wrong From Server
//                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
//                }
//                else {
//                    let successDataa = success?.data?.chat?.massages ?? []
//                    self.chateModel.append(contentsOf: successDataa)
//                    DispatchQueue.main.async {
//                        print("hhhhhhhhhhhhhhh")
//                        self.messageTextFiled.text = " "
//                        self.chatTV.reloadData()
////                        self.MessageServices()
//                    }
//                }
//            }
//        }
//    }
//    
    
    
    

}
