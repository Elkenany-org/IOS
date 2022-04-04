//
//  StoreVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class StoreVC: UIViewController {
    
    @IBOutlet weak var SectorSelected: UICollectionView!
    @IBOutlet weak var secondAds: UIView!
    @IBOutlet weak var firstStore: UIView!
    @IBOutlet weak var thiredMassege: UIView!
    var storData:AdsStoreDataModel?
    private var currentpaga = 1
    var isFeatchingImage = false
    var subID_fromGuideHome = 0
    var companyTitle = ""
    private var mainDataModel: [storeData] = []
    var modelTestSearch:storeData?
    //---
    private var isFeatchingData = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        FatchDataOfStore()
        featchDataSelectors()
        SectorSelected.delegate = self
        SectorSelected.dataSource = self
        self.SectorSelected.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
    }
    
    

    func FatchDataOfStore(){
        //Handeling Loading view progress
        //        let hud = JGProgressHUD(style: .dark)
        //        hud.textLabel.text = "جاري التحميل"
        //        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let param = ["type": "poultry" , "page": "\(self.currentpaga)"]
//            print("this para", param)
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort="
            print("URL", companyGuide)
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: nil, headers: nil, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                
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
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.SectorSelected.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    func featchDataSelectors(){
        let api_token = String(UserDefaults.standard.string(forKey: "API_TOKEN")!)
        let param = ["type": "poultry"]

        let sectorsUrl = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
        let headers:HTTPHeaders = ["app-id": api_token ]
        APIService.shared.fetchData(url: sectorsUrl , parameters: param, headers: headers, method: .get) {[weak self] (StorSuccess:AdsStoreDataModel?, StorError:AdsStoreDataModel?, error) in
        guard let self = self else {return}
        if let error = error{
            print("error ===========================")
            print(error.localizedDescription)
        }else{
            self.storData = StorSuccess
            DispatchQueue.main.async {
                self.SectorSelected.reloadData()
            }
        }
    }
}
    
    
    func FatchDataSelectedBySector(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
            let typeParameter = UserDefaults.standard.string(forKey: "Selected_Sec_news")
            let param = ["type": "\(typeParameter ?? "")"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.storData = success
                    DispatchQueue.main.async {
                        self.SectorSelected.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    @IBAction func segmentSelection(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            firstStore.alpha = 1
            secondAds.alpha = 0
            thiredMassege.alpha = 0
            
        }else if sender.selectedSegmentIndex == 1 {
            firstStore.alpha = 0
            secondAds.alpha = 1
            thiredMassege.alpha = 0
            
        }else{
            firstStore.alpha = 0
            secondAds.alpha = 0
            thiredMassege.alpha = 1
        }
    }
    
    
    
}




extension StoreVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storData?.data?.sectors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        cell1.titleLabel.text = storData?.data?.sectors?[indexPath.row].name
        return cell1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 100, height: 60)
       
     }
}


extension StoreVC:UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= mainDataModel.count - 1 && !isFeatchingData {
                
                FatchDataOfStore()
                break
                
            }
            
        }
    }
    
   
}

