//
//  CompanySocialCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/12/21.
//

import UIKit
import Foundation

class CompanySocialCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    //MARK:- Outlets
    @IBOutlet weak var socialTV: UITableView!
    var com_id = 0
    var arr = ["33333" , "6666" , "66666"]
    var lannn = ""
    var loonn = ""

    var socialData:CompanyDetailsDataModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setup delegete
        socialTV.delegate = self
        socialTV.dataSource = self
        socialTV.register(UINib(nibName: "socialCell", bundle: nil), forCellReuseIdentifier: "socialCell")
        socialTV.register(UINib(nibName: "TestAnyCell", bundle: nil), forCellReuseIdentifier: "TestAnyCell")
        //automatic height
        //        FatchDataContactsOfCompanies()
        socialTV.estimatedRowHeight = 150
        socialTV.rowHeight = UITableView.automaticDimension
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    
    //MARK:- featch and handling data
    func FatchDataContactsOfCompanies(){
        //Handeling Loading view progress
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            //            let idParameter = UserDefaults.standard.string(forKey: "COM_ID")
            let param = ["id": "\(self.com_id)"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let companyContacts = "https://elkenany.com/api/guide/company/?id="
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
    
    
    
    
    @IBAction func toMapView(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let vcc = storyboard.instantiateViewController(identifier: "MapVC") as? MapVC {
//        if let vc = self.next(ofType: UIViewController.self) {
//            vcc.id_company = com_id
//            vc.present(vcc, animated: true, completion: nil)
//        }
//    }
        
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
        //        return arr.count ?? 0
        
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
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
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
            
            //           cell.contact.text = arr[indexPath.row]
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
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func callNumber(number: String ) {
            
            guard let url = URL(string: "tel://\(number)") else {return}
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        
        
    switch indexPath.section {
        case 0:
            ///for mobile
//            callNumber(number: socialData?.data?.mobiles?[indexPath.row].mobile ?? "")
            print("heeloooooooooo")
            
//            for i in socialData?.data?.mobiles?[indexPath.row].mobile ?? "" {
//                print("0001110000100000100+++++\(i)")
////                            callNumber(number: i)
//
//            }

        case 1:
            ///fooooor maillll
//            let email = "foo@bar.com"
                if let url = URL(string: "mailto:\(socialData?.data?.emails?[indexPath.row].email ?? "")") {
                  if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                    
                  } else {
                    UIApplication.shared.openURL(url)
                    
                    
                  }
                }
                
           
                print("soial")

            
            
        case 2:
            print("heelo")
            
//            for i in socialData?.data?.phones?[indexPath.row].phone ?? "" {
//                print("fooooor \(i)")
//
////            }
//
//            if let ii = socialData?.data?.phones {
//
//            }
            
//            for row in indexPath.section {
//                callNumber(number: socialData?.data?.phones?[indexPath.row].phone ?? "")
//
//            }
//
//            for i in socialData?.data?.phones ?? [] {
//                
//                for xx in i.phone ?? ""{
////                 callNumber(number: xx ?? "")
//
//                }
//                
//                
//            }
            
            
            
            
        case 3:
            print("heelo")
            callNumber(number: socialData?.data?.faxs?[indexPath.row].fax ?? "")
            
            
        case 4:
            if let url = URL(string: "\(socialData?.data?.social?[indexPath.row].socialLink ?? "")") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                } else {
                    print("Cannot open URL")
                }
            }
            
        default:
            print("heelo")
        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return tableView.rowHeight
//        
//    }
//    
    
}



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
