//
//  searchVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/13/22.
//

import UIKit
import JGProgressHUD

class searchVC: UIViewController {
    //Outlet
    @IBOutlet weak var searchTVV: UITableView!
    @IBOutlet weak var searchBaView: UISearchBar!
    //Varas
    var SearchModelMain : SearchMainModel?
    var searchSubModelMain: [SearchResultian] = []
    
    
    //didload 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBaView.barTintColor = .white
        setupSearchBar()
        setupUI()
        searchTVV.estimatedRowHeight = 150
        searchTVV.rowHeight = UITableView.automaticDimension
        searchBaView.searchTextField.backgroundColor = .white

    
    }
    
    //setup tableview
    func setupUI() {
        searchTVV.dataSource = self
        searchTVV.delegate = self
        searchTVV.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
    
    //MARK: featch data of search
    func featchDataOfSearch(){
        let param = ["search": self.searchBaView?.text ?? "" ]
        let searchURL = "https://elkenany.com/api/search-all?search="
        DispatchQueue.global(qos: .background).async {
            APIServiceForQueryParameter.shared.fetchData(url: searchURL, parameters: param, headers: nil, method: .get) { (success:SearchMainModel?, filier:SearchMainModel?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "")")
                }
            
                else {
                    let successDataSearch = success?.data?.result ?? []
                    self.searchSubModelMain.append(contentsOf: successDataSearch)
                    DispatchQueue.main.async {
                        self.searchTVV.reloadData()
                    }
                }
            }
        }
    }
    
}


//MARK: Setup SearchBar

extension searchVC : UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBaView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            //your model
            let data = SearchModelMain?.data?.result ?? []
            //your array
            searchSubModelMain = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            searchSubModelMain.removeAll()
            //Api func
            featchDataOfSearch()
        }
        //reload
        searchTVV.reloadData()
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchSubModelMain.removeAll()
    }
    
    
    
    

}

//MARK:- CollectionView [Methods + Delegets]
extension searchVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSubModelMain.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Companiescell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        Companiescell.searchResult.text = searchSubModelMain[indexPath.row].name ?? "search test"
        return Companiescell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          let type = searchSubModelMain[indexPath.row].type ?? ""
        switch type {
        case "companies":
            let newsvc = (storyboard?.instantiateViewController(identifier: "companyDetails"))! as companyDetails
            newsvc.CompanyIdFromCompanies = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FeatchCompanyHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
            
        case "guide_sub_sections":
            let newsvc = (storyboard?.instantiateViewController(identifier: "CompaniesVC"))! as CompaniesVC
            newsvc.sub_id_home_search = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FatchDatafromHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "news":
            let newsvc = (storyboard?.instantiateViewController(identifier: "NewsDetailsVC"))! as NewsDetailsVC
            newsvc.id_home_search = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FatchDataOfNewsDetailsFromHomeSearch()
            navigationController?.pushViewController(newsvc, animated: true)
            
            
        case "stores":
            let newsvc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
            newsvc.ads_id = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.fetchAdsDetails()
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "showes":
            let newsvc = (storyboard?.instantiateViewController(identifier: "showDetailsVC"))! as showDetailsVC
            let homeShowId = searchSubModelMain[indexPath.row].id ?? 0
//            newsvc.tillllle = searchSubModelMain[indexPath.row].name ?? ""
            UserDefaults.standard.set(searchSubModelMain[indexPath.row].name ?? "", forKey: "TitleSerch")
            newsvc.idS = homeShowId
            newsvc.presentKeyHome = "searchHome"
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "magazines":
            let newsvc = (storyboard?.instantiateViewController(identifier: "MagazinVC"))! as MagazinVC
            newsvc.IdFromMagazine = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FeatchCMagazineDetails()
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "local_stock_sub":
            let newsvc = (storyboard?.instantiateViewController(identifier: "BorsaDetails"))! as BorsaDetails
            newsvc.loc_id = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FatchLocalBorsa()
            navigationController?.pushViewController(newsvc, animated: true)
            
        case "fodder_stock_sub":
            
            let newsvc = (storyboard?.instantiateViewController(identifier: "FodderBorsa"))! as FodderBorsa
            newsvc.fodderID = searchSubModelMain[indexPath.row].id ?? 0
            newsvc.FatchLocalBorsaFodder()
            navigationController?.pushViewController(newsvc, animated: true)
            
        default:
            print("hellllo world . .. . ")
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
