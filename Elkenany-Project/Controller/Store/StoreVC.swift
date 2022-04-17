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
    @IBOutlet weak var searcBarView: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var errorHandeling: UIView!
    
    
    
    
    var storData:AdsStoreDataModel?
    private var currentpaga = 1
    private var isFeatchingData = false
    var isFeatchingImage = false
    var subID_fromGuideHome = 0
    var companyTitle = ""
    private var mainDataModel: [storeData] = []
    private var sectoreDataModel: [SectorsSelected] = []
    @IBOutlet weak var firsttest: UIView!
    var storeSubModel:[storeData] = []
    var typeFromhome = "poultry"
    let dataArray = [ "الرسايل" , "اعلاناتي" , "السوق"]
    @IBOutlet weak var Sectorcvvv: UICollectionView!
    @IBOutlet weak var feturesCV: UICollectionView!

    var modelTestSearch:storeData?
    //---
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        FatchDataOfStore()
        FeatchDataOfectores()
        setupSearchBar()
        SectorSelected.delegate = self
        SectorSelected.dataSource = self
        self.SectorSelected.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        Sectorcvvv.delegate = self
        Sectorcvvv.dataSource = self
        self.Sectorcvvv.register(UINib(nibName: "StoreCell", bundle: nil), forCellWithReuseIdentifier: "StoreCell")
        feturesCV.delegate = self
        feturesCV.dataSource = self
        self.feturesCV.register(UINib(nibName: "storeFeaturesCell", bundle: nil), forCellWithReuseIdentifier: "storeFeaturesCell") 
    }
    
    
    

    
    
    
    
    
    
    //MARK:- Featch sectors
    func FeatchDataOfectores(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "\(self.typeFromhome)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (SuccessfulRequest:AdsStoreDataModel?, FailureRequest:AdsStoreDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successDataSectore = SuccessfulRequest?.data?.sectors?.reversed() ?? []
                    self.sectoreDataModel.append(contentsOf: successDataSectore)
                    DispatchQueue.main.async {
                        self.SectorSelected.reloadData()
                    }
                }
            }
        }
    }

    
    
    func FatchDataOfStore(){
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let param = ["type": "\(self.typeFromhome)" , "page": "\(self.currentpaga)", "sort" : "1"]
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
                        
                        self.Sectorcvvv.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
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
                    let successDataSectoreSelecte = success?.data?.sectors?.reversed() ?? []
                    self.sectoreDataModel.append(contentsOf: successDataSectoreSelecte)
                    DispatchQueue.main.async {
                        self.SectorSelected.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    ///filter click
    @IBAction func storeFilter(_ sender: Any) {
        if let filtervc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC{
            filtervc.RunFilterDeleget = self
            present(filtervc, animated: true, completion: nil)
        }
    }
    

    @IBAction func toSearchView(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = true
        searchView.isHidden = false
    }
    
    
    @IBAction func filterShortCut(_ sender: Any) {
    }
    
    
    
}




extension StoreVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == SectorSelected {
            return sectoreDataModel.count

        }else if collectionView == Sectorcvvv{
            return storeSubModel.count
        }else if collectionView == feturesCV {
            return 3
            
        }
        
        
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == SectorSelected {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
    //        cell1.titleLabel.text = storData?.data?.sectors?[indexPath.row].name
            cell1.titleLabel.text = sectoreDataModel[indexPath.item].name ?? ""
            let typeee = sectoreDataModel[indexPath.item].type ?? ""
            if typeee == typeFromhome {
                cell1.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
                SectorSelected.selectItem(at: indexPath, animated: true, scrollPosition: .right)
                
            }else{
                cell1.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            }
            
            return cell1

        }else if collectionView == Sectorcvvv{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreCell", for: indexPath) as! StoreCell
            cell1.dateee.text = storeSubModel[indexPath.item].createdAt ?? "888"
            cell1.titlee.text = storeSubModel[indexPath.item].title ?? ""
            cell1.location.text = storeSubModel[indexPath.item].address ?? ""
            cell1.number.text = String( storeSubModel[indexPath.row].salary ?? 0)
            let imagee = storeSubModel[indexPath.item].image ?? ""
            cell1.configureCell(image: imagee)
            return cell1
        }else if collectionView == feturesCV {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "storeFeaturesCell", for: indexPath) as! storeFeaturesCell
            cell1.titleee.text = dataArray[indexPath.item]
//            cell1.titleLabel.text = sectoreDataModel[indexPath.item].name ?? ""
            return cell1
            
        }

        return UICollectionViewCell()
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == SectorSelected {
            return CGSize(width: 100, height: 60)
            

        }else if collectionView == Sectorcvvv{
            return CGSize(width:collectionView.frame.width, height: 304)

        }else if collectionView == feturesCV {
            return CGSize(width:collectionView.frame.width / 3.2, height: 60)

        }
        else{
            
            return CGSize( width:collectionView.frame.width, height: 304)

        }

       
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if collectionView == SectorSelected{
            print("")
            let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
            let typeOfSectorr = sectoreDataModel[indexPath.item].type ?? ""
            self.typeFromhome = typeOfSectorr
            UserDefaults.standard.set(typeOfSectorr, forKey: "TYPE_FOR_FILTER")

            
//            if(cell.isSelected == true)
//            {
//                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
//                SectorSelected.selectItem(at: indexPath, animated: true, scrollPosition: .right)
//
//
//            }
            FatchDataOfStore()
        }else if collectionView == feturesCV{
            print("")

        }else{
            
                    let id = storeSubModel[indexPath.row].id ?? 0
                    UserDefaults.standard.set(id, forKey: "ADS_ID")
                    let vc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
                    navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let typeee = sectoreDataModel[indexPath.item].type ?? ""
////        testdeleget?.test(type: typeee)
////        UserDefaults.standard.setValue(typeee, forKey: "typeSec")
////        let vc = storyboard?.instantiateViewController(withIdentifier: "MainStoreVC") as? MainStoreVC
////        vc?.StoresCV.reloadData()
////        vc?.FatchDataOfStoreFromStorevc()
//
//
//        for subview in firsttest.subviews {
//                  subview.removeFromSuperview()
//            }
//
//            let alertStoryBoard =  UIStoryboard(name: "Main", bundle: nil)
//            var controller: UIViewController!
//
//
//
//            if  let allCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"MainStoreVC") as? MainStoreVC  {
//
//                controller = allCollectionViewController
//
//
//
//    }
//
//        addChild(controller )
//
//        // Add the child's View as a subview
//        firsttest.addSubview(controller.view)
//        controller.view.frame = firsttest.bounds
//        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//         // tell the childviewcontroller it's contained in it's parent
//        controller.didMove(toParent: self)
//
//}
    
    
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


extension StoreVC:FilterDone {
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
                        if success?.data?.data == nil {
                            self.errorHandeling.isHidden = false
                            self.firsttest.isHidden = true

                        }else {
                            self.errorHandeling.isHidden = true
                            self.firsttest.isHidden = false

                            self.Sectorcvvv.reloadData()

                        }
                        print(successDataaa)
                        
                    }
                }
            }
        }
    }
}




extension StoreVC: UISearchBarDelegate {
    
    func setupSearchBar() {
        searcBarView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = storData?.data?.data ?? []
            //your array
            storeSubModel = data.filter({ ($0.title?.contains(searchText) ?? (0 != 0)) })
            storeSubModel.removeAll()
            
            //Api func
            FatchDataOfStore()
        }
        
        //reload
        Sectorcvvv.reloadData()
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.isHidden = true
        view1.isHidden = false
        view2.isHidden = false
        storeSubModel.removeAll()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        FatchDataOfStore()
        searcBarView.text = ""
        hud.dismiss()
        print("cancellllld")
    }
}
