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
    
    var storData:AdsStoreDataModel?
    
    
    @IBOutlet weak var SectorSelected: UICollectionView!
    
    @IBOutlet weak var secondAds: UIView!
    
    @IBOutlet weak var firstStore: UIView!
    
    @IBOutlet weak var thiredMassege: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SectorSelected.delegate = self
        SectorSelected.dataSource = self
        self.SectorSelected.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featchDataSelectors()
        FatchDataSelectedBySector()
    }
    
    
    func featchDataSelectors(){
        let api_token = String(UserDefaults.standard.string(forKey: "API_TOKEN")!)
        let sectorsUrl = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
        let headers:HTTPHeaders = ["app-id": api_token ]
        APIService.shared.fetchData(url: sectorsUrl , parameters: nil, headers: headers, method: .get) {[weak self] (StorSuccess:AdsStoreDataModel?, StorError:AdsStoreDataModel?, error) in
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
