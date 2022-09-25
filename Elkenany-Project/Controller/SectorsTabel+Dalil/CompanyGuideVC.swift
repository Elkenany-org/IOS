//
//  CompanyGuideVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit
import Alamofire
import JGProgressHUD
import ProgressHUD

class CompanyGuideVC: UIViewController, SortTitle {
    func SortTitleBack(value: String) {
        filterTitle.setTitle(value, for: .normal)
    }
    
    
    //MARK:- Outlets && Proparites
    @IBOutlet weak var guideCompanyCV: UICollectionView!
    @IBOutlet weak var selectedSectorCV: UICollectionView!
    @IBOutlet weak var searchBarGuidView: UISearchBar!
    
    @IBOutlet weak var logosView: UIView!
    @IBOutlet weak var logosCollection: UICollectionView!
    @IBOutlet weak var bannersView: UIView!
    @IBOutlet weak var bannersCollection: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var saerchTF: UITextField!
    @IBOutlet weak var filterTitle: UIButton!
    ///sectore  Type From Home
    var sectoreTypeFromHome = "poultry"
    var sectoreTypeFromSelecteHeader = ""
    var sectorTypeFromRecomindition = "poultry"
    var companyGuideModel:GuideCompaniesDataModel?
    private var subModel: [SubSection] = []
    private var  sectorSubModel:[Sector] = []
    private var  bannersSubModel:[bannersMain] = []

    
    
    
    
    //ViewDidLoad-----------
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchGuidMainData()
        featchDataSelectors()
        setupUI()
        setupSearchBar()
        title = "الدليل"
//        filterTitle.setTitle("\(UserDefaults.standard.string(forKey: "TYPE_TIT_FILTER") ?? "الابجدي")", for: .normal)
    }
    
    //MARK:- Setup UI [ delegets + register nibs ]
    func setupUI() {
        selectedSectorCV.dataSource = self
        selectedSectorCV.delegate = self
        guideCompanyCV.dataSource = self
        guideCompanyCV.delegate = self
        bannersCollection.dataSource = self
        bannersCollection.delegate = self
        logosCollection.dataSource = self
        logosCollection.delegate = self
        self.selectedSectorCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.guideCompanyCV.register(UINib(nibName: "GuideCompanyCell", bundle: nil), forCellWithReuseIdentifier: "GuideCompanyCell")
        self.bannersCollection.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.logosCollection.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")


    }
    
    
    
    
    //MARK:- Featch sectors
    func featchDataSelectors(){
        let api_token = String(UserDefaults.standard.string(forKey: "API_TOKEN") ?? "")
        let sectorsUrl = "https://elkenany.com/api/guide/section/?type=farm&sort="
        let headers:HTTPHeaders = ["app-id": api_token ]
        APIService.shared.fetchData(url: sectorsUrl , parameters: nil, headers: headers, method: .get) {[weak self] (NewsSuccess:GuideCompaniesDataModel?, NewsError:GuideCompaniesDataModel?, error) in
            guard let self = self else {return}
            if let error = error{
                print("error ===========================")
                print(error.localizedDescription)
            }else{
                let successData = NewsSuccess?.data?.sectors?.reversed() ?? []
                self.sectorSubModel.append(contentsOf: successData)
                DispatchQueue.main.async {
                    self.selectedSectorCV.reloadData()
                }
            }
        }
    }
    
    
    //MARK:- featch Main Data of the Guide at Main Collection view and sectors at header
    
    func FatchGuidMainData(){
        //Handeling Loading view progress
        
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.show("", icon: .succeed, interaction: true)
        ProgressHUD.animationType = .circleStrokeSpin

        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "\(self.sectoreTypeFromHome)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/guide/section/?type=&sort=&search="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (SuccessfulRequest:GuideCompaniesDataModel?, FailureRequest:GuideCompaniesDataModel?, error) in
                if let error = error{
//                    hud.dismiss()
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
//                    hud.dismiss()
                    ProgressHUD.dismiss()

                    self.subModel.removeAll()
                    self.bannersSubModel.removeAll()

                    let successData = SuccessfulRequest?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    
                    let successDataBannerss = SuccessfulRequest?.data?.banners ?? []
                    self.bannersSubModel.append(contentsOf: successDataBannerss)
                    DispatchQueue.main.async {
                        
                        if SuccessfulRequest?.data?.banners?.isEmpty == true {
                            self.bannersView.isHidden = true
                            self.guideCompanyCV.reloadData()
                            
                        }

                        else{
                            
                            self.bannersView.isHidden = false
                            self.bannersCollection.reloadData()
                            self.guideCompanyCV.reloadData()
                        }
                        
                        
                        
                        
                        
                        
                    }
                }
            }
        }
    }
    
    
    //MARK:- featch Main Data of the Guide at Main Collection view from recomindition at home
    func FatchGuidMainDataFromRecomindition(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "\(self.sectorTypeFromRecomindition)" ]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/guide/section/?type=&sort=&search="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:GuideCompaniesDataModel?, filier:GuideCompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successData = success?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.guideCompanyCV.reloadData()
                        self.selectedSectorCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    //MARK:- featch Main Data of the Guide by the selsected from header of Sectors
    func FatchDataOfMainGuideBySelecteddddd(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let param = ["type": "\(self.sectoreTypeFromHome)"]
            print("ppppp", param)
            let headers = ["Authorization": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/guide/section/?type="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:GuideCompaniesDataModel?, filier:GuideCompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.subModel.removeAll()
                    let successData = success?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
                        self.guideCompanyCV.reloadData()
                        print(self.companyGuideModel?.data?.subSections ?? "")
                    }
                }
            }
        }
    }
    
    
    func FatchGuidMainDataaaaaaaaa(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "poultry"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/guide/section/?type=&sort=&search="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (SuccessfulRequest:GuideCompaniesDataModel?, FailureRequest:GuideCompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successData = SuccessfulRequest?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.guideCompanyCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    
    func SearchServiceeeeee(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        //        let searchValue = SearchTF.text ?? ""
        let param = ["type": "\(self.sectoreTypeFromHome)" , "search" : self.searchBarGuidView.text ?? ""]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
            
            
            let SearchGuide = "https://elkenany.com/api/guide/section/?type=&search="
            
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:GuideCompaniesDataModel?, filier:GuideCompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successData = success?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.guideCompanyCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    //Filter Screen --------------
    @IBAction func filterShow(_ sender: Any) {
        if let filterVC = storyboard?.instantiateViewController(identifier: "FilterVC") as? FilterVC {
            filterVC.RunFilterDeleget = self
            filterVC.selectedType = sectoreTypeFromSelecteHeader
            filterVC.presentHomeFilter = "home"
            present(filterVC, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func toFilterShortCut(_ sender: Any) {
        
        if let filterVC = storyboard?.instantiateViewController(identifier: "FilterVC") as? FilterVC {
            filterVC.RunFilterDeleget = self
            filterVC.selectedType = sectoreTypeFromSelecteHeader
            filterVC.presentKey = "keeey"
            present(filterVC, animated: true, completion: nil)
        }

    }
    
    
    //show the search view  --------------
    @IBAction func searchBTN(_ sender: Any) {
        view1.isHidden = true
        view2.isHidden = true
        searchView.isHidden = false
        
    }
    
    //hide the search view  --------------
    @IBAction func hideSearchView(_ sender: Any) {
        view1.isHidden = false
        view2.isHidden = false
        searchView.isHidden = true
    }
    
    //Cell style --------------
    func SetupCell(cell:UICollectionViewCell){
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        
    }
    
}




//MARK:- Main Guide Collection + Sector collection
extension CompanyGuideVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Configuer Cells count in Views----------------
        if collectionView == selectedSectorCV {
            return sectorSubModel.count
        } else if collectionView == guideCompanyCV {
            return subModel.count
        } else if collectionView == bannersCollection {
            return bannersSubModel.count

        }else{
            return subModel.count
        }
    }
    
    
    //Configuer Cells in Views----------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //sectore Collection
        if collectionView == selectedSectorCV {
            if  let SectorHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as? SelectedSectorCell{
                SectorHeaderCell.titleLabel.text = sectorSubModel[indexPath.item].name ?? ""
                let typeOfSector = sectorSubModel[indexPath.item].type ?? ""

                
                if typeOfSector == sectoreTypeFromHome {
                    SectorHeaderCell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                    selectedSectorCV.selectItem(at: indexPath, animated: true, scrollPosition: .right)
                } else {
                    SectorHeaderCell.cooo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    
                }
                return SectorHeaderCell
            }
            
        } else if collectionView == guideCompanyCV  {
            
            //Guide Collection
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"GuideCompanyCell", for:indexPath ) as? GuideCompanyCell{
                SetupCell(cell: cell)
                cell.companyTitle.text = subModel[indexPath.item].name ?? ""
                if let imageC = subModel[indexPath.item].image{
                    cell.configureCell(image: imageC )
                }
                return cell
            }
        } else if collectionView == bannersCollection {
            //banners
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SliderCell", for:indexPath ) as? SliderCell{
                if let imageC = bannersSubModel[indexPath.item].image{
                    cell.configureCell(image: imageC )
                }
                return cell
                }
            
        } else{
    //logos
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SliderCell", for:indexPath ) as? SliderCell{
                if let imageC = subModel[indexPath.item].image{
                    cell.configureCell(image: imageC )
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    

    
    //Configuer Cells heights in Views ----------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == selectedSectorCV {
            
            return CGSize(width: 70 , height: 60)
            
        }else if collectionView == guideCompanyCV{
            
            let size = (collectionView.frame.size.width  )
            return CGSize(width: size, height: 100)
            
        } else if collectionView == bannersCollection {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height )

        }else{
            return CGSize(width: 75, height: 50)
            
        }
    }
    
    
    
    //Configuer Cells Selected in Views ----------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == selectedSectorCV {
            let typeOfSector = sectorSubModel[indexPath.item].type ?? ""
            self.sectoreTypeFromHome = typeOfSector
            UserDefaults.standard.set(typeOfSector, forKey: "TYPE_FOR_FILTER")

            if let cell = collectionView.cellForItem(at: indexPath) as? SelectedSectorCell{
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                selectedSectorCV.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            }
            FatchGuidMainData()
            
            
        }else if collectionView == guideCompanyCV{
            //push companies
            if let CompanyVC  =  storyboard?.instantiateViewController(identifier: "CompaniesVC") as? CompaniesVC {
                //passed companies
                let id = subModel[indexPath.item].id ?? 0
                CompanyVC.hideenKey = "kkk"
                let title = subModel[indexPath.item].name ?? ""
                CompanyVC.subID_fromGuideHome = id
                CompanyVC.companyTitle = title
                
                print("index vc " , indexPath.item)
                navigationController?.pushViewController(CompanyVC, animated: true)
            }
        }else{
            
            
            if let url = NSURL(string: "\(bannersSubModel[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
            
        }
    }
    
}



//MARK:- search view configuration

extension CompanyGuideVC : UISearchBarDelegate {
    func setupSearchBar() {
        searchBarGuidView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = companyGuideModel?.data?.subSections ?? []
            //your array
            subModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            subModel.removeAll()
            
            //Api func
            SearchServiceeeeee()
        }
        
        //reload
        guideCompanyCV.reloadData()
        
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
        subModel.removeAll()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        FatchGuidMainData()
        hud.dismiss()
    }
    
}


//MARK:- Filter extention 

extension CompanyGuideVC: FilterDone{
    
    func RunFilter(filter: ()) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("Token", api_token ?? "")
            let typeFilter = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER")
            let sortFilter = UserDefaults.standard.string(forKey: "SORT_FOR_FILTER")
            
            print(" is token\(api_token ?? "")")
            let param = ["type": "\(typeFilter ?? "")" , "sort": "\(sortFilter ?? "")"]
            print("new para" , param)
            let headers = ["Authorization": "Bearer \(api_token ?? "")"  ]
            let FilterGuide = "https://elkenany.com/api/guide/section/?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: FilterGuide, parameters: param, headers: headers, method: .get) { (success:GuideCompaniesDataModel?, filier:GuideCompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.subModel.removeAll()
                    
                    let successData = success?.data?.subSections ?? []
                    self.subModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.guideCompanyCV.reloadData()
                    

                        
                    }
                }
            }
        }
    }
    
    
}
