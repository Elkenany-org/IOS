//
//  CompareingCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/27/22.
//

import UIKit
import JGProgressHUD
class CompareingCell: UICollectionViewCell {

    var DataaCompanyModel:ComperingDoneModel?

    @IBOutlet weak var compName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func GetComparing(){
    //Handeling Loading view progress
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.contentView)
    DispatchQueue.global(qos: .background).async {
            let companies_id = [131, 133, 135]
            let fodder_items_id = [237, 238]
       let idComp =  UserDefaults.standard.string(forKey: "he") ?? ""
        let SectoreFilterURL = "https://elkenany.com/api/localstock/comprison-fodder-get"
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
//                    self.comComparingTV.reloadData()
                    
//                    print(success.data ?? "")
                }
            }
        }
    }
    }
    
    
}
