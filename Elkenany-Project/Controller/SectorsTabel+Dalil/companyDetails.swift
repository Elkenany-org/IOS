//
//  companyDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/10/21.
//

import UIKit
import Alamofire
import Kingfisher
import JGProgressHUD

class companyDetails: UIViewController {
    
    //outlets
    var CompanyIdFromCompanies = 0
    var companyDetailsModel:CompanyDetailsDataModel?
    var companyIDHomeSearch = 0
    @IBOutlet weak var companyDetailsTV: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyDetailsTV.delegate = self
        companyDetailsTV.dataSource = self
        companyDetailsTV.register(UINib(nibName: "companyInfoCell", bundle: nil), forCellReuseIdentifier: "companyInfoCell")
        companyDetailsTV.register(UINib(nibName: "aboutCompanyCell", bundle: nil), forCellReuseIdentifier: "aboutCompanyCell")
        companyDetailsTV.register(UINib(nibName: "CompanySocialCell", bundle: nil), forCellReuseIdentifier: "CompanySocialCell")
        companyDetailsTV.estimatedRowHeight = 150
        companyDetailsTV.rowHeight = UITableView.automaticDimension
        FeatchCompanyInformations()

        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func FeatchCompanyInformations(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            //            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(self.CompanyIdFromCompanies)"]
            print("parrrra", param)
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.companyDetailsModel = success
                    DispatchQueue.main.async {
                        self.companyDetailsTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    func FeatchCompanyHomeSearch(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            //            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(self.CompanyIdFromCompanies)"]
            print("parrrra", param)
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: headers, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.companyDetailsModel = success
                    DispatchQueue.main.async {
                        self.companyDetailsTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    @IBAction func RatingVC(_ sender: Any) {
        
        
        
    }
    
    
    
    @IBAction func DirectionBTN(_ sender: Any) {
    }
    
    
    
}
extension companyDetails:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell") as? companyInfoCell{
                cell.companyName.text = companyDetailsModel?.data?.name ?? ""
                cell.companyDesc.text = companyDetailsModel?.data?.shortDesc ?? ""
                cell.RatingCompany.text = String(companyDetailsModel?.data?.rate ?? 0)
                cell.com_rating.rating = companyDetailsModel?.data?.rate ?? 0 
                let companyImage = companyDetailsModel?.data?.image
                cell.selectionStyle = .none
                cell.configureImage(image: companyImage ?? "")
                return cell }
        case 1:
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "aboutCompanyCell") as? aboutCompanyCell{
                cell2.aboutCompany.text = companyDetailsModel?.data?.about ?? ""
                
                cell2.selectionStyle = .none
                
                return cell2 }
        case 2:
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "CompanySocialCell") as? CompanySocialCell {
                cell3.com_id = CompanyIdFromCompanies
                cell3.FatchDataContactsOfCompanies()
                cell3.selectionStyle = .none
                
                return cell3
            }
            
        default:
            print("hhhhhhhhh")
        }
        
        return UITableViewCell()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            
            /// reverse the functions bc this a check only ----
            let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
            
            if isloggineIn {
             
                if let vc: RatingCompanyVC = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"RatingCompanyVC") as? RatingCompanyVC{
                    let comParameterID = companyDetailsModel?.data?.id ?? 0
                    vc.CompanyID = comParameterID
                    self.present(vc, animated: true, completion: nil)  }
            }else{
                print("helllllo ")
                //show rating view to do rating
                if let vc = storyboard?.instantiateViewController(identifier: "popupToSignIN") as? popupToSignIN {
//                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
               
            }
            
            
            
            
            
        default:
            print("hello")
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.rowHeight
        
    }
    
}






