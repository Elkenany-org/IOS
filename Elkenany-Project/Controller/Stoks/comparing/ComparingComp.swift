//
//  ComparingComp.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit
import JGProgressHUD

class ComparingComp: UIViewController {

    var CompanyCOM:CompModel?
    @IBOutlet weak var compTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetComparingDataBorsa()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupUI() {
        compTableView.delegate = self
        compTableView.dataSource = self
        compTableView.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }

    
    
    func GetComparingDataBorsa(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
//            let companies_id = [131, 133, 135]
//            let fodder_items_id = [237, 238]
           let idComp =  UserDefaults.standard.string(forKey: "he") ?? ""
            let SectoreFilterURL = "https://elkenany.com/api/localstock/comprison-fodder?id="
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
                    self.CompanyCOM = success
                    DispatchQueue.main.async {
                        self.compTableView.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }

   

}

//MARK:- tableView Methodes
extension ComparingComp:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CompanyCOM?.data?.companies?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = CompanyCOM?.data?.companies?[indexPath.row].name ?? ""

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
            let iDDDDS = CompanyCOM?.data?.companies?[indexPath.row].id ?? 0
        UserDefaults.standard.set(iDDDDS, forKey: "Comp_iD")
            
            FilterAnimation.shared.filteranmation(vieww: view)
            dismiss(animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
