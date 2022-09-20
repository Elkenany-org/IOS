//
//  MagazineHomeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import UIKit
import JGProgressHUD
import ProgressHUD

class MagazineHomeVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var sectorsCV: UICollectionView!
    @IBOutlet weak var magazineCollection: UICollectionView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var toFilter: UIButton!
    @IBOutlet weak var toSearch: UIButton!
    @IBOutlet weak var magazinTV: UITableView!
    @IBOutlet weak var sortTtle: UIButton!
    @IBOutlet weak var cityTitle: UIButton!
    @IBOutlet weak var countryTitle: UIButton!
    
    //vars
    var magazineHomeModel:MagazineS?
    var sectorSubModelMagazine:[Sectorrs] = []
    var magazinSubModel:[magazinesData] = []
    
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    var typeOfSectore = "poultry"
    var typeHeader = ""
    
    //viewDidload
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
        sectorsCV.delegate = self
        sectorsCV.dataSource = self
        magazineCollection.delegate = self
        magazineCollection.dataSource = self
        
        self.sectorsCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.magazineCollection.register(UINib(nibName: "MagazineCell", bundle: nil), forCellWithReuseIdentifier: "MagazineCell")

        magazineCollection.prefetchDataSource = self
        //Dynamice Hight cell
//        magazinTV.estimatedRowHeight = 150
//        magazinTV.rowHeight = UITableView.automaticDimension
    }
    
    
    
    func FeatchDataOfectores(){
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "\(self.typeOfSectore)"  ]
            let companyGuide = "https://elkenany.com/api/magazine/magazines?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (SuccessfulRequest:MagazineS?, FailureRequest:MagazineS?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    let successDataSectore = SuccessfulRequest?.data?.sectors?.reversed() ?? []
                    self.sectorSubModelMagazine.append(contentsOf: successDataSectore)
                    DispatchQueue.main.async {
                        self.sectorsCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func FatchDatafromHome(){
        
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
//        ProgressHUD.animationType = .circleStrokeSpin
//        ProgressHUD.show(icon:.bolt )
//        ProgressHUD.show(icon: .rotate)
        ProgressHUD.show("", icon: .succeed, interaction: true)
//        ProgressHUD.show(icon: <#T##AnimatedIcon#>)
//        ProgressHUD.imageSuccess = UIImage(named: "success.png") ?? ""
//        ProgressHUD.show

//        ProgressHUD.show

        


        DispatchQueue.global(qos: .background).async {
            let param = ["type": "\(self.typeOfSectore)"  ,"sort" : "2" , "page": "\(self.currentpaga)"]
            let companyGuide = "https://elkenany.com/api/magazine/magazines?type=&sort=&page="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) {
                (success:MagazineS?, filier:MagazineS?, error) in
                //internet error
                if let error = error{
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

                    
                    let successDataa = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.magazinSubModel.append(contentsOf: successDataa)
                    DispatchQueue.main.async {
                        self.magazineCollection.reloadData()
                    }
                    
                    if self.currentpaga <= self.magazineHomeModel?.data?.lastPage ?? 0 {
                        self.currentpaga += 1

                    }
//                    self.currentpaga += 1

                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    
    func FatchDatafromHomeHeader(){
        
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin

        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "\(self.typeOfSectore)"   ,"sort" : "0"]
            let companyGuide = "https://elkenany.com/api/magazine/magazines?type=&sort="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) {
                (success:MagazineS?, filier:MagazineS?, error) in
                //internet error
                if let error = error{
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
                    self.magazinSubModel.removeAll()
                    let successDataa = success?.data?.data ?? []
                    self.magazinSubModel.append(contentsOf: successDataa)
                    
                    DispatchQueue.main.async {
                        self.magazineCollection.reloadData()
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
        let param = ["type": "\(self.typeOfSectore)" , "search" : self.searchBar.text ?? ""]
        DispatchQueue.global(qos: .background).async {
            let SearchGuide = "https://elkenany.com/api/magazine/magazines?type=&search="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: nil, method: .get) { (success:MagazineS?, filier:MagazineS?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.magazinSubModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.magazinSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.magazineCollection.reloadData()
                    }
                }
            }
        }
    }
    
    
    //MARK: to Main Filter
    @IBAction func SortBTN(_ sender: Any) {
        if let magazineMainFilter = storyboard?.instantiateViewController(identifier: "FilterMainVC") as? FilterMainVC {
            magazineMainFilter.filterShowMagzzineDeleget = self
            self.present(magazineMainFilter, animated: true, completion: nil)
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
            let data = magazineHomeModel?.data?.data ?? []
            //your array
            magazinSubModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            magazinSubModel.removeAll()
            //Api func
            SearchService()
        }
        //reload
        magazineCollection.reloadData()
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
              magazinSubModel.removeAll()
        FatchDatafromHome()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        hud.dismiss()
    }}




//MARK:pagination extension
extension MagazineHomeVC:UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.item >= magazinSubModel.count - 1 && !isFeatchingData {
                FatchDatafromHome()
                break
            }
        }
    }
}












//MARK:- TableView for companies  [Methods + Delegets]

extension MagazineHomeVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == sectorsCV {
            return sectorSubModelMagazine.count
        }else{
            return magazinSubModel.count
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sectorsCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
            cell.titleLabel.text = sectorSubModelMagazine[indexPath.item].name ?? ""
            if typeOfSectore == "poultry" {
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                sectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            }else{
                cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            }
            return cell
            
        }else{
            let magazineecell = collectionView.dequeueReusableCell(withReuseIdentifier: "MagazineCell", for: indexPath) as! MagazineCell
            magazineecell.magazineName.text = magazinSubModel[indexPath.row].name ?? ""
            magazineecell.descriptionnn.text = magazinSubModel[indexPath.row].desc ?? ""
            magazineecell.locName.text = magazinSubModel[indexPath.row].address ?? ""
            magazineecell.ratingView.rating = magazinSubModel[indexPath.row].rate ?? 0.0
            let imageee = magazinSubModel[indexPath.row].image ?? ""
            magazineecell.magazineImage.contentMode = .scaleAspectFit
            magazineecell.configureCell(image:imageee)
//            magazineecell.selectionStyle = .none
            
            return magazineecell
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == sectorsCV {
            let sizeOne = (collectionView.frame.size.width - 35 ) / 5
            return CGSize(width:sizeOne, height: 55)
            
        }else{
            let sizeTwo = (collectionView.frame.size.width - 20)
            return CGSize(width:sizeTwo, height: 160)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == sectorsCV {
            let typeOfSector = sectorSubModelMagazine[indexPath.item].type ?? "farm"
            print("type ::: " , typeOfSector)
            UserDefaults.standard.set(typeOfSector, forKey: "TYPE_FOR_FILTER")
            self.typeOfSectore = typeOfSector
            
            let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
            if(cell.isSelected == true)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                sectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            }
            FatchDatafromHomeHeader()
        }
        
        else{
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "MagazinVC") as? MagazinVC {
                let id_magazin = magazinSubModel[indexPath.row].id ?? 0
                vc.IdFromMagazine = id_magazin
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
}

extension MagazineHomeVC: FilterShowMagazine {
    
    func runFilterShow() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        let sec_type = UserDefaults.standard.string(forKey: "FILTER_SEC_TYPE")
        let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
        let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
        let coun_title = UserDefaults.standard.string(forKey: "COUN_TITLE")
        let sort_title = UserDefaults.standard.string(forKey: "SORT_TITLE")
        
        
        let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")
        
        let param = ["type": "\(sec_type ?? "horses")" ,  "country_id" : "\(coun_id ?? "1")" , "sort" : "\(sort_val ?? "1")"]
        
        
        DispatchQueue.global(qos: .background).async {
            let SearchGuide = "https://elkenany.com/api/magazine/magazines?type=&sort=&country_id="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: nil, method: .get) { (success:MagazineS?, filier:MagazineS?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.magazinSubModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.magazinSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        if success?.data?.data?.isEmpty == true {
                            print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
                        }
                        
                        self.magazineCollection.reloadData()
                        print(success?.data ?? "")
                        self.countryTitle.setTitle( coun_title, for: .normal)
                        self.sortTtle.setTitle(sort_title, for: .normal)
                    }
                }
            }
        }
        
        
    }
    
    
}
