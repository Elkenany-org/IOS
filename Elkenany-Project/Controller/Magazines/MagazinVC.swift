//
//  MagazinVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import UIKit
import ProgressHUD

class MagazinVC: UIViewController {
    
    //outlets
    @IBOutlet weak var magazineDetailsTV: UITableView!
    var magazineDetailsModel:MagazineModel?
    var IdFromMagazine = 0
    var companyIDHomeSearch = 0
    var magazineIdFromHome = 0
    var presentKK = ""
    var titleeeFromHome = "بيانات الدليل"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cofiguerUI()
        FeatchCMagazineDetails()
        title = titleeeFromHome
    }
    
    //configuer ui
    fileprivate func cofiguerUI() {
        magazineDetailsTV.delegate = self
        magazineDetailsTV.dataSource = self
        magazineDetailsTV.register(UINib(nibName: "companyInfoCell", bundle: nil), forCellReuseIdentifier: "companyInfoCell")
        magazineDetailsTV.register(UINib(nibName: "aboutCompanyCell", bundle: nil), forCellReuseIdentifier: "aboutCompanyCell")
        magazineDetailsTV.register(UINib(nibName: "CompanySocialCell", bundle: nil), forCellReuseIdentifier: "CompanySocialCell")
        magazineDetailsTV.estimatedRowHeight = 150
        magazineDetailsTV.rowHeight = UITableView.automaticDimension
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
    
    
    //MARK:- Main Data
    func FeatchCMagazineDetails(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(self.IdFromMagazine)"]
            let companyDetailes = "https://elkenany.com/api/magazine/magazine-detials/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:MagazineModel?, filier:MagazineModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.magazineDetailsModel = success
                    DispatchQueue.main.async {
                        self.magazineDetailsTV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    //MARK:- Main Data From Home
    func FeatchCMagazineFromHome(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let idOfHome = UserDefaults.standard.string(forKey: "testt")
            let param = ["id": "\(idOfHome ?? "")"]
            let companyDetailes = "https://elkenany.com/api/magazine/magazine-detials/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:MagazineModel?, filier:MagazineModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.magazineDetailsModel = success
                    DispatchQueue.main.async {
                        self.magazineDetailsTV.reloadData()
                    }
                }
            }
        }
    }
    
}


//MARK:- table of main data
extension MagazinVC:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell") as? companyInfoCell{
                cell.companyName.text = magazineDetailsModel?.data?.name ?? ""
                cell.companyDesc.text = magazineDetailsModel?.data?.shortDesc ?? ""
                cell.RatingCompany.text = String(magazineDetailsModel?.data?.countRate ?? 0)
                cell.com_rating.rating = Double(magazineDetailsModel?.data?.countRate ?? 0)
                let companyImage = magazineDetailsModel?.data?.image
                cell.selectionStyle = .none
                cell.configureImage(image: companyImage ?? "")
                ss(ss: cell)
                return cell }
            
        case 1:
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "aboutCompanyCell") as? aboutCompanyCell{
                cell2.aboutCompany.text = magazineDetailsModel?.data?.about ?? ""
                cell2.headTitle.text = "عن الدليل"
                cell2.selectionStyle = .none
                ss(ss: cell2)
                return cell2 }
            
        case 2:
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "CompanySocialCell") as? CompanySocialCell {
                cell3.magazineID = IdFromMagazine
                cell3.magazinKey = "true"
                cell3.headeTitle.text = "بيانات الدليل"
                if presentKK == "hommme" {
                    cell3.FatchDataContactsOfMagazinHomeMain()
                }else{
                    cell3.FatchDataContactsOfMagazin()

                }
                cell3.selectionStyle = .none
                ss(ss: cell3)
                return cell3 }
            
        default: print("default")}
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0:
            let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
            if isloggineIn {
                if let vc: RatingCompanyVC = UIStoryboard(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier:"RatingCompanyVC") as? RatingCompanyVC{
                    let comParameterID = magazineDetailsModel?.data?.id ?? 0
                    vc.magazineID = comParameterID
                    vc.ratingKey = "MAGAZINE"
                    self.present(vc, animated: true, completion: nil) }
                
            }else{
                if let vc = storyboard?.instantiateViewController(identifier: "popupToSignIN") as? popupToSignIN {
                    self.present(vc, animated: true, completion: nil)}
            }
            
        default:
            print("hello")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
}






