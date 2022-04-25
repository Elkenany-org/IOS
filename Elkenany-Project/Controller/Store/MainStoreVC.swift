//
//  MainStoreVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class MainStoreVC: UIViewController  {
   
    
    @IBOutlet weak var StoresCV: UICollectionView!
    var adsModel:AdsStoreDataModel?
    var dddd:StoreVC?
    private var currentpaga = 1
    private var isFeatchingData = false
    var isFeatchingImage = false
    var storeSubModel:[storeData] = []
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDataOfStore()
        StoresCV.delegate = self
        StoresCV.dataSource = self
        self.StoresCV.register(UINib(nibName: "StoreCell", bundle: nil), forCellWithReuseIdentifier: "StoreCell")
        
        
    }
    
    
    
    
    func FatchDataOfStore(){
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let param = ["type": "animal" , "page": "\(self.currentpaga)", "sort" : "1"]
            let headers = ["app-id": "\(id_rec)" ]
            
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort="
            print("URL", companyGuide)
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                
                
                else {
                    
                    if success?.data?.nextPageURL == nil {
                        
                    }
                    
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.storeSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.StoresCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }


    
    
    func FatchDataOfStoreFromStorevc(){
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let type_rec = UserDefaults.standard.value(forKey: "typeSec") ?? ""

            let param = ["type": "\(type_rec)" , "page": "\(self.currentpaga)", "sort" : "1"]
            let headers = ["app-id": "\(id_rec)" ]

            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort="
            print("URL", companyGuide)
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                
                
                else {
                    
                    if success?.data?.nextPageURL == nil {
                        
                    }
                    
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.storeSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.StoresCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    
//    func GetStores(){
//        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
//            let typeParameter = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
//            let param = ["type":  "poultry"]
//            let headers = ["app-id": "\(api_token ?? "")" ]
//            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
//                if let error = error{
//                    print("============ error \(error)")
//                }else {
//                    guard let success = success else {return}
//                    self.adsModel = success
//                    DispatchQueue.main.async {
//                        self.StoresCV.reloadData()
//                    }
//                    
//                    
//                }
//            }
//        }
//    }
    
}

extension MainStoreVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dattta?.data?.data?.count ?? 0
        return storeSubModel.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath) as! StoreCell
        cell.dateee.text = storeSubModel[indexPath.item].createdAt ?? "888"
        cell.titlee.text = storeSubModel[indexPath.item].title ?? ""
        cell.location.text = storeSubModel[indexPath.item].address ?? ""
        cell.number.text = String( storeSubModel[indexPath.row].salary ?? 0)
        let imagee = storeSubModel[indexPath.item].image ?? ""
        cell.configureCell(image: imagee)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: 304)

           }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = storeSubModel[indexPath.row].id ?? 0
        UserDefaults.standard.set(id, forKey: "ADS_ID")
        let vc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
}

extension MainStoreVC:UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= storeSubModel.count - 1 && !isFeatchingData {
                
                FatchDataOfStore()
                break
                
            }
            
        }
    }
    
   
}
