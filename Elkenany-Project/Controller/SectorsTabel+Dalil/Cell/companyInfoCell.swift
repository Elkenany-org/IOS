//
//  companyInfoCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import UIKit
import Kingfisher
import Foundation
import Cosmos

class companyInfoCell: UITableViewCell {
    
    //MARK: OUtlets and Vars
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyDesc: UILabel!
    @IBOutlet weak var RatingCompany: UILabel!
    @IBOutlet weak var com_rating: CosmosView!
    var vcc:RatingCompanyVC?
    var DataModel:CompanyDetailsDataModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        FeatchDataOfCompanyInformation()
        
    }
    

    
    
    //MARK: Featch data of Info Company
    func FeatchDataOfCompanyInformation(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://admin.elkenany.com/api/guide/company/?id="
            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(idParameter ?? "")"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.DataModel = success
                    DispatchQueue.main.async {
                        self.RatingCompany.text = String(self.DataModel?.data?.countRate ?? 0)
                        self.com_rating.rating = Double((self.DataModel?.data?.rate ?? 0))
                        print(success.data?.shortDesc ?? "")
                    }
                    
                }
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //Cell Configuration (Image of Company)
    func configureImage(image:String) {
        let url = URL(string:image)
        companyImage.kf.indicatorType = .activity
        companyImage.kf.setImage(with: url)
    }
    
    
}
