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
    var companiesModel:SearchModel?
    private var mainDataModel: [Resultssss] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBaView.barTintColor = .white
        setupSearchBar()
        setupUI()
        searchTVV.estimatedRowHeight = 150
        searchTVV.rowHeight = UITableView.automaticDimension
        if let vc = storyboard?.instantiateViewController(identifier: "BlankView") as? BlankView {
//            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func FatchDat(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        let resulttt = searchBaView?.text ?? ""
        DispatchQueue.global(qos: .background).async {
            let param = ["search": "\(resulttt)" ]
            print("this para", param)
            let companyGuide = "https://elkenany.com/api/search-all?search="
            print("URL", companyGuide)
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:SearchModel?, filier:SearchModel?, error) in
                
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                
                
                else {
                    hud.dismiss()
                    let successData = success?.data?.result ?? []
                    self.mainDataModel.append(contentsOf: successData)
                    DispatchQueue.main.async {
                        
                        self.searchTVV.reloadData()
                        print(self.companiesModel?.data?.result ??  "")
                        
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
            let data = companiesModel?.data?.result ?? []
            //your array
            mainDataModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            mainDataModel.removeAll()
            
            //Api func
            FatchDat()
        }
        
        //reload
        searchTVV.reloadData()
        
    }
    
    
}

//MARK:- CollectionView [Methods + Delegets]
extension searchVC:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDataModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Companiescell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        Companiescell.searchResult.text = mainDataModel[indexPath.row].name ?? "search test"
        return Companiescell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}
