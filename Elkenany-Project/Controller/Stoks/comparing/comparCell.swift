//
//  comparCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit
import JGProgressHUD


class comparCell: UICollectionViewCell {

    var DataaCompanyModel:ComperingDoneModel?
    @IBOutlet weak var comComparingTV: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        GetComparing()
    }

    
    fileprivate func setupUI() {
        comComparingTV.delegate = self
        comComparingTV.dataSource = self
        comComparingTV.register(UINib(nibName: "companyCompCell", bundle: nil), forCellReuseIdentifier: "companyCompCell")
    }

    //MARK:- get data of Comparing Popup
    func GetComparing(){
    //Handeling Loading view progress
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.contentView)
    DispatchQueue.global(qos: .background).async {
            let companies_id = [131, 133, 135]
            let fodder_items_id = [237, 238]
       let idComp =  UserDefaults.standard.string(forKey: "he") ?? ""
        let SectoreFilterURL = "https://admin.elkenany.com/api/localstock/comprison-fodder-get"
        let param = ["companies_id[]" : companies_id , "fodder_items_id[]" : fodder_items_id] as [String : Any]
        
//        let param = ["id" : "\(idComp)"]
        print(param)
        APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .post) { (success:ComperingDoneModel?, filier:ComperingDoneModel?, error) in
            if let error = error{
                hud.dismiss()
                print("============ error \(error)")
            }else {
                hud.dismiss()
                guard let success = success else {return}
                self.DataaCompanyModel = success
                DispatchQueue.main.async {
                    self.comComparingTV.reloadData()
                    print(success.data ?? "")
                }
            }
        }
    }
    }
    
}


//MARK:- tableView Methodes
extension comparCell:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataaCompanyModel?.data?.companies?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCompCell") as! companyCompCell
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    
    
}
