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
    var chateModel:[Massageing] = []
    var MessageModel:[MassageElement] = []
    var roomId = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FatchDataOfChat()
        MessageServices()
        chatTV.delegate = self
        chatTV.dataSource = self
        chatTV.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        title = "محادثة جارية "
        self.tabBarController?.tabBar.isHidden = true

    }
    
    
    //MARK:- Handel Data of chats
    func MessageServices(){
        let chatID = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""
        let parm = ["id": chatID]
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://admin.elkenany.com/api/store/chats-massages?id="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .get) { (success:ChatMessages?, filier:ChatMessages?, error) in
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
                    self.MessageModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        self.chatTV.reloadData()

                        print("hhhhhhhhhhhhhhh")
                    }
                }
            }
        }
    }
    
    
    
    
    
    func sendMessageServices(){
        let chatID = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""
        let parm = [
            "massage": messageTextFiled.text ?? "السعر"    , "id": "\(chatID)" ]
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://admin.elkenany.com/api/store/add-massages"
            
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
                        print("hhhhhhhhhhhhhhh")
                        self.messageTextFiled.text = " "
                        self.chatTV.reloadData()
//                        self.MessageServices()
                    }
                }
            }
        }
    }
    
    
    
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
        sendMessageServices()
        self.chatTV.reloadData()
        self.messageTextFiled.placeholder = "اكتب رسالتك . . . "

    }
    
    
}



extension chatVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell {
            cell.DateForMessage.text = MessageModel[indexPath.item].createdAt ?? ""
            cell.personName.text = MessageModel[indexPath.item].name ?? ""
            cell.messageContent.text = MessageModel[indexPath.item].massage ?? ""
            let immmmage = MessageModel[indexPath.item].image ?? ""
            cell.configureCell(image: immmmage)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
