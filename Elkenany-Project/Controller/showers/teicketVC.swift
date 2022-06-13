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
    @IBOutlet weak var headerTitle: UILabel!
    var setupKey = ""
    var showIdd = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teicketTableView.delegate = self
        teicketTableView.dataSource = self
        self.teicketTableView.register(UINib(nibName: "showDetailsDataCell", bundle: nil), forCellReuseIdentifier: "showDetailsDataCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showeDataServiceeee()
        switch setupKey {
        case "moreData":
            headerTitle.text  = "التاريخ"
        case "cost":
            headerTitle.text  = "تكلفة الدخول"

        case "time":
            headerTitle.text  = "الوقت"

        case "organizne":
            headerTitle.text  = "الجهات المنظمة"

        default:
         print("uu")
        }

    }
    
    
     func showeDataServiceeee(){
        let idShow = UserDefaults.standard.string(forKey: "IDDD") ?? ""

         let parm = ["id" : "\(idShow)"]
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
                        print("helllllllllllllo", success.data?.tickets ?? "")
                         
                     }
                 }
             }
         }
     }
     
     
     

}


extension teicketVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        switch setupKey {
        case "moreData":
            return showModel?.data?.dates?.count ?? 0
        case "cost":
            return showModel?.data?.tickets?.count ?? 0

        case "time":
            return showModel?.data?.times?.count ?? 0

        case "organizne":
            return showModel?.data?.organisers?.count ?? 0

        default:
           return 2
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "showDetailsDataCell") as? showDetailsDataCell {
            switch setupKey {
            case "moreData":
                cell.detaliLabel?.text =  showModel?.data?.dates?[indexPath.row].date ?? ""
                return cell
            case "cost":
                cell.detaliLabel?.text = showModel?.data?.tickets?[indexPath.row].status ?? ""
                return cell

            case "time":
                cell.detaliLabel?.text =  showModel?.data?.times?[indexPath.row].time ?? ""
                return cell

            case "organizne":
                cell.detaliLabel?.text =  showModel?.data?.organisers?[indexPath.row].name ?? ""
                return cell

            default:
               return UITableViewCell()
            }

        }
        return UITableViewCell()

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

