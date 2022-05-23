//
//  MagazineHomeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import UIKit

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
    
    
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FatchDatafromHome()
        setupUI()
    }
    
    
    //MARK:- SetupUI + collectionView Delegete + tableView Delegete
    func setupUI() {
        magazinTV.dataSource = self
        magazinTV.delegate = self
        sectorsCV.delegate = self
        sectorsCV.dataSource = self

        self.sectorsCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        magazinTV.register(UINib(nibName: "companiesCell", bundle: nil), forCellReuseIdentifier: "companiesCell")
//        magazinTV.prefetchDataSource = self
        //Dynamice Hight cell
        magazinTV.estimatedRowHeight = 150
        magazinTV.rowHeight = UITableView.automaticDimension
    }


    
    
    func FatchDatafromHome(){
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "farm"  , "page": "\(self.currentpaga)"]
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
                    let successData = success?.data?.sectors ?? []
                    print("current", self.currentpaga)
                    self.sectorSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.sectorsCV.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    

//
//    func SearchService(){
//        //Handeling Loading view progress
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
//        let param = ["sub_id": "\(self.subID_fromGuideHome)" , "search" : self.searchBarView.text ?? ""]
//        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let headers = ["Authorization": "\(api_token ?? "")" ]
//            print("this is token\(api_token ?? "")")
//            let SearchGuide = "https://elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id&city_id&sort&search="
//            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
//                if let error = error{
//                    hud.dismiss()
//                    print("============ error \(error)")
//                }else {
//                    hud.dismiss()
//                    let successData = success?.data?.data ?? []
//                    self.mainDataModel.append(contentsOf: successData)
//                    DispatchQueue.main.async {
//                        self.comapniesTView.reloadData()
//                    }
//                }
//            }
//        }
//    }
    
    
//    @IBAction func SortBTN(_ sender: Any) {
//        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterMain") as? subFilterMain {
//            SectionVC.filterDelegete = self
//            self.present(SectionVC, animated: true, completion: nil)
//        }}
    
    
    
    
//    //Show Search ----------------------
//    @IBAction func showSearchView(_ sender: Any) {
//        SearchView.isHidden = false
//        view1.isHidden = true
//        view2.isHidden = true }
//
//
//}

    
    //MARK:- searchBAr delegets
//    extension CompaniesVC : UISearchBarDelegate {
//        func setupSearchBar() {
//            searchBarView.delegate = self
//        }
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            if searchText.isEmpty == false {
//                //your model
//                let data = companiesModel?.data?.data ?? []
//                //your array
//                mainDataModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
//                mainDataModel.removeAll()
//                //Api func
//                SearchService()
//            }
//            //reload
//            comapniesTView.reloadData()
//        }
//
//
//        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
//                cBtn.setTitle("الغاء", for: .normal)
//                searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
//                searchBar.text = ""
//            }}
//
//
//        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            SearchView.isHidden = true
//            searchBar.text = ""
//            view1.isHidden = false
//            view2.isHidden = false
//            mainDataModel.removeAll()
//            FatchDatafromHome()
//            let hud = JGProgressHUD(style: .dark)
//            hud.textLabel.text = "جاري التحميل"
//            hud.show(in: self.view)
//            hud.dismiss()
//        }}
//
//
    
    

}




//pagination extension
extension MagazineHomeVC:UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= sectorSubModel.count - 1 && !isFeatchingData {
//                FatchDatafromHome()
                break
            }
        }
    }
}



//MARK:- TableView for companies  [Methods + Delegets]
extension MagazineHomeVC:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let Companiescell = tableView.dequeueReusableCell(withIdentifier: "companiesCell") as? companiesCell{
            
        Companiescell.selectionStyle = .none
            return Companiescell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 316
    }


  
}



//
//extension CompaniesVC:FilterSubData{
//    func runFilter() {
//        //Handeling Loading view progress
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
//        let sec_id = UserDefaults.standard.string(forKey: "FILTER_SEC_ID")
//        let sub_id = UserDefaults.standard.string(forKey: "FILTER_SUB_ID")
//        let coun_id = UserDefaults.standard.string(forKey: "FILTER_COUN_ID")
//        let city_id = UserDefaults.standard.string(forKey: "FILTER_CITY_ID")
//        let sort_val = UserDefaults.standard.string(forKey: "FILTER_SORT_VAL")
//
//
//        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let headers = ["Authorization": "\(api_token ?? "")" ]
//            let param = ["section_id": "\(sec_id ?? "3")" , "sub_id" :  "\(sub_id ?? "63")" ,  "country_id" : "\(coun_id ?? "1")" , "city_id" : "\(city_id ?? "1")" , "sort" : "\(sort_val ?? "0")"]
//
//            let SearchGuide = "https://elkenany.com/api/guide/sub-section?section_id=&sub_id=&country_id=&city_id=&sort="
//            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:CompaniesDataModel?, filier:CompaniesDataModel?, error) in
//                if let error = error{
//                    hud.dismiss()
//                    print("============ error \(error)")
//                }else {
//                    hud.dismiss()
//                    self.mainDataModel.removeAll()
//                    let successData = success?.data?.data ?? []
//                    self.mainDataModel.append(contentsOf: successData)
//                    DispatchQueue.main.async {
//
//                        if success?.data?.data?.isEmpty == true {
//                            print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
//                        }
//
//
//
//                        self.comapniesTView.reloadData()
//                    }
//                }
//            }
//        }
//    }
//
//}


//MARK:- TableView for companies  [Methods + Delegets]

extension MagazineHomeVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 5
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        return cell

         }


    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 60)

    }

}


