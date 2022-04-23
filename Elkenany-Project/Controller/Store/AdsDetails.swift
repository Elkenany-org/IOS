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
    
    //outlets and proparites 
    @IBOutlet weak var adsDetailsImage: UIImageView!
    @IBOutlet weak var descriptionOfAds: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var locatiion: UILabel!
    @IBOutlet weak var titlee: UILabel!
    var storeDetails:AdsStoreDetailsDataModel?
    var startRoomChat: StartChat?
    var id_froooom_home = 0
    var keyFromHome = ""

    

    //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAdsDetails()
        
        if keyFromHome == "keyhome"{
            fetchAdsDetailsHome()

        }else{
            fetchAdsDetails()
        }
        
    }
    
    
 
    //MARK:- store ads details
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
                    for ii in storeDetails?.data?.images ?? [] {
                        let url = URL(string:ii.image ?? "")
                        adsDetailsImage.kf.indicatorType = .activity
                        adsDetailsImage.kf.setImage(with: url)
                    }
                   
                }
            }
        }
     }
    
    func fetchAdsDetailsHome(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/store/ads-store-detials?id="
//            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(self.id_froooom_home)"]
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
                    for ii in storeDetails?.data?.images ?? [] {
                        let url = URL(string:ii.image ?? "")
                        adsDetailsImage.kf.indicatorType = .activity
                        adsDetailsImage.kf.setImage(with: url)
                    }
                   
                }
            }
        }
     }
    
    
    func creatChatRoom(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/store/store/start-chat?id="
            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(typeParameter ?? "")"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:StartChat?, filier:StartChat?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.startRoomChat = success
                    }
                   
                }
            }
        }
     

    
    func callNumber(number: String ) {
        guard let url = URL(string: "tel://\(number)") else {return}
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func startChat(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "chatVC") as? chatVC {
            creatChatRoom()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func startAgain(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "chatVC") as? chatVC {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
    }
    

    @IBAction func phoneCall(_ sender: Any) {
        callNumber(number: storeDetails?.data?.phone ?? "")
    }
    
}
