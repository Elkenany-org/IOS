//
//  clockVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/19/22.
//

import UIKit
import ProgressHUD

protocol MonshaReturn {
    func returnMonsha(Monsha :String , monshaNamee : String)
}


class clockVC: UIViewController {


    @IBOutlet weak var clockTableView: UITableView!
    var MainModelStat:ShipsStatModel?


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showeDataServiceeee()
        clockTableView.delegate = self
        clockTableView.dataSource = self
        self.clockTableView.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")    }
    
    
     func showeDataServiceeee(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
         DispatchQueue.global(qos: .background).async {
             let url = "https://elkenany.com/api/ships/statistics-ships"
             APIServiceForQueryParameter.shared.fetchData(url: url, parameters: nil, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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

                     guard let success = success else {return}
                     self.MainModelStat = success
                 
                     DispatchQueue.main.async {
                   
                         self.clockTableView.reloadData()
           
                         
                     }
                 }
             }
         }
     }
    
    
    
     
    @IBAction func dissssmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var MonshaDelegete:MonshaReturn?

}


extension clockVC: UITableViewDelegate , UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainModelStat?.data?.products?.count ?? 0

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as? SelectedCell {
            cell.SectreTitle.text =  MainModelStat?.data?.products?[indexPath.row].name ?? ""
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let monshaaa = String( MainModelStat?.data?.products?[indexPath.row].id ?? 0)
        let monshaName =  MainModelStat?.data?.products?[indexPath.row].name ?? ""
        MonshaDelegete?.returnMonsha(Monsha: monshaaa, monshaNamee: monshaName )
        print("monshhhhha")
        dismiss(animated: true, completion: nil)
    }
    
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
