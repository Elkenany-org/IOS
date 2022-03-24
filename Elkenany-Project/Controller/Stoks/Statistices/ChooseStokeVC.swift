//
//  ChooseCompanyVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit
import JGProgressHUD


//1-protocol for dataBack
protocol DataBackBorsaStok {
    func StokeId(StokeID:Int)
}


class ChooseStokeVC: UIViewController {
    //outlets
    @IBOutlet weak var CompanyTableView: UITableView!
    var listOfData:StatisticsStockSectionsModel?
    var typeForStoke = ""
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        CompanyTableView.delegate = self
        CompanyTableView.dataSource = self
        CompanyTableView.register(UINib(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: "companySelected")
        FatchlistOfStatisticesOut()


    }
    
  
    
    //viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //2-refrence from protocol
     var StokeDeleget:DataBackBorsaStok?
    
    
    //MARK:- featch Data of  Choose Borsa TableView Methodes
        func FatchlistOfStatisticesOut(){
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "جاري التحميل"
            hud.show(in: self.view)
            DispatchQueue.global(qos: .background).async {
//                let typeFromHome = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
                    let ListOfBorsaURLOut = "https://elkenany.com/api/localstock/statistics-stock-sections?type="
                let param = ["type": "\(self.typeForStoke)"]
                    APIServiceForQueryParameter.shared.fetchData(url: ListOfBorsaURLOut, parameters: param, headers: nil, method: .get) { (success:StatisticsStockSectionsModel?, filier:StatisticsStockSectionsModel?, error) in
                        if let error = error{
                            hud.dismiss()
                            print("============ error \(error)")
                        }else {
                            hud.dismiss()
                            guard let success = success else {return}
                            self.listOfData = success
                            DispatchQueue.main.async {
                                self.CompanyTableView.reloadData()
    
                        }
                    }
                }
            }
        }
    
}

//MARK:- Choose Borsa TableView Methodes
extension ChooseStokeVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData?.data?.listSubs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companySelected") as! CompanyCell
        cell.popupTitle.text = listOfData?.data?.listSubs?[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("showBackid ------")

        // 3- pass data to protocol
        let BackID = listOfData?.data?.changesSubs?[indexPath.row].id ?? 0
        StokeDeleget?.StokeId(StokeID: BackID)
        dismiss(animated: true, completion: nil)
        
    }
}
