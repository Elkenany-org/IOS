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

class companyInfoCell: UITableViewCell, ReatingValue {
    func reatingVal(value: Int) {
        com_rating.rating = Double(value)
    }
    
    
    
    
    //MARK:- OUtlets
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyDesc: UILabel!
    @IBOutlet weak var RatingCompany: UILabel!
    @IBOutlet weak var com_rating: CosmosView!
    var vcc:RatingCompanyVC?
    var DataModel:CompanyDetailsDataModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vcc?.ReatingDelegete = self
        FatchDatafromHome()
    }

    
    func FatchDatafromHome(){
      //Handeling Loading view progress
//      let hud = JGProgressHUD(style: .dark)
//      hud.textLabel.text = "جاري التحميل"
//      hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/guide/company/?id="
            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(idParameter ?? "")"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
//                  hud.dismiss()
                    print("============ error \(error)")
                }else {
//                  hud.dismiss()
                    guard let success = success else {return}
                    self.DataModel = success
                    DispatchQueue.main.async {
                        self.RatingCompany.text = String(self.DataModel?.data?.countRate ?? 0)
                        self.com_rating.rating = Double((self.DataModel?.data?.rate ?? 0))
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
    
    
    
    
    // Button go to Rating View
    @IBAction func ToRatingVC(_ sender: UIButton) {

    }
    
}
