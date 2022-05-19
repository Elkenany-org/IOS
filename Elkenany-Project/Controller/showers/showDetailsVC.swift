//
//  showDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit

class showDetailsVC: UIViewController {

    var showModel:ShoweModel?
    @IBOutlet weak var viewCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showeDataService()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func showeDataService(){
        let parm = ["id" : "5"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show/?id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShoweModel?, filier:ShoweModel?, error) in
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
                    self.showModel = success
                
                    DispatchQueue.main.async {

                        print("hellllllllo")
                        print("helllllllllllllo", success.data?.shortDesc ?? "")
                        
                    }
                }
            }
        }
    }


}
