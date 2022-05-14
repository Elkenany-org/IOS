//
//  ReviewsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class ReviewsVC: UIViewController {

    @IBOutlet weak var reviewsTableView: UITableView!
    
    var reviewModel:ShowReview?
    var subreviewModel:[Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        self.reviewsTableView.register(UINib(nibName: "reviewsCell", bundle: nil), forCellReuseIdentifier: "reviewsCell")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        ReviwesServices()
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ReviwesServices()

    }
    
    
    
    func ReviwesServices(){
        let chatID = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""
        let parm = ["id": "5"]
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let headers = ["Authorization": "Bearer \(api_token)" ]
            let url = "https://elkenany.com/api/showes/one-show-review/?id="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShowReview?, filier:ShowReview?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    let successDataa = success?.data?.review ?? []
                    self.subreviewModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        self.reviewsTableView.reloadData()

                        print("hhhhhhhhhhhhhhh")
                        print(success?.data ?? "" )
                    }
                }
            }
        }
    }
    
    

    

}


extension ReviewsVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreviewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell") as? reviewsCell {
//            cell.DateForMessage.text = MessageModel[indexPath.item].createdAt ?? ""
//            cell.personName.text = MessageModel[indexPath.item].name ?? ""
//            cell.messageContent.text = MessageModel[indexPath.item].massage ?? ""
            cell.configureRating(reviewsDataaa: subreviewModel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
}
