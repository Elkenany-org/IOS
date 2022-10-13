//
//  CompanySocialCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import UIKit
import Foundation

class CompanySocialCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK:- Outlets and Vars
    @IBOutlet weak var headeTitle: UILabel!
    @IBOutlet weak var socialTV: UITableView!
    var magazineDetailsModel:MagazineModel?
    var socialData:CompanyDetailsDataModel?
    var lannn = ""
    var loonn = ""
    var magazinKey = ""
    var kk = ""

    var com_id = 0
    var arr = ["33333" , "6666" , "66666"]
    var magazineID = 0
    var magazinefromHome = 0
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        socialTV.estimatedRowHeight = 150
        socialTV.rowHeight = UITableView.automaticDimension
        
        if magazinKey == "hommme" {
            FatchDataContactsOfMagazinHomeMain()
        }else{
            print("logic error")
        }
    }
    
    
    
    fileprivate func setupUI() {
        socialTV.delegate = self
        socialTV.dataSource = self
        socialTV.register(UINib(nibName: "socialCell", bundle: nil), forCellReuseIdentifier: "socialCell")
        socialTV.register(UINib(nibName: "TestAnyCell", bundle: nil), forCellReuseIdentifier: "TestAnyCell")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK:- featch and handling data
    func FatchDataContactsOfCompanies(){
        //Handeling Loading view progress
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(self.com_id)"]
            let companyContacts = "https://admin.elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyContacts, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.socialData = success
                    DispatchQueue.main.async {
                        self.socialTV.reloadData()
                        self.lannn = success.data?.latitude ?? ""
                        self.loonn = success.data?.longitude ?? ""
                    }
                }
            }
        }
    }
    
    
    //MARK:- featch and handling data
    func FatchDataContactsOfMagazin(){
        //Handeling Loading view progress
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(self.magazineID)"]
            let companyContacts = "https://admin.elkenany.com/api/magazine/magazine-detials/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyContacts, parameters: param, headers: nil, method: .get) { (success:MagazineModel?, filier:MagazineModel?, error) in
                if let error = error{
                    
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.magazineDetailsModel = success
                    DispatchQueue.main.async {
                        self.socialTV.reloadData()
                        self.lannn = success.data?.latitude ?? ""
                        self.loonn = success.data?.longitude ?? ""
                    }
                }
            }
        }
    }
    
    func FatchDataContactsOfMagazinHomeMain(){
        //Handeling Loading view progress
        DispatchQueue.global(qos: .background).async {
            let idds = UserDefaults.standard.string(forKey: "testt")
            let param = ["id": "\(idds ?? "")"]
            let companyContacts = "https://admin.elkenany.com/api/magazine/magazine-detials/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyContacts, parameters: param, headers: nil, method: .get) { (success:MagazineModel?, filier:MagazineModel?, error) in
                if let error = error{
                    
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.magazineDetailsModel = success
                    DispatchQueue.main.async {
                        self.socialTV.reloadData()
                        self.lannn = success.data?.latitude ?? ""
                        self.loonn = success.data?.longitude ?? ""
                    }
                }
            }
        }
    }
    
    
    
    
    
    //MARK:- Open Google Map Click
    @IBAction func toMapView(_ sender: UIButton) {
        openGoogleMap()
    }
    func openGoogleMap() {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lannn),\(loonn)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }}
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lannn),\(loonn)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
    
    
    
    //MARK:- TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if magazinKey == "true"{
            switch section {
            case 0:
                return magazineDetailsModel?.data?.phones?.count ?? 0
                
            case 1:
                return magazineDetailsModel?.data?.emails?.count ?? 0
                
            case 2:
                return magazineDetailsModel?.data?.mobiles?.count ?? 0
                
            case 3:
                return magazineDetailsModel?.data?.faxs?.count ?? 0
                
            case 4:
                return magazineDetailsModel?.data?.social?.count ?? 0
                
            default:
                return 1
            }
        }else{
            
            switch section {
            case 0:
                return socialData?.data?.phones?.count ?? 0
                
            case 1:
                return socialData?.data?.emails?.count ?? 0
                
            case 2:
                return socialData?.data?.mobiles?.count ?? 0
                
            case 3:
                return socialData?.data?.faxs?.count ?? 0
                
            case 4:
                return socialData?.data?.social?.count ?? 0
                
            default:
                return 1
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if magazinKey == "true"{
            
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell.contact.text = magazineDetailsModel?.data?.phones?[indexPath.row].phone ?? "22222"
                cell.iconee.image = #imageLiteral(resourceName: "phone-call")
                return cell
                
            case 1:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = magazineDetailsModel?.data?.emails?[indexPath.row].email ?? "1111"
                cell1.iconee.image = #imageLiteral(resourceName: "email (3)")
                return cell1
                
            case 2:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = magazineDetailsModel?.data?.mobiles?[indexPath.row].mobile ?? "22222"
                cell1.iconee.image = #imageLiteral(resourceName: "smartphone")
                return cell1
                
                
            case 3:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.iconee.image = #imageLiteral(resourceName: "fax-1")
                return cell1
                
            case 4:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = magazineDetailsModel?.data?.social?[indexPath.row].socialName ?? "44444"
                let imageSo = magazineDetailsModel?.data?.social?[indexPath.row].socialIcon ?? ""
                cell1.configureImage(image: imageSo)
                return cell1
                
            default:
                return UITableViewCell()
            }
            
        }else{
            
            
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell.contact.text = socialData?.data?.phones?[indexPath.row].phone ?? "0000"
                cell.iconee.image = #imageLiteral(resourceName: "phone-call")
                return cell
                
            case 1:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = socialData?.data?.emails?[indexPath.row].email ?? "1111"
                cell1.iconee.image = #imageLiteral(resourceName: "email (3)")
                return cell1
                
            case 2:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = socialData?.data?.mobiles?[indexPath.row].mobile ?? "22222"
                cell1.iconee.image = #imageLiteral(resourceName: "smartphone")
                return cell1
                
                
            case 3:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = socialData?.data?.faxs?[indexPath.row].fax ?? "3333"
                cell1.iconee.image = #imageLiteral(resourceName: "fax-1")
                return cell1
                
            case 4:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "socialCell") as! socialCell
                cell1.contact.text = socialData?.data?.social?[indexPath.row].socialName ?? "44444"
                let imageSo = socialData?.data?.social?[indexPath.row].socialIcon ?? ""
                cell1.configureImage(image: imageSo)
                return cell1
                
            default:
                return UITableViewCell()
            }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //MARK: phone
        func callNumber(number: String ) {
            guard let url = URL(string: "tel://\(number)") else {return}
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        
        
        
        if magazinKey == "true"{
            switch indexPath.section {
            case 0:
                //mobile
                print("heeloooooooooo")
                
            case 1:
                //mail
                if let url = URL(string: "mailto:\(magazineDetailsModel?.data?.emails?[indexPath.row].email ?? "")") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                
            case 2:
                
                print("heelo")
                
            case 3:
                
                print("heelo")
                
            case 4:
                
                if let url = URL(string: "\(magazineDetailsModel?.data?.social?[indexPath.row].socialLink ?? "")") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    } else {
                        print("Cannot open URL")
                    }}
                
            default:
                print("heelo")
            }
            
            
        }else{
            
            switch indexPath.section {
            case 0:
                //mobile
                print("heeloooooooooo")
                
            case 1:
                // maillll
                if let url = URL(string: "mailto:\(socialData?.data?.emails?[indexPath.row].email ?? "")") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }}
                
            case 2:
                
                print("heelo")
                
            case 3:
                
                callNumber(number: socialData?.data?.faxs?[indexPath.row].fax ?? "")
                
            case 4:
                if let url = URL(string: "\(socialData?.data?.social?[indexPath.row].socialLink ?? "")") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    } else {
                        print("Cannot open URL")
                    }}
                
            default:
                print("heelo")
            }
        }
    }
    
}


//MARK: Click
extension UIResponder {
    func next<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}
