//
//  CompaniesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/10/21.
//

import UIKit
import  Alamofire
import JGProgressHUD

class CompaniesVC: UIViewController {
    
    //MARK:- Outlets and Propreties
    //outlets
    @IBOutlet weak var containerStack: UIStackView!
    @IBOutlet weak var stackOne: UIStackView!
    @IBOutlet weak var logoImageTwo: UIImageView!
    @IBOutlet weak var logoImageOne: UIImageView!
    @IBOutlet weak var bannarsCV: UICollectionView!
    @IBOutlet weak var stackTwo: UIStackView!
    @IBOutlet weak var comapniesTView: UITableView!
    @IBOutlet weak var logosCV: UICollectionView!
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
    
    
    
    //ViewDidLoad ----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = companyTitle
        FatchDatafromHome()
        setTimer()
        setupSearchBar()
        LogosandBanners()
        banersLogosConfig()
    }
    
    
    //MARK:- SetupUI + collectionView Delegete + tableView Delegete
    func setupUI() {
        comapniesTView.dataSource = self
        comapniesTView.delegate = self
        logosCV.delegate = self
        logosCV.dataSource = self
        bannarsCV.delegate = self
        bannarsCV.dataSource = self
        logosCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        self.bannarsCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        comapniesTView.register(UINib(nibName: "companiesCell", bundle: nil), forCellReuseIdentifier: "companiesCell")
        comapniesTView.prefetchDataSource = self
        //Dynamice Hight cell
        comapniesTView.estimatedRowHeight = 150
        comapniesTView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    //show and hide banners logos
    func banersLogosConfig(){
        if hideenKey == "kkk"{
        }else{
            containerStack.isHidden = false
            stackOne.isHidden = true
        }
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
            let param = ["sub_id": self.subID_fromGuideHome , "page": self.currentpaga]
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) {
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
                    if success?.data?.nextPageURL == nil {
                    }
                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.comapniesTView.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    //MARK:- Main Data of Companies [from recominditon cell in home ]
    func FatchDatafromHomeUsingRecomindition(){
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""
            let param = ["sub_id": id_rec , "page": self.currentpaga]
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
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
                        self.comapniesTView.reloadData()
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
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
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
                        self.comapniesTView.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    //MARK:- search Service of Companies
    func SearchService(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let param = ["sub_id": "\(self.subID_fromGuideHome)" , "search" : self.searchBarView.text ?? ""]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
            let SearchGuide = "https://elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id&city_id&sort&search="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successData = success?.data?.data ?? []
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.comapniesTView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func LogosandBanners(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        //        let searchValue = SearchTF.text ?? ""
        let param = ["sub_id":"\(self.subID_fromGuideHome)"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
            let SearchGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
            
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    //                    guard let success = success else {return}
                    //                    self.companiesModel = success
                    //                    self.mainDatalLogos.removeAll()
                    
                    let successDatalo = success?.data?.logos ?? []
                    //                    print("current", self.currentpaga)
                    self.mainDatalLogos.append(contentsOf: successDatalo)
                    
                    let successDataban = success?.data?.banners ?? []
                    //                    print("current", self.currentpaga)
                    self.mainDataModelBanners.append(contentsOf: successDataban)
                    DispatchQueue.main.async {
                        self.logosCV.reloadData()
                        self.bannarsCV.reloadData()
                        
                        print(self.mainDatalLogos.count ?? 0)
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func SearchBTN(_ sender: Any) {
        SearchService()
        self.comapniesTView.reloadData()
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



//MARK:- CollectionView [Methods + Delegets]
extension CompaniesVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDataModel.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let Companiescell = tableView.dequeueReusableCell(withIdentifier: "companiesCell") as! companiesCell
        Companiescell.selectionStyle = .none
        Companiescell.configureCell(data: mainDataModel[indexPath.row])
        return Companiescell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 316
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "companyDetails"))! as companyDetails
        let idd = mainDataModel[indexPath.row].id
        UserDefaults.standard.set(idd, forKey: "IDDD")
        vc.CompanyIdFromCompanies = idd ?? 0
        print("innnnnnnnnnnnnndex", indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension CompaniesVC:UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= mainDataModel.count - 1 && !isFeatchingData {
                FatchDatafromHome()
                break
            }
        }
    }
}



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
        }
        //reload
        comapniesTView.reloadData()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
            searchBar.text = ""
        }}
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchView.isHidden = true
        view1.isHidden = false
        view2.isHidden = false
        mainDataModel.removeAll()
        FatchDatafromHome()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        hud.dismiss()
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
            
            let SearchGuide = "https://elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id=&city_id=&sort="
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
                        self.comapniesTView.reloadData()
                    }
                }
            }
        }
    }
    
}


extension CompaniesVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == logosCV{
            return mainDatalLogos.count
        }else if collectionView == bannarsCV{
            return mainDataModelBanners.count
            
            
        }else{
            return 1
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == logosCV{
            let cellllll = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as! logosCell
            let imageeee = mainDatalLogos[indexPath.item].image ?? ""
            cellllll.configureImage(image: imageeee)
            cellllll.logooImage.contentMode = .scaleAspectFill
            //            cellllll.configureImage(image: imageeee )
            //            cellllll.configureImage(image: )
            return cellllll
            
        }else if collectionView == bannarsCV{
            let cellllll = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            let imageeee = mainDataModelBanners[indexPath.item].image ?? ""
            cellllll.bannerImage.contentMode = .scaleAspectFit
            
            
            cellllll.configureCell(image: imageeee)
            return cellllll
            
        }else{
            return UICollectionViewCell()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == logosCV{
            return CGSize(width:60, height: 60)
            
        }else if collectionView == bannarsCV{
            return CGSize(width: collectionView.frame.width, height: 120)
            
        }else{
            return CGSize(width: 50, height: 100)
            
            
        }
        
        
    }
    
    
    
    
}
