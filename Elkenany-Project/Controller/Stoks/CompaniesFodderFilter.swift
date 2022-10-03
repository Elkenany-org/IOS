//
//  CompaniesFodderFilter.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/20/22.
//

import UIKit
import ProgressHUD

protocol FilterComaniesDone {
    func RunFilter(filter:())
}


class CompaniesFodderFilter: UIViewController {
    
    @IBOutlet weak var CompaniesFilter: UITableView!
    
    var FilterCompanies:CompaniesModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetFilterDataForComapnies()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupUI() {
        CompaniesFilter.delegate = self
        CompaniesFilter.dataSource = self
        CompaniesFilter.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    
    
    var RunFilterDelegett :FilterComaniesDone?
    
    
    
    //MARK:- get data of filter Popup
    func GetFilterDataForComapnies(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            ///data not real
            let stoID = UserDefaults.standard.string(forKey: "he") ?? ""
            
            let param = ["stock_id": "\(stoID)" , "company_id" : "308"]
            let subGuideFilterURL = "https://elkenany.com/api/localstock/companies-items?stock_id=&company_id="
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:CompaniesModelData?, filier:CompaniesModelData?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.FilterCompanies = success
                    DispatchQueue.main.async {
                        self.CompaniesFilter.reloadData()
                        print(success.data ?? "")
                        
                    }
                }
            }
        }
    }
    
    
}

//MARK:- tableView Methodes
extension CompaniesFodderFilter:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterCompanies?.data?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = FilterCompanies?.data?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comp_id = FilterCompanies?.data?[indexPath.row].id ?? 0
        
        UserDefaults.standard.set(comp_id, forKey: "FILTER_COMP_ID")
        
        RunFilterDelegett?.RunFilter(filter: ())
        dismiss(animated: true, completion: nil)
        
    }
    
}

