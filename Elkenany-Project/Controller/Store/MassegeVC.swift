//
//  MassegeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit

class MassegeVC: UIViewController {
    @IBOutlet weak var chatTableView: UITableView!
    
    var chateModel:[Massage] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDataOfChats()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
//        FatchDataOfChats()
        
    }
    

    
    ///service for chats
    func FatchDataOfChats(){
//        let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID"
        let parm = [
            "massage": ""    , "id": ""  ]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""

//            let param = ["id": "Bearer \(typeParameter)" ]
            let headers = ["Authorization": "Bearer \(api_token)" ]

            let url = "https://elkenany.com/api/store/chats"

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: headers, method: .get) { (success:Massage?, filier:Massage?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
//                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                
                
                else {
                    
                  
//                    let successDataa = success?.data?.chat?.massages ?? []
//                    self.chateModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        
                        self.chatTableView.reloadData()
                        print("hhhhhhhhhhhhhhh")
                    }
                }
            }
        }
    }

}




extension MassegeVC: UITableViewDelegate , UITableViewDataSource{
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
