//
//  NewsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/13/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class NewsVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var AllNews: UICollectionView!
    @IBOutlet weak var SelectedBySector: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var btnTitleee: UIButton!
    @IBOutlet weak var searchBarView: UISearchBar!
    //proparites
    var news:AllNewsDataModel?
    var typeOfSectors = "poultry"
    var typeFromhome = ""
    var subID_fromGuideHome = 0
    var subNewsModel:[Dataa] = []
    var seeectoresMo:[Section] = []
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        setupSearchBar()
        featchDataSelectors()
        FatchDataforNewsHome()
        title = "الآخبار"
    }
    
    
    //UI Configuration
    fileprivate func SetupUI() {
        SelectedBySector.delegate = self
        SelectedBySector.dataSource = self
        AllNews.delegate = self
        AllNews.dataSource = self
        AllNews.prefetchDataSource = self
        self.SelectedBySector.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.AllNews.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        
    }
    
    //MARK:- Data of sectores at home
    func featchDataSelectors(){
        let api_token = String(UserDefaults.standard.string(forKey: "API_TOKEN") ?? "")
        let sectorsUrl = "https://elkenany.com/api/news/news?type=farm&sort=&search="
        let headers:HTTPHeaders = ["app-id": api_token ]
        APIService.shared.fetchData(url: sectorsUrl , parameters: nil, headers: headers, method: .get) {[weak self] (NewsSuccess:AllNewsDataModel?, NewsError:AllNewsDataModel?, error) in
            guard let self = self else {return}
            if let error = error{
                print("error ===========================")
                print(error.localizedDescription)
            }else{
                self.news = NewsSuccess
                let succeeeesss = NewsSuccess?.data?.sections?.reversed() ?? []
                self.seeectoresMo.append(contentsOf: succeeeesss)
                print(NewsSuccess?.data?.sections ?? "")
                DispatchQueue.main.async {
                    self.SelectedBySector.reloadData()
                }
            }
        }
    }
    
    //MARK:- Data of all news at home screen
    func FatchDataforNewsHome(){
        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "\(self.typeFromhome)" , "sort": "\(1)" , "page" : "\(self.currentpaga)"]

            print("this para", param)
            let newsURL = "https://elkenany.com/api/news/news?type=&sort=&page="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: nil, method: .get) { (success:AllNewsDataModel?, filier:AllNewsDataModel?, error) in
                
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
                    self.subNewsModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.AllNews.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    //MARK:- Data of Companies ---------------------------
    func FatchDataforNewsHomeee(){
 
        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "\(self.typeFromhome)" , "sort" : "\(1)"]

            print("this para", param)
            let newsURL = "https://elkenany.com/api/news/news?type=&sort=&search="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: nil, method: .get) { (success:AllNewsDataModel?, filier:AllNewsDataModel?, error) in
                
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
                                        self.subNewsModel.removeAll()

                    let successData = success?.data?.data ?? []
                    print("current", self.currentpaga)
                    self.subNewsModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.AllNews.reloadData()
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    //MARK:- Data of all news from more vc

    
    func FatchDataforNewsHomeFromMore(){
 
        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "poultry"]

            print("this para", param)
            let newsURL = "https://elkenany.com/api/news/news?type=&sort=&search="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: nil, method: .get) { (success:AllNewsDataModel?, filier:AllNewsDataModel?, error) in
                
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
                    self.subNewsModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.AllNews.reloadData()
                    }
                    
                    if self.currentpaga <= self.news?.data?.lastPage ?? 0 {
                        self.currentpaga += 1

                    }
                    
                    self.isFeatchingData = false
                }
            }
        }
    }
    

    
    //MARK:- Data of all news searh bar

    func FatchSearchOfNews(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let saerchParamter = searchBarView.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let newsURL = "https://elkenany.com/api/news/news?type=&sort=&search="
            let param = ["type": "\(self.typeFromhome)", "search" : "\(saerchParamter)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:AllNewsDataModel?, filier:AllNewsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.subNewsModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.subNewsModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.AllNews.reloadData()
                        print("ggggggg")
                    }
                }
            }
        }
    }
    
    
    

    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 1, height: 1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.7
        ss.layer.masksToBounds = false
        
    }
    
    //filter conf
    @IBAction func filterNewsVC(_ sender: Any) {
        let filtervc = (storyboard?.instantiateViewController(identifier: "FilterVC"))! as FilterVC
        filtervc.RunFilterDeleget = self
        present(filtervc, animated: true, completion: nil)
        
    }
    
    //show and hiddin
    @IBAction func showSearchView(_ sender: Any) {
        searchView.isHidden = false
        view1.isHidden = true
        view2.isHidden = true
    }
    
    
    // filter conf fom shortcut
    @IBAction func filterHome(_ sender: Any) {
        let filtervc = (storyboard?.instantiateViewController(identifier: "FilterVC"))! as FilterVC
        filtervc.RunFilterDeleget = self
        filtervc.presentKey = "keeey"
        filtervc.presentHomeFilter = "home"
        present(filtervc, animated: true, completion: nil)
        
    }
    
}

//MARK:- news vc collection view

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == SelectedBySector {
            return seeectoresMo.count
            
        }else{
            return subNewsModel.count
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SelectedBySector {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
            
            cell1.titleLabel.text = seeectoresMo[indexPath.item].name ?? "test"
            let typeee = seeectoresMo[indexPath.item].type ?? ""
            
            if typeee == typeFromhome {
                cell1.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
                SelectedBySector.selectItem(at: indexPath, animated: true, scrollPosition: .right)
                
            }else{
                cell1.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            }
            return cell1
            
        }
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell2.newsTitle.text = subNewsModel[indexPath.item].title ?? ""
            cell2.newsDate.text = subNewsModel[indexPath.item].createdAt ?? ""
            if let newsImage = subNewsModel[indexPath.item].image {
                cell2.configureCell(image: newsImage)
            }
            
            ss(ss: cell2)
            return cell2
            
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == SelectedBySector {
            let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
            let typeOfSectorr = seeectoresMo[indexPath.row].type ?? ""
            UserDefaults.standard.set(typeOfSectorr, forKey: "TYPE_FOR_FILTER")

            self.typeFromhome = typeOfSectorr
            
            if(cell.isSelected == true)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
                SelectedBySector.selectItem(at: indexPath, animated: true, scrollPosition: .right)

                
            }
            FatchDataforNewsHomeee()
            
        }else{
            /// to details view controller
            let vc = storyboard?.instantiateViewController(identifier: "NewsDetailsVC") as! NewsDetailsVC
            navigationController?.pushViewController(vc, animated: true)
             let newsID = subNewsModel[indexPath.item].id ?? 0
                vc.newsIdFromHome = newsID
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectedSectorCell{
            
            if(cell.isSelected == false)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }
        }
    }
    
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == SelectedBySector {
            
            return CGSize(width: 70, height: 60)
            
        }else{
            
            return CGSize(width: 400, height: 120)
            
        }
    }
}




extension NewsVC:UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for index in indexPaths {
            if index.item >= subNewsModel.count - 1 && !isFeatchingData {
                
                FatchDataforNewsHome()
                break
                
            }
        }
    }
}



extension NewsVC:FilterDone {
    func RunFilter(filter: ()) {
        let typeFilter = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER")
        let sortFilter = UserDefaults.standard.string(forKey: "SORT_FOR_FILTER")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
           
            let param = ["type": "\(typeFilter ?? "")" ,  "search": "\(sortFilter ?? "" )" ]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let newsURL = "https://elkenany.com/api/news/news?type=&sort=&search="
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:AllNewsDataModel?, filier:AllNewsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.subNewsModel.removeAll()
                    let successData = success?.data?.data ?? []
                    self.subNewsModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        self.AllNews.reloadData()
                    }
                }
            }
        }
    }
}

extension NewsVC: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBarView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = news?.data?.data ?? []
            //your array
            subNewsModel = data.filter({ ($0.title?.contains(searchText) ?? (0 != 0)) })
            subNewsModel.removeAll()
            
            //Api func
            FatchSearchOfNews()
        }
        
        //reload
        AllNews.reloadData()
        
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
        subNewsModel.removeAll()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        FatchDataforNewsHome()
        searchBarView.text = ""
        hud.dismiss()
        print("cancellllld")
    }
}












