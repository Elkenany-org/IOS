//
//  statisticsInsideMain.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit
import JGProgressHUD
import Charts


class statisticsInsideMain: UIViewController, DataBackProtocol, DataBackProtocolTwo , DataBackBorsaStok{
    func dataBackFromPicker(dateFrom: String) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
                toBackData.setTitle(dateFrom, for: .normal)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = "جاري التحميل"
                hud.show(in: self.view)
                DispatchQueue.global(qos: .background).async {
                    let ListOfBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-sections?type=&from=&to=&id="
                    let typeParameter = UserDefaults.standard.string(forKey: "TYYYPE") ?? ""
                    let param = ["type": "\(self.stoType)", "to": "\(dateFrom)" ,  "from": "\(result)" ]
                    print("oooo", param)
        //            let headers = ["app-id": "\(api_token ?? "")" ]
                    APIServiceForQueryParameter.shared.fetchData(url: ListOfBorsaURL, parameters: param, headers: nil, method: .get) { (success:StatisticsStockSectionsModel?, filier:StatisticsStockSectionsModel?, error) in
                        if let error = error{
                            hud.dismiss()
                            print("============ error \(error)")
                        }else {
                            hud.dismiss()
                            guard let success = success else {return}
                            self.LocalBorsa = success
                            DispatchQueue.main.async {
                                self.StatisticsCollection.reloadData()
                                print(success.data ?? "")
        
                            }
                        }
                    }
                }
    }
    
   

    func dataBackFromPicker(dateFrom: String, currentDate: Date) {
        print("hello ")
    }
    

  
    
    @IBOutlet weak var StatisticsCollection: UICollectionView!
    @IBOutlet weak var dateFromLabel: UIButton!
    @IBOutlet weak var toBackData: UIButton!
    @IBOutlet weak var dateLabell:UIButton!
    @IBOutlet weak var pieChartt: PieChartView!
    var LocalBorsa:StatisticsStockSectionsModel?

    var enteries = [ChartDataEntry]()
    var stoType = ""
    let date = Date()
    let formatter = DateFormatter()
  
    
    //MARK:- Loading the Collection by selected Stoke [id , type from home]
    func StokeId(StokeID: Int) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        DispatchQueue.global(qos: .background).async {
            let param = ["id": "\(StokeID)", "type": "\(self.stoType)" , "from" : "2022-03-18" , "to" : "\(result)" ]
            print("-------para \(param)")
            let chooseStockeURL = "https://elkenany.com/api/localstock/statistics-stock-sections?type=&from=&to=&id="
            APIServiceForQueryParameter.shared.fetchData(url: chooseStockeURL, parameters: param, headers: nil, method: .get) { (Detailssuccess:StatisticsStockSectionsModel?, Detailsfilier:StatisticsStockSectionsModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = Detailssuccess else {return}
                    self.LocalBorsa = success
                    DispatchQueue.main.async {
                        self.StatisticsCollection.reloadData()
                        print("teeeeeest ------- \(success.data)")
                    }
                }
            }
        }
    }

    

    //MARK:- Loading the Collection by selected Date to Picker  []
    func dataBackTOPicker(dateTo : String) {
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
                toBackData.setTitle(dateTo, for: .normal)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = "جاري التحميل"
                hud.show(in: self.view)
                DispatchQueue.global(qos: .background).async {
                    let ListOfBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-sections?type=&from=&to="
//                    let typeParameter = UserDefaults.standard.string(forKey: "TYYYPE") ?? ""
                    let param = ["type": "\(self.stoType)" , "to": "\(result)" ,  "from": "\(dateTo)" ]
                    print("oooo", param)
        //            let headers = ["app-id": "\(api_token ?? "")" ]
                    APIServiceForQueryParameter.shared.fetchData(url: ListOfBorsaURL, parameters: param, headers: nil, method: .get) { (success:StatisticsStockSectionsModel?, filier:StatisticsStockSectionsModel?, error) in
                        if let error = error{
                            hud.dismiss()
                            print("============ error \(error)")
                        }else {
                            hud.dismiss()
                            guard let success = success else {return}
                            self.LocalBorsa = success
                            DispatchQueue.main.async {
                                self.StatisticsCollection.reloadData()
                                print(success.data ?? "")
        
                            }
                        }
                    }
                }
            }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        StatisticsCollection.delegate = self
        StatisticsCollection.dataSource = self
        self.StatisticsCollection.register(UINib(nibName: "StatisticesCell", bundle: nil), forCellWithReuseIdentifier: "StatisticesCell")
        //charte
        for x in 0..<5 {
            enteries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        let set = PieChartDataSet(enteries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        pieChartt.data = data

        featchMainDataStat()
    }
    
    
    func featchMainDataStat(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
//                toBackData.setTitle(dateTo, for: .normal)
                let hud = JGProgressHUD(style: .dark)
                hud.textLabel.text = "جاري التحميل"
                hud.show(in: self.view)
                DispatchQueue.global(qos: .background).async {
                    let ListOfBorsaURL = "https://elkenany.com/api/localstock/statistics-stock-sections?type=&from=&to="
//                    let typeParameter = UserDefaults.standard.string(forKey: "TYYYPE") ?? ""
                    let param = ["type": "\(self.stoType)" , "to": "\(result)"  ]
                    print("oooo", param)
        //            let headers = ["app-id": "\(api_token ?? "")" ]
                    APIServiceForQueryParameter.shared.fetchData(url: ListOfBorsaURL, parameters: param, headers: nil, method: .get) { (success:StatisticsStockSectionsModel?, filier:StatisticsStockSectionsModel?, error) in
                        if let error = error{
                            hud.dismiss()
                            print("============ error \(error)")
                        }else {
                            hud.dismiss()
                            guard let success = success else {return}
                            self.LocalBorsa = success
                            DispatchQueue.main.async {
                                self.StatisticsCollection.reloadData()
                                print(success.data ?? "")
        
                            }
                        }
                    }
                }
    }

    
    
    @IBAction func fromDate(_ sender: Any) {
         let FromPickerVC = storyboard?.instantiateViewController(withIdentifier: "FromPicker") as? FromPicker
        FromPickerVC?.DataBackDeleget = self
            self.present(FromPickerVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func toDate(_ sender: Any) {
        let ToPickerVC = storyboard?.instantiateViewController(withIdentifier: "ToPicker") as? ToPicker
        ToPickerVC?.DataBackDelegettwo = self
           self.present(ToPickerVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func chosseCompanyBTN(_ sender: Any) {
        let chosseStokeCV = storyboard?.instantiateViewController(withIdentifier: "ChooseStokeVC") as? ChooseStokeVC
        chosseStokeCV?.typeForStoke = stoType
       // confirem choose stoke delegete  
        chosseStokeCV?.StokeDeleget = self
           self.present(chosseStokeCV!, animated: true, completion: nil)
    }
    
    
    

}






extension statisticsInsideMain:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LocalBorsa?.data?.changesSubs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticesCell", for: indexPath) as!  StatisticesCell
        cell.typeTitle.text = LocalBorsa?.data?.changesSubs?[indexPath.item].name ?? ""
        cell.pricetitle.text = LocalBorsa?.data?.changesSubs?[indexPath.item].change ?? ""
        cell.chanageTitle.text = String( LocalBorsa?.data?.changesSubs?[indexPath.item].counts ?? 0 )
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailsVC = storyboard?.instantiateViewController(identifier: "staticticesDetails") as! staticticesDetails
        let ComId = LocalBorsa?.data?.changesSubs?[indexPath.item].id ?? 0
        UserDefaults.standard.set(ComId, forKey: "ID_Details")
        let ComName = LocalBorsa?.data?.changesSubs?[indexPath.item].name ?? ""
        UserDefaults.standard.set(ComName, forKey: "Name_Details")
        navigationController?.pushViewController(DetailsVC, animated: true)
        
    }

}
