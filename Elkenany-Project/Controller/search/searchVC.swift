//
//  searchVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/13/22.
//

import UIKit
import JGProgressHUD

class searchVC: UIViewController {
    
    @IBOutlet weak var searchTVV: UITableView!
    @IBOutlet weak var searchBaView: UISearchBar!
    ///------
//    var companiesModel: SearchDataModell?
//    private var mainDataModel: [ResultSearch] = []
//
//
    
    var SearchModel : SearchDataModell?
    var searchSubModel: [ResultSearch] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBaView.barTintColor = .white
        setupSearchBar()
        setupUI()
        searchTVV.estimatedRowHeight = 150
        searchTVV.rowHeight = UITableView.automaticDimension
    
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        ///tooooooost
//        let messageVC = UIAlertController(title: "تنبية", message: "هذاالقسم غير متاح حاليا" , preferredStyle: .actionSheet)
//        present(messageVC, animated: true) {
//                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (_) in
//                            messageVC.dismiss(animated: true, completion: nil)})}
//    }
//
    func featchDataOfSearch(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let param = ["search": self.searchBaView?.text ?? "" ]

//        let resulttt = searchBaView?.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let searchURL = "https://elkenany.com/api/search-all?search="
            APIServiceForQueryParameter.shared.fetchData(url: searchURL, parameters: param, headers: nil, method: .get) { (success:SearchDataModell?, filier:SearchDataModell?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "")")
                }
                
                
                else {
                    hud.dismiss()
                    let successData = success?.data?.result ?? []
                    self.searchSubModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.searchTVV.reloadData()
                        print(self.SearchModel?.data?.result ??  "")
                        
                    }
                }
            }
        }
    }
    
    
    func setupUI() {
        searchTVV.dataSource = self
        searchTVV.delegate = self
        searchTVV.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
}

extension searchVC : UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBaView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = SearchModel?.data?.result ?? []
            //your array
            searchSubModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            self.searchSubModel.removeAll()
            
            
            //Api func
            featchDataOfSearch()
        }
        
        //reload
        searchTVV.reloadData()
        
    }
    
//
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//        let messageVC = UIAlertController(title: "Message Title", message: "Account Created successfully" , preferredStyle: .actionSheet)
//        present(messageVC, animated: true) {
//                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
//                            messageVC.dismiss(animated: true, completion: nil)})}
//    }
    
//
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        }
    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchSubModel.removeAll()
//
//        searchBaView.text = ""
//        print("cancellllld")
//    }
    
}

//MARK:- CollectionView [Methods + Delegets]
extension searchVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSubModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Companiescell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        Companiescell.searchResult.text = searchSubModel[indexPath.row].name ?? "search test"
        return Companiescell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let type = searchSubModel[indexPath.row].type ?? ""
        switch type {
        case "companies":
            let newsvc = (storyboard?.instantiateViewController(identifier: "companyDetails"))! as companyDetails
            newsvc.CompanyIdFromCompanies = searchSubModel[indexPath.row].id ?? 0
            newsvc.FeatchCompanyHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
            
        case "guide_sub_sections":
            let newsvc = (storyboard?.instantiateViewController(identifier: "CompaniesVC"))! as CompaniesVC
            newsvc.sub_id_home_search = searchSubModel[indexPath.row].id ?? 0
            newsvc.FatchDatafromHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "news":
            let newsvc = (storyboard?.instantiateViewController(identifier: "NewsDetailsVC"))! as NewsDetailsVC
            newsvc.id_home_search = searchSubModel[indexPath.row].id ?? 0
            newsvc.FatchDataOfNewsDetailsFromHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
            
        case "stores":
            let newsvc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
            newsvc.ads_from_search = searchSubModel[indexPath.row].id ?? 0
            newsvc.fetchAdsDetailsFromHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
        default:
            print("hellllo world . .. . ")
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
