//
//  chooseComVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/15/22.
//

import UIKit
import JGProgressHUD

protocol DataBackCompany {
    func companyId( ComID:Int)
}


class chooseComVC: UIViewController {
    
    var listOfDataInside:StatisticesInsideModel?

    @IBOutlet weak var comSelectedTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        comSelectedTV.delegate = self
        comSelectedTV.dataSource = self
        comSelectedTV.register(UINib(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: "companySelected")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FatchlistOfStatisticesIn()

        
    }
    
    //delegets
    var DataBackDelegetee:DataBackCompany?
    


    func FatchlistOfStatisticesIn(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            print("this is token\(api_token ?? "")")
//            let typeFromHome = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
                        let typeParameter = UserDefaults.standard.string(forKey: "she")
                        let idParameter = UserDefaults.standard.string(forKey: "he")
            
                let ListOfBorsaURLOut = "https://elkenany.com/api/localstock/statistics-stock-members?type=&id="
            let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")"]
            
            APIServiceForQueryParameter.shared.fetchData(url: ListOfBorsaURLOut, parameters: param, headers: nil, method: .get) { (success:StatisticesInsideModel?, filier:StatisticesInsideModel?, error) in
                    if let error = error{
                        hud.dismiss()
                        print("============ error \(error)")
                    }else {
                        hud.dismiss()
                        guard let success = success else {return}
                        self.listOfDataInside = success
                        DispatchQueue.main.async {
                            self.comSelectedTV.reloadData()

                        }
                  }
            }
        }
    }

    
    
    
    @IBAction func dismis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension chooseComVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfDataInside?.data?.listMembers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companySelected") as! CompanyCell
        cell.popupTitle.text = listOfDataInside?.data?.listMembers?[indexPath.row].name ?? "" 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
 
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let BackID = listOfDataInside?.data?.listMembers?[indexPath.row].id ?? 0
        let cell = tableView.dequeueReusableCell(withIdentifier: "companySelected") as! CompanyCell
        cell.popupImage.image = #imageLiteral(resourceName: "check")

        
        DataBackDelegetee?.companyId(ComID: BackID)
        dismiss(animated: true, completion: nil)
        
      
        
    }
    
    
    
    
    
}
