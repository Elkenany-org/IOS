//
//  MainStoreVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/18/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class MainStoreVC: UIViewController {

    var dattta:AdsStoreDataModel?
    @IBOutlet weak var StoresCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        StoresCV.delegate = self
        StoresCV.dataSource = self
        self.StoresCV.register(UINib(nibName: "StoreCell", bundle: nil), forCellWithReuseIdentifier: "StoreCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GetStores()
    }
    
    
    
    func GetStores(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
            let typeParameter = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
            let param = ["type": "\(typeParameter ?? "")"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.dattta = success
                    DispatchQueue.main.async {
                        self.StoresCV.reloadData()
                    }
                    
                    
                }
            }
        }
}
    
}

extension MainStoreVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dattta?.data?.data?.count ?? 0
        return dattta?.data?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath) as! StoreCell
        cell.dateee.text = dattta?.data?.data?[indexPath.row].createdAt ?? "888"
        cell.titlee.text = dattta?.data?.data?[indexPath.row].title ?? ""
        cell.location.text = dattta?.data?.data?[indexPath.row].address ?? ""
        cell.number.text = String( dattta?.data?.data?[indexPath.row].salary ?? 0)
        let imagee = dattta?.data?.data?[indexPath.row].image ?? ""
        cell.configureCell(image: imagee)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: 360)

           }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = dattta?.data?.data?[indexPath.row].id ?? 0
        UserDefaults.standard.set(id, forKey: "ADS_ID")
        let vc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
}
