//
//  ComparingItems.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit
import JGProgressHUD

class ComparingItems: UIViewController {
    var CompanyCOMPA:CompModel?

    @IBOutlet weak var itemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetComparingDataBorsa()
        // Do any additional setup after loading the view.
    }
    

    
    fileprivate func setupUI() {
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }

    //MARK:- get data of Comparing Popup
    func GetComparingDataBorsa(){
    //Handeling Loading view progress
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "جاري التحميل"
    hud.show(in: self.view)
    DispatchQueue.global(qos: .background).async {
//            let companies_id = [131, 133, 135]
//            let fodder_items_id = [237, 238]
       let idComp =  UserDefaults.standard.string(forKey: "he") ?? ""
        let SectoreFilterURL = "https://admin.elkenany.com/api/localstock/comprison-fodder?id="
//            let param = ["companies_id[]" : "\(companies_id)" , "fodder_items_id[]" : "\(fodder_items_id)"]
        
        let param = ["id" : "\(idComp)"]
        print(param)
        APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .get) { (success:CompModel?, filier:CompModel?, error) in
            if let error = error{
                hud.dismiss()
                print("============ error \(error)")
            }else {
                hud.dismiss()
                guard let success = success else {return}
                self.CompanyCOMPA = success
                DispatchQueue.main.async {
                    self.itemsTableView.reloadData()
                    print(success.data ?? "")
                }
            }
        }
    }
    }

   

}

//MARK:- tableView Methodes
extension ComparingItems:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CompanyCOMPA?.data?.feeds?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = CompanyCOMPA?.data?.feeds?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let iDSCOMPARING = CompanyCOMPA?.data?.feeds?[indexPath.row].id ?? 0
        UserDefaults.standard.set(iDSCOMPARING, forKey: "Comparing_iD")
            FilterAnimation.shared.filteranmation(vieww: view)
            dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
