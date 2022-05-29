//
//  MagazinVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/23/22.
//

import UIKit
import JGProgressHUD

class MagazinVC: UIViewController {
    
    
    //outlets
    var IdFromMagazine = 0
    var magazineDetailsModel:MagazineModel?
    var companyIDHomeSearch = 0
    @IBOutlet weak var magazineDetailsTV: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "بيانات الدليل"
        magazineDetailsTV.delegate = self
        magazineDetailsTV.dataSource = self
        magazineDetailsTV.register(UINib(nibName: "companyInfoCell", bundle: nil), forCellReuseIdentifier: "companyInfoCell")
        magazineDetailsTV.register(UINib(nibName: "aboutCompanyCell", bundle: nil), forCellReuseIdentifier: "aboutCompanyCell")
        magazineDetailsTV.register(UINib(nibName: "CompanySocialCell", bundle: nil), forCellReuseIdentifier: "CompanySocialCell")
        magazineDetailsTV.estimatedRowHeight = 150
        magazineDetailsTV.rowHeight = UITableView.automaticDimension
        FeatchCMagazineDetails()
        
    }
    

    
    func FeatchCMagazineDetails(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            //            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(self.IdFromMagazine)"]
            print("parrrra", param)
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let companyDetailes = "https://elkenany.com/api/magazine/magazine-detials/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:MagazineModel?, filier:MagazineModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
                cell.RatingCompany.text = String(magazineDetailsModel?.data?.rate ?? 0.0)
//                cell.com_rating.rating = magazineDetailsModel?.data?.rate
                let companyImage = magazineDetailsModel?.data?.image 
                cell.selectionStyle = .none
                cell.configureImage(image: companyImage ?? "")
                return cell }
        case 1:
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "aboutCompanyCell") as? aboutCompanyCell{
                cell2.aboutCompany.text = magazineDetailsModel?.data?.about ?? ""
                cell2.headTitle.text = "بيانات الدليل"
                cell2.selectionStyle = .none
                
                return cell2 }
        case 2:
            if let cell3 = tableView.dequeueReusableCell(withIdentifier: "CompanySocialCell") as? CompanySocialCell {
//                let magazine_id = magazineDetailsModel?.data?.id ?? 0
                cell3.magazineID = IdFromMagazine
                cell3.magazinKey = "true"
                cell3.headeTitle.text = "بيانات الدليل"
                cell3.FatchDataContactsOfMagazin()
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
                    let comParameterID = magazineDetailsModel?.data?.id ?? 0
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






