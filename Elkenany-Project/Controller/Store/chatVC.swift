//
//  chatVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/15/22.
//

import UIKit
import JGProgressHUD

class chatVC: UIViewController {

    @IBOutlet weak var chatTV: UITableView!
    @IBOutlet weak var messageTextFiled: UITextField!
    var chatmessagee:ChatMessages?
    var sendmessagee:SendMessage?
    var chateModel:[Massage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FatchDataOfChat()
        chatTV.delegate = self
        chatTV.dataSource = self
        chatTV.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
    }
    
    
    //MARK:- Handel Login Data To Server
    
    func ChatTap() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "تم الارسال"
        hud.show(in: self.view)
        //Handel Parametars
        let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""

        let parm = [
            "massage": messageTextFiled.text ?? ""  , "id": "\(typeParameter)" ]
        //Handel Parametars
        let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""

        let headers = ["Authorization":"Bearer \(api_token)"]
        //Networking
        let url = "https://elkenany.com/api/store/add-massages"
        APIService.shared.fetchData(url: url, parameters: parm , headers: headers, method: .post) { (Success:SendMessage?, Failed:SendMessage?, error) in
            if let error = error {
                // Internet Offline
                print(error)
                hud.dismiss()
//                self.ErrorHandeling(errorMessage: error.localizedDescription)
            }
            else if let loginError = Failed {
                //Data Wrong From Server
                hud.dismiss()
//                self.ErrorHandeling(errorMessage: loginError.error ?? "خطآ في تسجيل الدخول تاكد من البيانات الرقم السري او البريد الالكتروني ")
                print(loginError)
            }
            else {
                hud.dismiss()
                self.chatTV.reloadData()
                print("goooooooooood")
                
            }
        }
    }
    
    
    
    
    func FatchDataOfChat(){
        let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")

        let parm = [
            "massage": messageTextFiled.text    , "id": typeParameter  ]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""

//            let param = ["id": "Bearer \(typeParameter)" ]
            let headers = ["Authorization": "Bearer \(api_token)" ]

            let url = "https://elkenany.com/api/store/add-massages"

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .post) { (success:SendMessage?, filier:SendMessage?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                
                
                else {
                    
                  
                    let successDataa = success?.data?.chat?.massages ?? []
                    self.chateModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        
                        self.chatTV.reloadData()
                        print("hhhhhhhhhhhhhhh")
                    }
                }
            }
        }
    }
    
    
    
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
        FatchDataOfChat()
    }
    
    
}



extension chatVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chateModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell {
            cell.DateForMessage.text = chateModel[indexPath.item].createdAt ?? ""
            cell.personName.text = chateModel[indexPath.item].name ?? ""
            cell.messageContent.text = chateModel[indexPath.item].massage ?? ""
            let immmmage = chateModel[indexPath.item].image ?? ""
            cell.configureCell(image: immmmage)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
