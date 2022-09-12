//
//  SectorFilterVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/21/22.
//

import UIKit
import JGProgressHUD

class SectorFilterVC: UIViewController {

    @IBOutlet weak var StokeFilterData: UITableView!
    var borsaModelFilter: StokeFilterDataModel?
    var typeOfBorsa = "fodder"
    override func viewDidLoad() {
        super.viewDidLoad()
        GetFilterDataborsaBySectore()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupUI() {
        StokeFilterData.delegate = self
        StokeFilterData.dataSource = self
        StokeFilterData.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    

    //MARK:- get data of filter Popup
    func GetFilterDataBorsa(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let SectoreFilterURL = "https://elkenany.com/api/localstock/filter-stock-show-sub-section?id=&type=&type_stock="
            let param = ["type": "poultry" , "id": "1", "type_stock": "local" ]
            APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .get) { (success:StokeFilterDataModel?, filier:StokeFilterDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.borsaModelFilter = success
                    DispatchQueue.main.async {
                        self.StokeFilterData.reloadData()
                        
                    }
                }
            }
        }
    }

    func GetFilterDataborsaBySectore(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
          let paramaaa = UserDefaults.standard.string(forKey: "ID_FILTER") ?? ""
            let paramaaaType = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER") ?? ""

            
            let SectoreFilterURL = "https://elkenany.com/api/localstock/filter-stock-show-sub-section?id=&type=&type_stock="
            let param = ["type":"\(paramaaaType)" , "id": "\(paramaaa)", "type_stock": "local" ]
            APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .get) { (success:StokeFilterDataModel?, filier:StokeFilterDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.borsaModelFilter = success
                    DispatchQueue.main.async {
                        self.StokeFilterData.reloadData()
                        
                    }
                }
            }
        }
    }
    
    @IBAction func diiiis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


//MARK:- tableView Methodes
extension SectorFilterVC:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if typeOfBorsa == "local"{
            return borsaModelFilter?.data?.subSections?.count ?? 0

        }else{
            
            return borsaModelFilter?.data?.fodderSubSections?.count ?? 0

        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        
        if typeOfBorsa == "local"{
            cell.SectreTitle.text = borsaModelFilter?.data?.subSections?[indexPath.row].name ?? ""
            return cell
        }else{
            
            cell.SectreTitle.text = borsaModelFilter?.data?.fodderSubSections?[indexPath.row].name ?? ""
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
    
        if typeOfBorsa == "local"{
            let typeeee = borsaModelFilter?.data?.subSections?[indexPath.row].id ?? 0
            UserDefaults.standard.set(typeeee, forKey: "IDDD_FILTER")
            cell.SectreTitle.text = borsaModelFilter?.data?.subSections?[indexPath.row].name ?? ""
            cell.imageSelected.image  = #imageLiteral(resourceName: "check")
            FilterAnimation.shared.filteranmation(vieww: view)
            dismiss(animated: true, completion: nil)


        }else{
            let typeeee = borsaModelFilter?.data?.fodderSubSections?[indexPath.row].id ?? 0
            UserDefaults.standard.set(typeeee, forKey: "IDDD_FILTER")
            cell.SectreTitle.text = borsaModelFilter?.data?.fodderSubSections?[indexPath.row].name ?? ""
            cell.imageSelected.image  = #imageLiteral(resourceName: "check")
            FilterAnimation.shared.filteranmation(vieww: view)
            dismiss(animated: true, completion: nil)
            
            cell.SectreTitle.text = borsaModelFilter?.data?.fodderSubSections?[indexPath.row].name ?? ""

        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
