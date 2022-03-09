//
//  StatisticesMembers.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/15/22.
//

import UIKit
import Charts
import Alamofire
import JGProgressHUD

class StatisticesMembers: UIViewController, DataBackCompany , DataBackProtocol , DataBackProtocolTwo {
 
    
    
    //MARK:-  featch data by from date from picker [type of borsa , from , to , copany id ]
    func dataBackFromPicker(dateFrom: String, currentDate: Date) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let idParam = UserDefaults.standard.string(forKey: "he")
            let token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "Bearer \(token ?? "")" ]
            let FromPickerBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-members?type=&from=&id="
//            let typeParameter = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
            let param = ["type": "\(self.typeFromBorsa)" ,  "from": "\(dateFrom)" , "id": "\(idParam ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: FromPickerBorsaURL, parameters: param, headers: headers, method: .get) { (success:StatisticesInsideModel?, filier:StatisticesInsideModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.LocalBorsa2 = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()

                    }
                }
            }
        }
    }
    //MARK:-  featch data by to date from picker [type of borsa , from , to , copany id ]
    func dataBackTOPicker(dateTo: String) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            print("this is token\(api_token ?? "")")
            let token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let idParam = UserDefaults.standard.string(forKey: "he")

            let headers = ["Authorization": "Bearer \(token ?? "")" ]
            let toPickerBorsaURL = "localstock/statistics-stock-members?type=&to=&id="
//            let formDateParamater = UserDefaults.standard.string(forKey: "DATE_FROM")
            let param = ["type": "\(self.typeFromBorsa)" , "to": "\(dateTo )" , "id": "\(idParam ?? "" )" ]
//            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: toPickerBorsaURL, parameters: param, headers: headers, method: .get) { (success:StatisticesInsideModel?, filier:StatisticesInsideModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.LocalBorsa2 = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()

                    }
                }
            }
        }
    }
    
    
    
    
    
    

    var typeFromBorsa = ""
    var fodTypeFromBorsa = ""
    var LocalBorsa2:StatisticesInsideModel?

    @IBOutlet weak var piechart: PieChartView!
    @IBOutlet weak var DetailsCCV: UICollectionView!
    var enteries = [ChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for x in 0..<5 {
            
            enteries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        // Do any additional setup after loading the view.
        let set = PieChartDataSet(enteries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        piechart.data = data
        
        DetailsCCV.delegate = self
        DetailsCCV.dataSource = self
        self.DetailsCCV.register(UINib(nibName: "StatisticesCell", bundle: nil), forCellWithReuseIdentifier: "StatisticesCell")
    }
    
    @IBAction func prsenCompanies(_ sender: Any) {
        let vcCom = storyboard?.instantiateViewController(withIdentifier: "chooseComVC") as? chooseComVC
        vcCom?.DataBackDelegetee = self
           self.present(vcCom!, animated: true, completion: nil)
        
    }
    
    @IBAction func FromDate(_ sender: Any) {
        
        let fromPickerVC = storyboard?.instantiateViewController(withIdentifier: "FromPicker") as? FromPicker
        fromPickerVC?.DataBackDeleget = self
           self.present(fromPickerVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func ToDate(_ sender: Any) {
        
        let toPickerVC = storyboard?.instantiateViewController(withIdentifier: "ToPicker") as? ToPicker
        toPickerVC?.DataBackDelegettwo = self
           self.present(toPickerVC!, animated: true, completion: nil)
    }
    

    
    func companyId(ComID: Int) {
        DispatchQueue.global(qos: .background).async {
//            let typePara = UserDefaults.standard.string(forKey: "she")
            let param = ["id": "\(ComID)", "type": "\(self.typeFromBorsa)"]
            print("-------para \(param)")
            let token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "Bearer \(token ?? "")" ]
            let companyDetailsurl = "https://elkenany.com/api/localstock/statistics-stock-members?type=&id="
            print("///// urllll \(companyDetailsurl)")
//            let idParameter = UserDefaults.standard.string(forKey: "ID_Details")
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailsurl, parameters: param, headers: headers, method: .get) { (Detailssuccess:StatisticesInsideModel?, Detailsfilier:StatisticesInsideModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = Detailssuccess else {return}
                    self.LocalBorsa2 = success
                    DispatchQueue.main.async {
                        self.DetailsCCV.reloadData()
                        print("teeeeeest ------- \(self.LocalBorsa2?.data?.changesMembers)")
                    }
                }
            }
        }
    }
    
 
    
}




extension StatisticesMembers:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalBorsa2?.data?.changesMembers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticesCell", for: indexPath) as!  StatisticesCell
//        cell.layer.cornerRadius = 15.0
//        cell.layer.borderWidth = 1.0
//        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        ss.layer.shadowColor = UIColor.black.cgColor
//        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
//        ss.layer.shadowRadius = 5.0
//        ss.layer.shadowOpacity = 0.4
//        cell.layer.masksToBounds = false
        cell.typeTitle.text = LocalBorsa2?.data?.changesMembers?[indexPath.item].name ?? ""
        cell.pricetitle.text = LocalBorsa2?.data?.changesMembers?[indexPath.item].change ?? ""
        cell.chanageTitle.text = String( LocalBorsa2?.data?.changesMembers?[indexPath.item].counts ?? 0 )
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailsVC = storyboard?.instantiateViewController(identifier: "staticticesDetails") as! staticticesDetails
        let ComId = LocalBorsa2?.data?.changesMembers?[indexPath.item].id ?? 0
        UserDefaults.standard.set(ComId, forKey: "ID_Details")
        let ComName = LocalBorsa2?.data?.changesMembers?[indexPath.item].name ?? ""
        UserDefaults.standard.set(ComName, forKey: "Name_Details")
        navigationController?.pushViewController(DetailsVC, animated: true)
        
    }

}

