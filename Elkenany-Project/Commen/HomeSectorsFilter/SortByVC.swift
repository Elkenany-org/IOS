//
//  SortByVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/18/22.
//

import UIKit
import JGProgressHUD


protocol SortValue{
    func SortValueBack (value:Int)
}


class SortByVC: UIViewController {
    @IBOutlet weak var SortByTV: UITableView!
    var SortByFilter:FirstFilterModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SortByTV.delegate = self
        SortByTV.dataSource = self
        SortByTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
//        handelTap()
        GetSortFilterData()
    }
    
    //delegets
    var SortValueDeleget:SortValue?
    
    //handel tap out to hide view
    func handelTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
 
    
    
    //MARK:- get data of filter Popup
       func GetSortFilterData(){
           //Handeling Loading view progress
           let hud = JGProgressHUD(style: .dark)
           hud.textLabel.text = "جاري التحميل"
           hud.show(in: self.view)
           DispatchQueue.global(qos: .background).async {
               let param = ["type": "poultry"]
               print("============== request \(param)")
            let homeFilterURL = "https://elkenany.com/api/localstock/all-local-stock-sections?type="
               APIServiceForQueryParameter.shared.fetchData(url: homeFilterURL, parameters: param, headers: nil, method: .get) { (success:FirstFilterModel?, filier:FirstFilterModel?, error) in
                   if let error = error{
                       hud.dismiss()
                       print("============ error \(error)")
                   }else {
                       hud.dismiss()
                       guard let success = success else {return}
                       self.SortByFilter = success
                       DispatchQueue.main.async {
                           self.SortByTV.reloadData()
                               
                       }
                   }
               }
           }
       }

}


//MARK:- tableView Methodes
extension SortByVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortByFilter?.data?.sort?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = SortByFilter?.data?.sort?[indexPath.row].name ?? ""
            return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        let value = SortByFilter?.data?.sort?[indexPath.row].sortValue ?? 0
        UserDefaults.standard.set(value, forKey: "SORT_FOR_FILTER")
        if cell.isSelected{
            cell.imageSelected.image  = #imageLiteral(resourceName: "check")

        }
        FilterAnimation.shared.filteranmation(vieww: view)
        dismiss(animated: true, completion: nil)
        
    }
}
