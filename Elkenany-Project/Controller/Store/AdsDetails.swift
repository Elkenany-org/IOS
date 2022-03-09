//
//  AdsDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import UIKit
import Alamofire
import JGProgressHUD
import Kingfisher

class AdsDetails: UIViewController {
    var storeDetails:AdsStoreDetailsDataModel?
    
    @IBOutlet weak var adsDetailsImage: UIImageView!

    @IBOutlet weak var descriptionOfAds: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var locatiion: UILabel!
    @IBOutlet weak var titlee: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAdsDetails()
    }

    func fetchAdsDetails(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/store/ads-store-detials?id="
            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(typeParameter ?? "")"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:AdsStoreDetailsDataModel?, filier:AdsStoreDetailsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.storeDetails = success
                    self.salary.text = String((storeDetails?.data?.salary)! ) 
                    self.descriptionOfAds.text = self.storeDetails?.data?.desc ?? ""
                    self.locatiion.text = storeDetails?.data?.address ?? ""
                    self.titlee.text = storeDetails?.data?.title ?? ""
//                    let image = self.storeDetails?.data?.images ?? ""
//                    configureCell(image: image)
                    
                   
                }
            }
        }
     }
    
    func configureCell(image:String) {
        let url = URL(string:image)
        adsDetailsImage.kf.indicatorType = .activity
        adsDetailsImage.kf.setImage(with: url)
    }
    
}
