//
//  clockVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/19/22.
//

import UIKit




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
         DispatchQueue.global(qos: .background).async {
             let url = "https://elkenany.com/api/ships/statistics-ships"
             APIServiceForQueryParameter.shared.fetchData(url: url, parameters: nil, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
