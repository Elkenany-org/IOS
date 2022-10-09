//
//  showesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import UIKit
import ProgressHUD


class showesVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var csectorsCV: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var searchVieww: UIView!
    @IBOutlet weak var showesTableView: UITableView!
    @IBOutlet weak var ShowsortTitle: UIButton!
    @IBOutlet weak var ShowcityTitle: UIButton!
    @IBOutlet weak var ShowcountryTitle: UIButton!
    
    //MARK:Variables
    var showesModel:ShowesHome?
    var subShowesModel:[showesHomeData] = []
    var subSectoresModel:[SectorsSelection] = []
    var typeFromhome = "poultry"
    var typeForHeader = ""
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    
    //MARK:viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        featchDataSelectors()
//        FeatchDataShowesHome()
        setupSearchBar()
        SetupUI()
        title = "المعارض"
        //Dynamice Hight cell
//        showesTableView.estimatedRowHeight = 200
//        showesTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    //UI Configuration
    fileprivate func SetupUI() {
        csectorsCV.delegate = self
        csectorsCV.dataSource = self
        showesTableView.delegate = self
        showesTableView.dataSource = self
//        showesTableView.prefetchDataSource = self
        self.csectorsCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.showesTableView.register(UINib(nibName: "showesCell", bundle: nil), forCellReuseIdentifier: "showesCell")
    }
    
    
    //MARK: sectores
    func featchDataSelectors(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        let sectorsUrl = "https://elkenany.com/api/showes/all-showes?type=&sort="
        let param = ["type": "\(self.typeFromhome)" ]
        let headere = ["android": "" ]

        APIServiceForQueryParameter.shared.fetchData(url: sectorsUrl , parameters: param, headers:headere , method: .get) {[weak self] (NewsSuccess:ShowesHome?, NewsError:ShowesHome?, error) in
            guard let self = self else {return}
            if let error = error{
                ProgressHUD.dismiss()

                print("error ===========================")
                print(error.localizedDescription)
            }else{
                ProgressHUD.dismiss()

                let succeeeesss = NewsSuccess?.data?.sectors?.reversed() ?? []
                self.subSectoresModel.append(contentsOf: succeeeesss)
                
                let successData = NewsSuccess?.data?.data ?? []
                self.subShowesModel.append(contentsOf: successData)
                
                DispatchQueue.main.async {
                    self.csectorsCV.reloadData()
                    self.showesTableView.reloadData()

                }
            }
        }
    }
    
    
    //MARK:- Data of all showes at home screen
//    func FeatchDataShowesHome(){
//        DispatchQueue.global(qos: .background).async {
//            let param = ["type": "\(self.typeFromhome)" , "sort": "\(0)" , "page" : "\(self.currentpaga)"]
//            let newsURL = "https://elkenany.com/api/showes/all-showes?type=&sort=&page="
//            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: nil, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
//                if let error = error{
//                    //internet error
//                    print("============ error \(error)")
//                }
//                else if let loginError = filier {
//                    //Data Wrong From Server
//                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
//                }
//                else {
//                    if success?.data?.nextPageURL == nil {}
//                    let successData = success?.data?.data ?? []
//                    self.subShowesModel.append(contentsOf: successData)
//                    DispatchQueue.main.async {
//                        self.showesTableView.reloadData()
//                    }
//                    self.currentpaga += 1
//                    self.isFeatchingData = false
//                }
//            }
//        }
//    }
    
    
    //MARK:- Data of all showes at home screen
    func featchDataHeader(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        let sectorsUrl = "https://elkenany.com/api/showes/all-showes?type=&sort="
        let param = ["type": "\(self.typeFromhome)" ]
        let headere = ["android": "" ]

        APIServiceForQueryParameter.shared.fetchData(url: sectorsUrl , parameters: param, headers:headere , method: .get) {[weak self] (NewsSuccess:ShowesHome?, NewsError:ShowesHome?, error) in
            guard let self = self else {return}
            if let error = error{
                ProgressHUD.dismiss()

                print("error ===========================")
                print(error.localizedDescription)
            }else{
                ProgressHUD.dismiss()

                let successData = NewsSuccess?.data?.data ?? []
                self.subShowesModel.append(contentsOf: successData)
                
                DispatchQueue.main.async {
                    self.showesTableView.reloadData()

                }
            }
        }
    }
    
    
    //MARK:- Featch Search Of showes
    func FatchSearchOfNews(){
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        let saerchParamter = searchView.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let newsURL = "https://elkenany.com/api/showes/all-showes?type=&search="
            let param = ["type": "\(self.typeFromhome)", "search" : "\(saerchParamter)"]
            let headere = ["android": "" ]

            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headere, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    self.subShowesModel.removeAll()
                    let successDatae = success?.data?.data ?? []
                    self.subShowesModel.append(contentsOf: successDatae)
                    DispatchQueue.main.async {
                        self.showesTableView.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    //Cell style --------------
    func SetupCell(cell:UITableViewCell){
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        
    }
    
    
    
    
    //MARK: to Main Filter
    @IBAction func toFilter(_ sender: Any) {
        if let showMainFilterVC = storyboard?.instantiateViewController(identifier: "FilterMainVC") as? FilterMainVC {
            showMainFilterVC.filterShowMagzzineDeleget = self
            self.present(showMainFilterVC, animated: true, completion: nil)
        }
    }
    
    
    //search view display
    @IBAction func toSearch(_ sender: Any) {
        searchVieww.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
    }
    
    
    
    @IBAction func filterShortCut(_ sender: Any) {
        
    }
    
    @IBAction func countryFilters(_ sender: Any) {
        
    }
    
    
}


//
//extension showesVC:UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for index in indexPaths {
//            if index.item >= subShowesModel.count - 1 && !isFeatchingData {
//                FeatchDataShowesHome()
//                break
//            }
//        }
//    }
//}
//




//MARK: Search Cnfiguration
extension showesVC: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = showesModel?.data?.data ?? []
            //your array
            subShowesModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            subShowesModel.removeAll()
            
            //Api func
            FatchSearchOfNews()
        }
        
        //reload
        showesTableView.reloadData()
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchVieww.isHidden = true
        view1.isHidden = false
        view2.isHidden = false
        subShowesModel.removeAll()
        self.currentpaga = 1
//        FeatchDataShowesHome()
        print("cancellllld")
    }
}



extension showesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subSectoresModel.count
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        cell1.titleLabel.text = subSectoresModel[indexPath.item].name ?? "test"
        let typeee = "poultry"
        if typeee == "poultry" {
            cell1.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
            csectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            
        }else{
            cell1.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        }
        return cell1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
        let typeOfSectorr = subSectoresModel[indexPath.item].type ?? ""
        self.typeFromhome = typeOfSectorr
        UserDefaults.standard.set(typeOfSectorr, forKey: "TYPE_FILTER")
        if(cell.isSelected == true)
        {
            cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
            csectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
        featchDataHeader()
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectedSectorCell{
            if(cell.isSelected == false)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }}
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 60)
    }
    
}


//MARK:- TableView for companies  [Methods + Delegets]
extension showesVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subShowesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let showescell = tableView.dequeueReusableCell(withIdentifier: "showesCell") as? showesCell{
            showescell.showesName.text = subShowesModel[indexPath.row].name ?? ""
            showescell.countryName.text = subShowesModel[indexPath.row].address ?? ""
            showescell.showesDate.text = subShowesModel[indexPath.row].date ?? ""
            showescell.showesDescription.text = subShowesModel[indexPath.row].desc ?? ""
            showescell.showesView.text = String( subShowesModel[indexPath.row].viewCount ?? 0)
            let showImage = subShowesModel[indexPath.row].image ?? ""
            showescell.configureCell(image: showImage)
            showescell.selectionStyle = .none
            SetupCell(cell: showescell)
            return showescell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (storyboard?.instantiateViewController(identifier: "showVC")) as? showVC{
            let idd = subShowesModel[indexPath.row].id ?? 0
            UserDefaults.standard.set(idd, forKey: "IDDD")
            vc.acceptedId = idd
            vc.acceptedTitle = subShowesModel[indexPath.item].name ?? "" 
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}


//MARK:MainFlter 

extension showesVC: FilterShowMagazine {
    
    func runFilterShow() {
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        

        
        let sec_type = UserDefaults.standard.string(forKey: "FILTER_SEC_TYPE")
        let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
        let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
        let coun_title = UserDefaults.standard.string(forKey: "COUN_TITLE")
        let sort_title = UserDefaults.standard.string(forKey: "SORT_TITLE")
        let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")
        
        let param = ["type": "\(sec_type ?? "horses")" ,  "country_id" : "\(coun_id ?? "1")" , "sort" : "\(sort_val ?? "1")"]
        
        
        DispatchQueue.global(qos: .background).async {
            let SearchGuide = "https://elkenany.com/api/showes/all-showes?type=&city_id=&sort=&country_id="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: nil, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    self.subShowesModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.subShowesModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        if success?.data?.data?.isEmpty == true {
                            print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
                        }
                        
                        self.showesTableView.reloadData()
                        print(success?.data ?? "")
                        self.ShowcountryTitle.setTitle( coun_title, for: .normal)
                        self.ShowsortTitle.setTitle(sort_title, for: .normal)
                        
                        
                    }
                }
            }
        }
        
        
    }
    
    
}
