//
//  ReviewsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit
import ProgressHUD

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
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()

        let parm = ["id": "5"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
            let url = "https://admin.elkenany.com/api/showes/one-show-review/?id="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShowReview?, filier:ShowReview?, error) in
                if let error = error{
                    //internet error
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    ProgressHUD.dismiss()

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
            cell.configureRating(reviewsDataaa: subreviewModel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
