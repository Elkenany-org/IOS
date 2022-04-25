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
    
    //MARk: Outlets
    @IBOutlet weak var SectorSelected: UICollectionView!
    @IBOutlet weak var secondAds: UIView!
    @IBOutlet weak var firstStore: UIView!
    @IBOutlet weak var thiredMassege: UIView!
    @IBOutlet weak var searcBarView: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var firsttest: UIView!
    @IBOutlet weak var errorHandeling: UIView!
    @IBOutlet weak var Sectorcvvv: UICollectionView!
    @IBOutlet weak var feturesCV: UICollectionView!
    
    //MARk: vars
    private var currentpaga = 1
    private var isFeatchingData = false
    var isFeatchingImage = false
    var subID_fromGuideHome = 0
    private var sectoreDataModel: [SectorsSelected] = []
    var storeSubModel:[storeData] = []
    var modelTestSearch:storeData?
    var storData:AdsStoreDataModel?
    var typeFromhome = ""
    let dataArray = [ "الرسايل" , "اعلاناتي" , "السوق"]
    var companyTitle = ""
    
    
    
    //MARk: life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FatchDataOfStore()
        FeatchDataOfectores()
        setupSearchBar()
        SectorSelected.delegate = self
        SectorSelected.dataSource = self
        Sectorcvvv.delegate = self
        Sectorcvvv.dataSource = self
        feturesCV.delegate = self
        feturesCV.dataSource = self
        self.SectorSelected.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.Sectorcvvv.register(UINib(nibName: "StoreCell", bundle: nil), forCellWithReuseIdentifier: "StoreCell")
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
    
    
    
    //MARK:- Featch main store
    func FatchDataOfStore(){
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let param = ["type": "\(self.typeFromhome)" , "page": "\(self.currentpaga)", "sort" : "1"]
            let headers = ["app-id": "\(id_rec)" ]
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort=&page="
            print("URL", companyGuide)
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                    
                    print("ffffffffffffff")
                }
                
                
                else {
                    
                    if success?.data?.nextPageURL == nil {
                        
                    }
                    
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.storeSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
//                        if success?.data?.data == nil {
//                            self.Sectorcvvv.isHidden = true
//                            self.errorHandeling.isHidden = false
//                        }else{
//                            self.Sectorcvvv.isHidden = false
//                            self.errorHandeling.isHidden = true
//                        }
                        self.Sectorcvvv.reloadData()
//
//                        if self.storeSubModel.count == 0 {
//                        self.Sectorcvvv.isHidden = true
//                        self.errorHandeling.isHidden = false
//                        }else{
//
//                            self.Sectorcvvv.isHidden = false
//                            self.errorHandeling.isHidden = true
//                        }
////
                        print("rrrr" ,self.storeSubModel.count )
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
        let saerchParamter = searcBarView.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let newsURL = "https://elkenany.com/api/store/ads-store?type=&sort=&search="
            let param = ["type": "\(self.typeFromhome)", "search" : "\(saerchParamter)"]
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
                        self.Sectorcvvv.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    //MARK:- Featch main store by using search

    func FatchDataSelectedBySector(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/store/ads-store?type=&sort=&search"
//            let typeParameter = UserDefaults.standard.string(forKey: "Selected_Sec_news")
            let param = ["type": "\(self.typeFromhome )"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:AdsStoreDataModel?, filier:AdsStoreDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.storeSubModel.removeAll()
                    let successDataSectoreSelecte = success?.data?.data ?? []
                    self.storeSubModel.append(contentsOf: successDataSectoreSelecte)
                    DispatchQueue.main.async {
                        if self.storeSubModel.count == 0 {
                        self.Sectorcvvv.isHidden = true
                        self.errorHandeling.isHidden = false
                        }else{
                        self.Sectorcvvv.reloadData()
                            self.Sectorcvvv.isHidden = false
                            self.errorHandeling.isHidden = true
                        }
                        

//                        self.Sectorcvvv.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    
    //MARK: Main Filter
    @IBAction func storeFilter(_ sender: Any) {
        if let filtervc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC{
            filtervc.RunFilterDeleget = self
            present(filtervc, animated: true, completion: nil)
        }
    }
    
    
    //handel the hide and show of view 
    @IBAction func toSearchView(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = true
        searchView.isHidden = false
    }
    
    
    @IBAction func filterShortCut(_ sender: Any) {
        if let filterVC = storyboard?.instantiateViewController(identifier: "FilterVC") as? FilterVC {
//            filterVC.RunFilterDeleget = self
//            filterVC.selectedType = typeFromhome
//            
            filterVC.testhidenHome = "home"
            present(filterVC, animated: true, completion: nil)
        }
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
            if indexPath.item == 2{
                cell1.selectedView.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
            }else
            {
                cell1.selectedView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
                
            }
            
            cell1.titleee.text = dataArray[indexPath.item]
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
            //            let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
            let typeOfSectorr = sectoreDataModel[indexPath.item].type ?? ""
            self.typeFromhome = typeOfSectorr
//            self.typeFromhome = typeee
            FatchDataSelectedBySector()
            UserDefaults.standard.set(typeOfSectorr, forKey: "TYPE_FOR_FILTER")
            SectorSelected.selectItem(at: indexPath, animated: true, scrollPosition: .right)

            
            
            
            
            //            if(cell.isSelected == true)
            //            {
            //                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
            //
            //
            //            }
            //            FatchDataOfStore()
            
            
        }else if collectionView == feturesCV{
            
            //            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "storeFeaturesCell", for: indexPath) as! storeFeaturesCell
            
            
            for subview in firsttest.subviews {
                subview.removeFromSuperview()
            }
            
            
            let alertStoryBoard =  UIStoryboard(name: "Main", bundle: nil)
            var controller: UIViewController!
            
            //switch about index
            switch indexPath.item {
            case 0:
                print("one // message")
                
                let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
                
                if isloggineIn {
                    let alllCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"MassegeVC") as! MassegeVC
                    controller = alllCollectionViewController
                    
                }else{
                    
                    if let alllCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"ValidaitionViewController") as? ValidaitionViewController  {
                        controller = alllCollectionViewController
                    }
                }
                
                
                
                
            case 1:
                print("one/ 2 ads")
                
                let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
                if isloggineIn {
                    if  let alllCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"AdsVC") as? AdsVC  {
                        controller = alllCollectionViewController
                    }
                    
                }else{
                    
                    
                    if  let alllCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"ValidaitionViewController") as? ValidaitionViewController  {
                        controller = alllCollectionViewController
                    }
                }
                
                
            case 2:
                print("one / 3")
                
                //                var isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
                //                if isloggineIn {
                //
                //
                //
                //                }else{
                //                            if let vc = storyboard?.instantiateViewController(identifier: "ValidaitionViewController") as? ValidaitionViewController {
                //                                self.present(vc, animated: true, completion: nil)
                //                            }
                //
                //                }
                //                let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
                //                self.present(vc, animated: true, completion: nil)
                //
                if  let alllCollectionViewController = alertStoryBoard.instantiateViewController(withIdentifier:"MainStoreVC") as? MainStoreVC  {
                    controller = alllCollectionViewController
                }
                
            default:
                print("hello error")
                
            }
            
            addChild(controller)
            // Add the child's View as a subview
            firsttest.addSubview(controller.view)
            controller.view.frame = firsttest.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // tell the childviewcontroller it's contained in it's parent
            controller.didMove(toParent: self)
            
            
            
            
        }else{
            
            let id = storeSubModel[indexPath.row].id ?? 0
            UserDefaults.standard.set(id, forKey: "ADS_ID")
            let vc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
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
//



extension StoreVC:UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= storeSubModel.count - 1 && !isFeatchingData {
                
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
                        if self.storeSubModel.count == 0 {
                        self.Sectorcvvv.isHidden = true
                        self.errorHandeling.isHidden = false
                        }else{
                            self.Sectorcvvv.reloadData()
                            self.Sectorcvvv.isHidden = false
                            self.errorHandeling.isHidden = true
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
            FatchSearchOfStore()
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

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        FatchDataOfStore()
        searcBarView.text = ""
        hud.dismiss()
        print("cancellllld")
    }
}
