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
   
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var viewShowSearch: UIView!
    @IBOutlet weak var searchView: UISearchBar!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDataOfStore()
        setupSearchBar()
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
    
 
    //MARK:- Featch main store by using search
    func FatchSearchOfStore(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let saerchParamter = searchView.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let type = UserDefaults.standard.string(forKey: "TYYYPE") ?? ""

            print("this is token\(api_token ?? "")")
            let newsURL = "https://elkenany.com/api/store/ads-store?type=&sort=&search="
            let param = ["type": "\(type)", "search" : "\(saerchParamter)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.storeSubModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.storeSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.StoresCV.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func mainFilter(_ sender: Any) {
        
        if let filtervc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC{
            filtervc.RunFilterDeleget = self
            present(filtervc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func toSearch(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = true
        viewShowSearch.isHidden = false
    }
    
    @IBAction func shortCutFilter(_ sender: Any) {
        if let filterVC = storyboard?.instantiateViewController(identifier: "FilterVC") as? FilterVC {
            filterVC.testhidenHome = "home"
            present(filterVC, animated: true, completion: nil)
        }
    }
    
    
    
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

extension MainStoreVC:FilterDone {
    func RunFilter(filter: ()) {
        let typeFilter = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER")
        let sortFilter = UserDefaults.standard.string(forKey: "SORT_FOR_FILTER")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            
            let param = ["type": "\(typeFilter ?? "")" ,  "sort": "1" ]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let newsURL = "https://elkenany.com/api/store/ads-store?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    hud.dismiss()
                    //
                    print(loginError)
                }
                
                
                else {
                    hud.dismiss()
                    self.storeSubModel.removeAll()
                    let successDataaa = success?.data?.data ?? []
                    //                    print("current", self.currentpaga)
                    self.storeSubModel.append(contentsOf: successDataaa)
                    DispatchQueue.main.async {
                        if self.storeSubModel.count == 0 {
                        self.StoresCV.isHidden = true
//                        self.errorHandeling.isHidden = false
                        }else{
                            self.StoresCV.reloadData()
                            self.StoresCV.isHidden = false
//                            self.errorHandeling.isHidden = true
                        }
                        print(successDataaa)
                        
                    }
                }
            }
        }
    }
}



extension MainStoreVC: UISearchBarDelegate {
    
    
    func setupSearchBar() {
        searchView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            //your model
            let data = adsModel?.data?.data ?? []
            //your array
            storeSubModel = data.filter({ ($0.title?.contains(searchText) ?? (0 != 0)) })
            storeSubModel.removeAll()
            
            //Api func
            FatchSearchOfStore()
        }
        
        //reload
        StoresCV.reloadData()
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewShowSearch.isHidden = true
        view1.isHidden = false
        view2.isHidden = false

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        FatchDataOfStore()
        searchView.text = ""
        hud.dismiss()
        print("cancellllld")
    }
}
