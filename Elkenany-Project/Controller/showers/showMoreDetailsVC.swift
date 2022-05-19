//
//  showMoreDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/19/22.
//

import UIKit

class showMoreDetailsVC: UIViewController {

    var showModel:ShoweModel?

    @IBOutlet weak var detailsTableView: UITableView!
    var Switchkey = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        self.detailsTableView.register(UINib(nibName: "showDetailsDataCell", bundle: nil), forCellReuseIdentifier: "showDetailsDataCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showeDataServiceeee()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        showeDataServiceeee()
        

    }
    
   
    func showeDataServiceeee(){
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
                  
                        self.detailsTableView.reloadData()
                        print("hellllllllo")
                        print("helllllllllllllo", success.data?.shortDesc ?? "")
                        
                    }
                }
            }
        }
    }
    
    
    
 

}

extension showMoreDetailsVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return showModel?.data?.times?.count ?? 0

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "showDetailsDataCell") as? showDetailsDataCell {
            cell.detaliLabel?.text =  showModel?.data?.times?[indexPath.row].phone ?? ""
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
