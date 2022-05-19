//
//  teicketVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/19/22.
//

import UIKit

class teicketVC: UIViewController {

    var showModel:ShoweModel?
    @IBOutlet weak var teicketTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showeDataServiceeee()
        teicketTableView.delegate = self
        teicketTableView.dataSource = self
        self.teicketTableView.register(UINib(nibName: "showDetailsDataCell", bundle: nil), forCellReuseIdentifier: "showDetailsDataCell")
        
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
                   
                         self.teicketTableView.reloadData()
                         print("hellllllllo")
                         print("helllllllllllllo", success.data?.shortDesc ?? "")
                         
                     }
                 }
             }
         }
     }
     
     
     

}


extension teicketVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return showModel?.data?.teckits?.count ?? 0

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "showDetailsDataCell") as? showDetailsDataCell {
            cell.detaliLabel?.text =  showModel?.data?.teckits?[indexPath.row].name ?? ""
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
