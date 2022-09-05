//
//  MassegeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit

class MassegeVC: UIViewController {
    
    //MARK: Outlets and vars
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var emptyMessageView: UIView!
    var chatModel:ChatsModel?
    var chatSubModel:[Chating] = []
    var id_room = 0
    
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDataOfChats()
        setupUI()
        title = "الرسائل"
    }
    
    

    
    //UIConfg
    fileprivate func setupUI() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
    }
    
    
    //MARK: Services for chats
    func FatchDataOfChats(){
        ///id of start chat
        let room_id = UserDefaults.standard.string(forKey: "room_chat") ?? ""

        let parm = [ "id": "\(room_id)"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://elkenany.com/api/store/chats?id="
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .get) { (success:ChatsModel?, filier:ChatsModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    let successDataa = success?.data?.chat ?? []
                    self.chatSubModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        if success?.data?.chat?.isEmpty == true {
                            self.chatTableView.isHidden = true
                            self.emptyMessageView.isHidden = false
                        }else{
                            self.chatTableView.reloadData()
                            self.chatTableView.isHidden = false
                            self.emptyMessageView.isHidden = true
                        }
                        print("hhhhhhhhhhhhhhh")
                    }
                }
            }
        }
    }
    
}



//MARK:- chats table view Methodes

extension MassegeVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatSubModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell {
            cell.DateForMessage.text = chatSubModel[indexPath.row].createdAt ?? ""
            
            cell.personName.text = chatSubModel[indexPath.row].name ?? ""
            cell.messageContent.text = chatSubModel[indexPath.item].massage ?? ""
            let immmmage = chatSubModel[indexPath.item].image ?? ""
            cell.configureCell(image: immmmage)
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
