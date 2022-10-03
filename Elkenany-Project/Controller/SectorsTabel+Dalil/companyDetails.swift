//
//  companyDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/10/21.
//

import UIKit
import Alamofire
import Kingfisher
import ProgressHUD
class companyDetails: UIViewController {
    
    //outlets
    @IBOutlet weak var companyDetailsTV: UITableView!
    var companyDetailsModel:CompanyDetailsDataModel?
    var CompanyIdFromCompanies = 0
    var companyIDHomeSearch = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyDetailsTV.delegate = self
        companyDetailsTV.dataSource = self
        title = "بيانات الشركة" 
        companyDetailsTV.register(UINib(nibName: "companyInfoCell", bundle: nil), forCellReuseIdentifier: "companyInfoCell")
        companyDetailsTV.register(UINib(nibName: "aboutCompanyCell", bundle: nil), forCellReuseIdentifier: "aboutCompanyCell")
        companyDetailsTV.register(UINib(nibName: "CompanySocialCell", bundle: nil), forCellReuseIdentifier: "CompanySocialCell")
        companyDetailsTV.estimatedRowHeight = 150
        companyDetailsTV.rowHeight = UITableView.automaticDimension
        FeatchCompanyInformations()
    }
    
    func ss(ss:UITableViewCell){
        ss.layer.cornerRadius = 20
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 10
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    
    
    func FeatchCompanyInformations(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(self.CompanyIdFromCompanies)"]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
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
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(self.CompanyIdFromCompanies)"]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.companyDetailsModel = success
                    DispatchQueue.main.async {
                        self.companyDetailsTV.reloadData()
                        
                    }
                }
            }
        }
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
                cell.RatingCompany.text = String(Int( companyDetailsModel?.data?.countRate ?? 0))
                cell.com_rating.rating = companyDetailsModel?.data?.rate ?? 0
                let companyImage = companyDetailsModel?.data?.image
                cell.selectionStyle = .none
                
                cell.configureImage(image: companyImage ?? "")
                ss(ss: cell)
                return cell }
        case 1:
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "aboutCompanyCell") as? aboutCompanyCell{
                cell2.aboutCompany.text = companyDetailsModel?.data?.about ?? ""
                
                cell2.selectionStyle = .none
                ss(ss: cell2)
                return cell2 }
        case 2:
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "CompanySocialCell") as? CompanySocialCell {
                cell3.com_id = CompanyIdFromCompanies
                ss(ss: cell3)
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
                    vc.ratingKey = "COMAPNIES"
                    self.present(vc, animated: true, completion: nil)  }
            }else{
                print("helllllo ")
                //show rating view to do rating
                if let vc = storyboard?.instantiateViewController(identifier: "popupToSignIN") as? popupToSignIN {
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






