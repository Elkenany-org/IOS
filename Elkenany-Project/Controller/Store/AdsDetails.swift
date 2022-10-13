//
//  AdsDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import UIKit
import Alamofire
import ProgressHUD
import Kingfisher

class AdsDetails: UIViewController {
    
    //outlets and proparites 
    @IBOutlet weak var adsDetailsImage: UIImageView!
    @IBOutlet weak var descriptionOfAds: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var locatiion: UILabel!
    @IBOutlet weak var titlee: UILabel!
    var storeDetails:AdsStoreDetailsDataModel?
    var startRoomChat:StartChatModelss?
    //    var startChatSubModel:[StarttChats] = []
    
    
    var id_froooom_home = 0
    var ads_id = 0
    var ads_from_search = 0
    var keyFromHome = ""
    
    
    
    //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "وصف الاعلان"
        //        fetchAdsDetails()
        
        if keyFromHome == "keyhome"{
            fetchAdsDetailsHome()
            title = "وصف الاعلان"

            
        }else{
            fetchAdsDetails()
            title = "وصف الاعلان"

        }
        
    }
    
    
    
    //MARK:- store ads details
    func fetchAdsDetails(){
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://admin.elkenany.com/api/store/ads-store-detials?id="
            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(self.ads_id)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:AdsStoreDetailsDataModel?, filier:AdsStoreDetailsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()

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
    
    //MARK:- store ads details from search
    func fetchAdsDetailsFromHomeSearch(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://admin.elkenany.com/api/store/ads-store-detials?id="
            let param = ["id": "\(self.ads_from_search)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:AdsStoreDetailsDataModel?, filier:AdsStoreDetailsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()

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
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {

            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://admin.elkenany.com/api/store/ads-store-detials?id="
            //            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(self.id_froooom_home)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:AdsStoreDetailsDataModel?, filier:AdsStoreDetailsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()

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
            let companyGuide = "https://admin.elkenany.com/api/store/start-chat?id="
            //            let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID")
            let param = ["id": "\(self.ads_id)"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { [self] (success:StartChatModelss?, filier:StartChatModelss?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.startRoomChat = success
                    //                    print(success.data?.chat?.id ?? "")
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
        
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "chatVC") as? chatVC {
                creatChatRoom()
                let id = startRoomChat?.data?.chat?.id ?? 0
                UserDefaults.standard.set(id, forKey: "room_chat")
                vc.roomId = id
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func startAgain(_ sender: Any) {
        
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "chatVC") as? chatVC {
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        
        
    }
    
    
    @IBAction func toMessagess(_ sender: Any) {
        
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MassegeVC") as? MassegeVC {
                navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }else{
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "popupToSignIN") as? popupToSignIN {
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        
        
    }
    
    
    
    @IBAction func phoneCall(_ sender: Any) {
        callNumber(number: storeDetails?.data?.phone ?? "")
    }
    
}
