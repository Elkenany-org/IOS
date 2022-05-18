//
//  showesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/11/22.
//

import UIKit


class showesVC: UIViewController {

    //MARK:Outlets
    @IBOutlet weak var csectorsCV: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var searchVieww: UIView!
    @IBOutlet weak var showesTableView: UITableView!
    //MARK:Variables
    var showesModel:ShowesHome?
    var subShowesModel:[showesHomeData] = []
    var subSectoresModel:[SectorsSelection] = []
    var typeFromhome = ""
    private var currentpaga = 1
    var isFeatchingImage = false
    private var isFeatchingData = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featchDataSelectors()
        FatchDataforNewsHome()
        setupSearchBar()
        SetupUI()
        title = "المعارض"
        //Dynamice Hight cell
        showesTableView.estimatedRowHeight = 150
        showesTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    //UI Configuration
    fileprivate func SetupUI() {
        csectorsCV.delegate = self
        csectorsCV.dataSource = self
        showesTableView.delegate = self
        showesTableView.dataSource = self
        showesTableView.prefetchDataSource = self
        self.csectorsCV.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
//        self.showesTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        self.showesTableView.register(UINib(nibName: "showesCell", bundle: nil), forCellReuseIdentifier: "showesCell")
        
    
        
    }
    
    //MARK: sectores
    func featchDataSelectors(){
//        let api_token = String(UserDefaults.standard.string(forKey: "API_TOKEN") ?? "")
        ///urll
        let sectorsUrl = "https://elkenany.com/api/showes/all-showes?type=&sort="
//        let headers = ["app-id": api_token ]
        let param = ["type": "poultry" ]

        APIServiceForQueryParameter.shared.fetchData(url: sectorsUrl , parameters: param, headers: nil, method: .get) {[weak self] (NewsSuccess:ShowesHome?, NewsError:ShowesHome?, error) in
            guard let self = self else {return}
            if let error = error{
                print("error ===========================")
                print(error.localizedDescription)
            }else{
//                self.showesModel = NewsSuccess
                let succeeeesss = NewsSuccess?.data?.sectors ?? []
                self.subSectoresModel.append(contentsOf: succeeeesss)
                DispatchQueue.main.async {
                    self.csectorsCV.reloadData()
                }
            }
        }
    }
    
    
    //MARK:- Data of all news at home screen
    func FatchDataforNewsHome(){
        
        DispatchQueue.global(qos: .background).async {
            let param = ["type": "poultry" , "sort": "\(1)"]

            print("this para", param)
            let newsURL = "https://elkenany.com/api/showes/all-showes?type=&sort="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: nil, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
                
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
                    self.subShowesModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.showesTableView.reloadData()
                        print(success?.data?.data ?? "")
                    }
                    self.currentpaga += 1
                    self.isFeatchingData = false
                }
            }
        }
    }
    
    
    //MARK:- Data of all news searh bar

    func FatchSearchOfNews(){
        //Handeling Loading view progress
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
        let saerchParamter = searchView.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let newsURL = "https://elkenany.com/api/showes/all-showes?type=poultry&sort="
            let param = ["type": "poultry", "search" : "\(saerchParamter)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:ShowesHome?, filier:ShowesHome?, error) in
                if let error = error{
//                    hud.dismiss()
                    print("============ error \(error)")
                }else {
//                    hud.dismiss()
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func toFilter(_ sender: Any) {
    }
    
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



extension showesVC:UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.item >= subShowesModel.count - 1 && !isFeatchingData {
                
                FatchDataforNewsHome()
                break
                
            }
        }
    }
}



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
            FatchDataforNewsHome()
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
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
        FatchDataforNewsHome()
//        searchBarView.text = ""
//        hud.dismiss()
        print("cancellllld")
    }
}



extension showesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subSectoresModel.count
    
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        
        cell1.titleLabel.text = subSectoresModel[indexPath.row].name ?? "test"
        let typeee = subSectoresModel[indexPath.item].type ?? ""
        
        if typeee == typeFromhome {
            cell1.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
            csectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            
        }else{
            cell1.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        }
        return cell1
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
        let typeOfSectorr = subSectoresModel[indexPath.row].type ?? ""
        UserDefaults.standard.set(typeOfSectorr, forKey: "TYPE_FOR_FILTER")

        let vc = storyboard?.instantiateViewController(withIdentifier: "showVC" ) as! showVC
        navigationController?.pushViewController(vc, animated: true)
        
        
        
        self.typeFromhome = typeOfSectorr
        
        if(cell.isSelected == true)
        {
            cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
            csectorsCV.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        
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
  
        return CGSize(width: 100, height: 60)

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
            showescell.configureRating(ddd: subShowesModel[indexPath.row])
            showescell.selectionStyle = .none
            return showescell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (storyboard?.instantiateViewController(identifier: "companyDetails")) as? companyDetails{
            let idd = subShowesModel[indexPath.row].id
            UserDefaults.standard.set(idd, forKey: "IDDD")
            vc.CompanyIdFromCompanies = idd ?? 0
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}