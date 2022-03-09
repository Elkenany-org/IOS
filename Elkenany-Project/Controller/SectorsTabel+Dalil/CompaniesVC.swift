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
    
    
    
    //Outlets and Propreties  ------------------------------
    var companiesModel:CompaniesDataModel?
    private var currentpaga = 1
    var isFeatchingImage = false
    var subID_fromGuideHome = 0
    var companyTitle = ""
    private var mainDataModel: [MainData] = []
    var modelTestSearch:MainData?
    //---
    private var isFeatchingData = false
    
    @IBOutlet weak var logoImageTwo: UIImageView!
    @IBOutlet weak var logoImageOne: UIImageView!
    @IBOutlet weak var comapniesTView: UITableView!
    @IBOutlet weak var logosCV: UICollectionView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var SearchTF: UITextField!
    @IBOutlet weak var searchBarView: UISearchBar!
    
    //ViewDidLoad ----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = companyTitle
        FatchDatafromHome()
        //Dynamice Hight cell
        comapniesTView.estimatedRowHeight = 150
        comapniesTView.rowHeight = UITableView.automaticDimension
        setupSearchBar()

        
    }
    
    
    //ViewWillApper ----------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("teeeeeeeest", subID_fromGuideHome)
        
        
    }
    
 
    //MARK:- Data of Companies ---------------------------
    func FatchDatafromHome(){
        //Handeling Loading view progress
        //        let hud = JGProgressHUD(style: .dark)
        //        hud.textLabel.text = "جاري التحميل"
        //        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let param = ["sub_id": self.subID_fromGuideHome , "page": self.currentpaga]
            print("this para", param)
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
            print("URL", companyGuide)
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                
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
                        
                        self.comapniesTView.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    

    func FatchDatafromHomeUsingRecomindition(){
        //Handeling Loading view progress
        //        let hud = JGProgressHUD(style: .dark)
        //        hud.textLabel.text = "جاري التحميل"
        //        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let id_rec = UserDefaults.standard.value(forKey: "REC_Id_Com") ?? ""

            let param = ["sub_id": id_rec , "page": self.currentpaga]
            print("this para", param)
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
            print("URL", companyGuide)
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                
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
                        
                        self.comapniesTView.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    func FatchDatafromHomeUsingDalil(){
        //Handeling Loading view progress
        //        let hud = JGProgressHUD(style: .dark)
        //        hud.textLabel.text = "جاري التحميل"
        //        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let id_rec_dali = UserDefaults.standard.value(forKey: "REC_Id_Dalil") ?? ""

            let param = ["sub_id": id_rec_dali , "page": self.currentpaga]
            print("this para", param)
            let companyGuide = "https://elkenany.com/api/guide/sub-section?sub_id=&page="
            print("URL", companyGuide)
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                
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
                        
                        self.comapniesTView.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    //MARK:- search Service of Companies ---------------------------
    
    func SearchService(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
//        let searchValue = SearchTF.text ?? ""

        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
            let param = ["sub_id": "\(self.subID_fromGuideHome)" , "search" : self.searchBarView.text ?? ""]

            let SearchGuide = "https://elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id&city_id&sort&search="

            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
//                    guard let success = success else {return}
                    let successData = success?.data?.data ?? []
//                    print("current", self.currentpaga)
                    self.mainDataModel.append(contentsOf: successData)
//                    self.mainDataModel = success
                    DispatchQueue.main.async {
                        self.comapniesTView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    //SetupUI + collection view delegete ----------------------
    func setupUI() {
        comapniesTView.dataSource = self
        comapniesTView.delegate = self
        comapniesTView.register(UINib(nibName: "companiesCell", bundle: nil), forCellReuseIdentifier: "companiesCell")
        comapniesTView.prefetchDataSource = self
    }
    
    
    @IBAction func SearchBTN(_ sender: Any) {
        SearchService()
        self.comapniesTView.reloadData()

    }
    
    
    @IBAction func SortBTN(_ sender: Any) {
        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterMain") as? subFilterMain {
            SectionVC.filterDelegete = self
            self.present(SectionVC, animated: true, completion: nil)
        }
    }
    
    
    
    //hide Search ----------------------
   
    
    
    //Show Search ----------------------
    @IBAction func showSearchView(_ sender: Any) {
        SearchView.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
        
    }
    
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
        return 315
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "companyDetails"))! as companyDetails
        let idd = mainDataModel[indexPath.row].id
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

        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchView.isHidden = true
        view1.isHidden = false
        view2.isHidden = false
        mainDataModel.removeAll()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        FatchDatafromHome()
        hud.dismiss()
      
    }
    
}

extension CompaniesVC:FilterSubData{

    
    
    func runFilter() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
//        let searchValue = SearchTF.text ?? ""
      
        let sec_id = UserDefaults.standard.string(forKey: "FILTER_SEC_ID")
        let sub_id = UserDefaults.standard.string(forKey: "FILTER_SUB_ID")
        let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
        let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
        let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")

        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
          
            let headers = ["Authorization": "\(api_token ?? "")" ]
            print("this is token\(api_token ?? "")")
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
