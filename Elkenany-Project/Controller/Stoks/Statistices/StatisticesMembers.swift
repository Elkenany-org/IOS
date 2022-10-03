//
//  StatisticesMembers.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/15/22.
//

import UIKit
import Alamofire
import ProgressHUD


class StatisticesMembers: UIViewController, DataBackCompany  , DataBackProtocolTwo , DataBackProtocol {
    
    @IBOutlet weak var DetailsCCV: UICollectionView!
    @IBOutlet weak var toTitle: UIButton!
    @IBOutlet weak var fromTitle: UIButton!
    
    var typeFromBorsa = ""
    var fodTypeFromBorsa = ""
    let date = Date()
    let formatter = DateFormatter()
    var LocalBorsaaaaas:statInsideFodder?
    var looooo:TestBorsaMember?
    var errorFromModel:ErrorModelForBorsa?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featchMainDataMembers()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        title = "الاحصائيات"
        toTitle.setTitle(result, for: .normal)
        fromTitle.setTitle(result, for: .normal)
        DetailsCCV.delegate = self
        DetailsCCV.dataSource = self
        self.DetailsCCV.register(UINib(nibName: "StatisticesCell", bundle: nil), forCellWithReuseIdentifier: "StatisticesCell")
        
    }
    
    
    
    //MARK:-  featch data by from date from picker [type of borsa , from , to , copany id ]
    func dataBackFromPicker(dateFrom: String) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        self.fromTitle.setTitle(dateFrom, for: .normal)

        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let idParam = UserDefaults.standard.string(forKey: "he") ?? ""
            let TParam = UserDefaults.standard.string(forKey: "she") ?? ""

            let FromPickerBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-members?type=&id=&from=&to=&mem_id="
            let param = ["type": "\(TParam)" , "to": "\(result)" , "from" : "\(dateFrom)" , "id" : "\(idParam)"]
            print(param)
            let headers = ["Authorization": "Bearer \(api_token ?? "")" , "app" : "ios"]
            APIServiceForQueryParameter.shared.fetchData(url: FromPickerBorsaURL, parameters: param, headers: headers, method: .get) { (success:statInsideFodder?, filier:statInsideFodder?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }  else if let loginError = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()
                    
                    print(filier?.message ?? "")
                }
                
                else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.LocalBorsaaaaas = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    //MARK:-  featch data by to date from picker [type of borsa , from , to , copany id ]
    func dataBackTOPicker(dateTo: String) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        self.toTitle.setTitle(dateTo, for: .normal)
        DispatchQueue.global(qos: .background).async {

            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")

            let headers = ["Authorization": "Bearer \(api_token ?? "")" , "app" : "ios"]

            let idParam = UserDefaults.standard.string(forKey: "he") ?? ""
            let TParam = UserDefaults.standard.string(forKey: "she") ?? ""

            let toPickerBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-members?type=&from=&to=&id=&mem_id="
            let param = ["type": "\(TParam)" , "to": "\(result)" , "from" : "\(dateTo )" , "id" : "\(idParam)"]
            print("\(param)")
            APIServiceForQueryParameter.shared.fetchData(url: toPickerBorsaURL, parameters: param, headers: headers, method: .get) { (success:statInsideFodder?, filier:statInsideFodder?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else if let loginErrorr = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()
                    
                    print(loginErrorr.message ?? "")
                }
                
                else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.LocalBorsaaaaas = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()
                        print(success.data ?? "")

                    }
                }
            }
        }
    }
    
    
    func companyId(ComID: Int) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        DispatchQueue.global(qos: .background).async {
            let idParam = UserDefaults.standard.string(forKey: "he") ?? ""
            let TParam = UserDefaults.standard.string(forKey: "she") ?? ""

            let param = ["id": "\(idParam)", "type": "\(TParam)" , "to" : "\(result)" , "mem_id" : "\(ComID)" ]
            let companyDetailsurl = "https://elkenany.com/api/localstock/statistics-stock-members?type=&id=&from=&to=&mem_id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailsurl, parameters: param, headers: nil, method: .get) { (Detailssuccess:statInsideFodder?, Detailsfilier:statInsideFodder?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = Detailssuccess else {return}
                    self.LocalBorsaaaaas = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    func featchMainDataMembers(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")

            let headers = ["Authorization": "Bearer \(api_token ?? "")" , "app" : "ios"]

            let idParam = UserDefaults.standard.string(forKey: "he") ?? ""
            let TParam = UserDefaults.standard.string(forKey: "she") ?? ""

            let toPickerBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-members?type=&from=&to=&id=&mem_id="
            let param = ["type": "\(TParam)" , "to": "\(result)"  , "id" : "\(idParam)"]
            print("\(param)")
            APIServiceForQueryParameter.shared.fetchData(url: toPickerBorsaURL, parameters: param, headers: headers, method: .get) { (success:statInsideFodder?, filier:statInsideFodder?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.LocalBorsaaaaas = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()
                        print(success.data ?? "")

                    }
                }
            }
        }
    }
    
    
    
    @IBAction func prsenCompanies(_ sender: Any) {
        let vcCom = storyboard?.instantiateViewController(withIdentifier: "chooseComVC") as? chooseComVC
        vcCom?.DataBackDelegetee = self
        vcCom?.typeOFBorsaaaa = typeFromBorsa
        self.present(vcCom!, animated: true, completion: nil)
    }
    
    
    
    @IBAction func FromDate(_ sender: UIButton) {
        let fromPickerVC = storyboard?.instantiateViewController(withIdentifier: "FromPicker") as? FromPicker
        fromPickerVC?.DataBackDeleget = self
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        sender.setTitle(result, for: .normal)
        self.present(fromPickerVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func ToDate(_ sender: UIButton) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        sender.setTitle(result, for: .normal)
        let toPickerVC = storyboard?.instantiateViewController(withIdentifier: "ToPicker") as? ToPicker
        toPickerVC?.DataBackDelegettwo = self
      
        self.present(toPickerVC!, animated: true, completion: nil)

    }
    
    
    
    
    
}




extension StatisticesMembers:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalBorsaaaaas?.data?.changesMembersss?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticesCell", for: indexPath) as!  StatisticesCell
        cell.typeTitle.text = LocalBorsaaaaas?.data?.changesMembersss?[indexPath.item].name ?? ""
        cell.pricetitle.text = String (LocalBorsaaaaas?.data?.changesMembersss?[indexPath.item].counts ?? 0)
        cell.chanageTitle.text = LocalBorsaaaaas?.data?.changesMembersss?[indexPath.item].change ?? ""
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailsVC = storyboard?.instantiateViewController(identifier: "staticticesDetails") as! staticticesDetails
        navigationController?.pushViewController(DetailsVC, animated: true)
        
    }
    
}

