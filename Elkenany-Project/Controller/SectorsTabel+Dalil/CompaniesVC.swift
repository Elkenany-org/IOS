//
//  CompaniesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/10/21.
//

import UIKit
import  Alamofire
import JGProgressHUD
import ProgressHUD

class CompaniesVC: UIViewController{
    
    
    //MARK:- Outlets and Propreties
    //outlets
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var stackOne: UIStackView!
    @IBOutlet weak var logoImageTwo: UIImageView!
    @IBOutlet weak var logoImageOne: UIImageView!
    @IBOutlet weak var bannarsCV: UICollectionView!
    @IBOutlet weak var stackTwo: UIStackView!
    @IBOutlet weak var logosCV: UICollectionView!
    @IBOutlet weak var CompaniesCV: UICollectionView!
    @IBOutlet weak var logosView: UIView!
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var searchBarView: UISearchBar!
    //timer
    var timer:Timer?
    var startIndex: Int! = 1
    var currentIndex = 0
    //pagination
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    //models
    var companiesModel:CompaniesDataModel?
    private var mainDataModel: [MainData] = []
    var modelTestSearch:MainData?
    private var mainDatalLogos: [logsForCompany] = []
    private var mainDataModelBanners: [BannersForComapny] = []
    //variables
    var subID_fromGuideHome = 0
    var companyTitle = ""
    var hideenKey = ""
    var sub_id_home_search = 0
    
    
    
    //ViewDidLoad ----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = companyTitle
        FatchDatafromHome()
        setupSearchBar()
        LogosandBanners()
    }
    
    
    //MARK:- SetupUI + collectionView Delegete + tableView Delegete
    func setupUI() {
        
        logosCV.delegate = self
        logosCV.dataSource = self
        bannarsCV.delegate = self
        bannarsCV.dataSource = self
        CompaniesCV.delegate = self
        CompaniesCV.prefetchDataSource = self
        CompaniesCV.dataSource = self
        CompaniesCV.register(UINib(nibName: "CompaniesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CompaniesCollectionViewCell")
        logosCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        self.bannarsCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
    }
    
    
    
    //MARK:- Timer of slider and page controller ?? 0 -1
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MoveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func MoveToNextIndex(){
        if currentIndex < mainDataModelBanners.count {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        bannarsCV.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        //        pageControle.currentPage = currentIndex
    }
    
    
    
    //MARK:- Main Data of Companies [main]
    func FatchDatafromHome(){

        DispatchQueue.global(qos: .background).async {
            let param = ["sub_id": self.subID_fromGuideHome , "page" : self.currentpaga  ]
            let header = ["ios" : ""]
            let companyGuide = "https://admin.elkenany.com/api/guide/sub-section?sub_id=&page="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param,  headers: header , method: .get) {
                (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                //internet error
                if let error = error{
                    print("============ error \(error)")
                }
                //Data Wrong From Server
                
                else if let loginError = filier {

                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                //success
                else {
                    
                    ProgressHUD.dismiss()

                    if success?.data?.nextPageURL == nil {
                    }
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.CompaniesCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                    
                }
            }
        }
    }
    
    
    //MARK:- Main Data of Companies [main]
    func FatchDatafromHomeSearch(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let param = ["sub_id": self.sub_id_home_search , "page": self.currentpaga]
            let HomeSearchURL = "https://admin.elkenany.com/api/guide/sub-section?sub_id=&page="
            APIServiceForQueryParameter.shared.fetchData(url: HomeSearchURL, parameters: param, headers: nil, method: .get) {
                (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                //internet error
                if let error = error{
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                }
                //Data Wrong From Server
                
                else if let loginError = filier {
                    ProgressHUD.dismiss()

                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                //success
                else {
                    ProgressHUD.dismiss()

                    if success?.data?.nextPageURL == nil {
                    }
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.CompaniesCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    //MARK:- Main Data of Companies [from the dalil collection cell in home ]
    func FatchDatafromHomeUsingDalil(){
        DispatchQueue.global(qos: .background).async {
            let id_rec_dali = UserDefaults.standard.value(forKey: "REC_Id_Dalil") ?? ""
            let param = ["sub_id": id_rec_dali , "page": self.currentpaga]
            let companyGuide = "https://admin.elkenany.com/api/guide/sub-section?sub_id=&page="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                //internet error
                if let error = error{
                    print("============ error \(error)")
                }
                //Data Wrong From Server
                else if let loginError = filier {
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                //success
                else {
                    if success?.data?.nextPageURL == nil {
                    }
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.CompaniesCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    //MARK:- search Service of Companies
    func SearchService(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        let param = ["sub_id": "\(self.subID_fromGuideHome)" , "search" : self.searchBarView.text ?? ""]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
            let SearchGuide = "https://admin.elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id&city_id&sort&search="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    let successData = success?.data?.data ?? []
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.CompaniesCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    //MARK:- logos and banners service
    
    func LogosandBanners(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        let param = ["sub_id":"\(self.subID_fromGuideHome)"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            let SearchGuide = "https://admin.elkenany.com/api/guide/sub-section?sub_id=&page="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    let successDatalo = success?.data?.logos ?? []
                    self.mainDatalLogos.append(contentsOf: successDatalo)
                    let successDataban = success?.data?.banners ?? []
                    self.mainDataModelBanners.append(contentsOf: successDataban)
                    DispatchQueue.main.async {
                        
                        if self.mainDatalLogos.isEmpty == true && self.mainDataModelBanners.isEmpty == false {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = false
                            self.bannarsCV.reloadData()

                            
                        } else if self.mainDatalLogos.isEmpty == false && self.mainDataModelBanners.isEmpty == true {
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = true
                            self.logosCV.reloadData()

                        }else if self.mainDatalLogos.isEmpty == true && self.mainDataModelBanners.isEmpty == true {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = true

                        }else{
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = false
                            self.bannarsCV.reloadData()
                            self.logosCV.reloadData()
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    
    @IBAction func SortBTN(_ sender: Any) {
        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterMain") as? subFilterMain {
            SectionVC.filterDelegete = self
            self.present(SectionVC, animated: true, completion: nil)
        }}
    
    
    
    //Show Search ----------------------
    @IBAction func showSearchView(_ sender: Any) {
        SearchView.isHidden = false
        view1.isHidden = true
        view2.isHidden = true }
    
    
}







//MARK:- TableView for companies  [Methods + Delegets]

extension CompaniesVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == logosCV{ return mainDatalLogos.count}
        else if collectionView == bannarsCV{ return mainDataModelBanners.count }
        else{ return mainDataModel.count }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == logosCV{
            if let Logoscell = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as? logosCell{
                let imageeee = mainDatalLogos[indexPath.item].image ?? ""
                Logoscell.configureImage(image: imageeee)
                Logoscell.logooImage.contentMode = .scaleAspectFill
                return Logoscell
            }
            
            
            
        }
        
        
        else if collectionView == bannarsCV{
            if let BannersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell {
                let imageeee = mainDataModelBanners[indexPath.item].image ?? ""
                BannersCell.bannerImage.contentMode = .scaleAspectFill
                BannersCell.configureCell(image: imageeee)
                return BannersCell
            }
        } else{
            let CompanyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompaniesCollectionViewCell", for: indexPath) as! CompaniesCollectionViewCell
                CompanyCell.configureCell(data: mainDataModel[indexPath.row])
                if mainDataModel[indexPath.item].sponser == 1 {
                    CompanyCell.backgroundViewwww.backgroundColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
                    CompanyCell.companyLocation.textColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                    CompanyCell.companyName.textColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                } else{
                    
                    CompanyCell.backgroundViewwww.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    CompanyCell.companyLocation.textColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
                    CompanyCell.companyName.textColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
                    
                }
            
            
            
            
   
                return CompanyCell
                
            
        }
        return UICollectionViewCell()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == logosCV{
            if let url = NSURL(string: "\(mainDatalLogos[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
                    }
        
        else if collectionView == bannarsCV{
            if let url = NSURL(string: "\(mainDataModelBanners[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
                    }
        else{
            
            if let vc = (storyboard?.instantiateViewController(identifier: "companyDetails")) as? companyDetails{
                let idd = mainDataModel[indexPath.row].id
                UserDefaults.standard.set(idd, forKey: "IDDD")
                vc.keeeeeySS = "ss"
                vc.CompanyIdFromCompanies = idd ?? 0
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
        
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (collectionView.frame.size.width - 20 ) / 2
            if collectionView == logosCV{ return CGSize(width:70, height: 60)}
            else if collectionView == bannarsCV { return CGSize(width: collectionView.frame.width, height: 120)}
            else{ return CGSize(width: size, height: 210) }}
        
        
        
        
        
    }
    
    
    //pagination extension
    extension CompaniesVC:UICollectionViewDataSourcePrefetching{
        func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
            for index in indexPaths {
                if index.item >= mainDataModel.count - 1 && !isFeatchingData {
                    FatchDatafromHome()
                    break
                }
            }
        }
    }
    
    
    
    
    //MARK:- searchBAr delegets
    extension CompaniesVC : UISearchBarDelegate {
        func setupSearchBar() {
            searchBarView.delegate = self
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty == false {
                //your model
                let data = companiesModel?.data?.data ?? []
                //your array
                mainDataModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
                mainDataModel.removeAll()
                //Api func
                SearchService()
            }else{
                
                self.currentpaga = 1
                mainDataModel.removeAll()
                FatchDatafromHome()
            }
            //reload
            CompaniesCV.reloadData()
        }
        
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
                cBtn.setTitle("الغاء", for: .normal)
                searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
                searchBar.text = ""
            }}
        
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            SearchView.isHidden = true
            searchBar.text = ""
            view1.isHidden = false
            view2.isHidden = false
            mainDataModel.removeAll()
            
            self.currentpaga = 1
            FatchDatafromHome()
          
        }}
    
    
    extension CompaniesVC:FilterSubData{
        func runFilter() {
            //Handeling Loading view progress
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "جاري التحميل"
            hud.show(in: self.view)
            let sec_id = UserDefaults.standard.string(forKey: "FILTER_SEC_ID")
            let sub_id = UserDefaults.standard.string(forKey: "FILTER_SUB_ID")
            let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
            let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
            let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")
            
            
            DispatchQueue.global(qos: .background).async {
                let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
                let headers = ["Authorization": "\(api_token ?? "")" ]
                let param = ["section_id": "\(sec_id ?? "3")" , "sub_id" :  "\(sub_id ?? "63")" ,  "country_id" : "\(coun_id ?? "1")" , "city_id" : "\(city_id ?? "1")" , "sort" : "\(sort_val ?? "0")"]
                
                let SearchGuide = "https://admin.elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id=&city_id=&sort="
                APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                    if let error = error{
                        hud.dismiss()
                        print("============ error \(error)")
                    }else {
                        hud.dismiss()
                        self.mainDataModel.removeAll()
                        let successData = success?.data?.data ?? []
                        self.mainDataModel.append(contentsOf: successData)
                        DispatchQueue.main.async {
                            
                            if success?.data?.data?.isEmpty == true {
                                print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
                            }
                            
                            
                            
                            self.CompaniesCV.reloadData()
                        }
                    }
                }
            }
        }
        
    }



