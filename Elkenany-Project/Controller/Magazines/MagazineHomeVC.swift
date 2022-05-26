//
//  MagazineHomeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import UIKit
import JGProgressHUD

class MagazineHomeVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var sectorsCV: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var toFilter: UIButton!
    @IBOutlet weak var toSearch: UIButton!
    @IBOutlet weak var magazinTV: UITableView!
    
    var MagazineModel:MagazineS?
    var sectorSubModel:[Sectorrs] = []
    var magazinSubModel:[magazinesData] = []
    
    
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDatafromHome()
        FeatchDataOfectores()
        setupUI()
        setupSearchBar()
        title = "دلائل والمجلات"
    }
    
    
    //MARK:- SetupUI + collectionView Delegete + tableView Delegete
    func setupUI() {
        magazinTV.dataSource = self
        magazinTV.delegate = self
        sectorsCV.delegate = self
        sectorsCV.dataSource = self
        
        self.sectorsCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        magazinTV.register(UINib(nibName: "companiesCell", bundle: nil), forCellReuseIdentifier: "companiesCell")
        magazinTV.prefetchDataSource = self
        //Dynamice Hight cell
        magazinTV.estimatedRowHeight = 150
        magazinTV.rowHeight = UITableView.automaticDimension
    }
    
    
    func FeatchDataOfectores(){
        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "farm"  , "page": "\(self.currentpaga)"]
            let companyGuide = "https://elkenany.com/api/magazine/magazines?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (SuccessfulRequest:MagazineS?, FailureRequest:MagazineS?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    let successDataSectore = SuccessfulRequest?.data?.sectors ?? []
                    self.sectorSubModel.append(contentsOf: successDataSectore)
                    DispatchQueue.main.async {
                        self.sectorsCV.reloadData()
                    }
                }
            }
        }
    }
    
    func FatchDatafromHome(){
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "farm"  , "page": "\(self.currentpaga)" ,"sort" : "2"]
            let companyGuide = "https://elkenany.com/api/magazine/magazines?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) {
                (success:MagazineS?, filier:MagazineS?, error) in
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
                    
                    let successDataa = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.magazinSubModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        self.magazinTV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    
    func SearchService(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let param = ["type": "farm" , "search" : self.searchBar.text ?? ""]
        DispatchQueue.global(qos: .background).async {
            let SearchGuide = "https://elkenany.com/api/magazine/magazines?type=&search="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: nil, method: .get) { (success:MagazineS?, filier:MagazineS?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    let successData = success?.data?.data ?? []
                    self.magazinSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.magazinTV.reloadData()
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
        searchView.isHidden = false
        view1.isHidden = true
        view2.isHidden = true }
    
    }


//MARK:- searchBAr delegets
extension MagazineHomeVC : UISearchBarDelegate {
    func setupSearchBar() {
        searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            //your model
            let data = MagazineModel?.data?.data ?? []
            //your array
            magazinSubModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            magazinSubModel.removeAll()
            //Api func
            SearchService()
        }
        //reload
        magazinTV.reloadData()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
            searchBar.text = ""
        }}
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.isHidden = true
        searchBar.text = ""
        view1.isHidden = false
        view2.isHidden = false
        //            magazinSubModel.removeAll()
        FatchDatafromHome()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        hud.dismiss()
    }}




//MARK:pagination extension
extension MagazineHomeVC:UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= sectorSubModel.count - 1 && !isFeatchingData {
                FatchDatafromHome()
                break
            }
        }
    }
}




//MARK:- TableView for companies  [Methods + Delegets]
extension MagazineHomeVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazinSubModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let Companiescell = tableView.dequeueReusableCell(withIdentifier: "companiesCell") as? companiesCell{
            Companiescell.companyName.text = magazinSubModel[indexPath.row].name ?? ""
            Companiescell.companyDesc.text = magazinSubModel[indexPath.row].desc ?? ""
            Companiescell.companyLocation.text = magazinSubModel[indexPath.row].address ?? ""
            Companiescell.rating.rating = magazinSubModel[indexPath.row].rate ?? 0.0
            let imageee = magazinSubModel[indexPath.row].image ?? ""
            Companiescell.companyImage.contentMode = .scaleAspectFit
            Companiescell.configureCellamagazan(image: imageee)
            Companiescell.selectionStyle = .none
            return Companiescell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 316
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MagazinVC") as? MagazinVC {
            let id_magazin = magazinSubModel[indexPath.row].id ?? 0
            vc.IdFromMagazine = id_magazin
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}




extension MagazineHomeVC:FilterSubData{
    func runFilter() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let sec_id = UserDefaults.standard.string(forKey: "FILTER_SEC_ID")
//        let sub_id = UserDefaults.standard.string(forKey: "FILTER_SUB_ID")
        let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
        let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
        let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")
        
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            let param = ["type": "farm",  "country_id" : "\(coun_id ?? "1")" , "city_id" : "\(city_id ?? "1")" , "sort" : "\(sort_val ?? "0")"]
            
            let SearchGuide = "https://elkenany.com/api/magazine/magazines?type=&sort=&city_id=&country_id="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:MagazineS?, filier:MagazineS?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else{
                    hud.dismiss()
                    self.magazinSubModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.magazinSubModel.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
//                        if success?.data?.data?.isEmpty == true {
//                            print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
//                        }
                        self.magazinTV.reloadData()
                    }
                }
            }
        }
    }
}


//MARK:- TableView for companies  [Methods + Delegets]

extension MagazineHomeVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectorSubModel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        cell.titleLabel.text = sectorSubModel[indexPath.item].name ?? ""
        
        let typeee = "poultry"
        
        if typeee == "poultry" {
            cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
            sectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            
        }else{
            cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 60)
        
    }
    
}


