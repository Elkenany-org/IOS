//
//  FodderBorsa.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/19/22.
//

import UIKit
import JGProgressHUD

class FodderBorsa: UIViewController, FilterComaniesDone ,FilterFeedDone, BackDate  {
    func backDateToMain(date: String) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="

//            let typeParameter = UserDefaults.standard.string(forKey: "she")
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "fodder" , "id": "\(self.fodderID)", "date": "\(date)" ]
            print("============== request \(param)")
            let companyGuide =   "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="

//            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.fodderBorsaData = success
                    DispatchQueue.main.async {
                        self.fodderDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    func RunFilterr(filter: ()) {
        FatchLocalBorsaFodderFromFeeds()
    }
    
    func RunFilter(filter: ()) {
        FatchLocalBorsaFodderFromComapnies()
    }
    

    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var fodderDetailsCV: UICollectionView!
    var fodderBorsaData:FodderBorsaModel?
    let date = Date()
    let formatter = DateFormatter()
    var fodderID = 0
    var comType = "fodder"
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetupUI()
        FatchLocalBorsaFodder()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        btnLabel.setTitle( result, for: .normal)
    }
    
    
    
    fileprivate func SetupUI() {
        // Do any additional setup after loading the view.
        fodderDetailsCV.dataSource = self
        fodderDetailsCV.delegate = self
        self.fodderDetailsCV.register(UINib(nibName: "localBorsaCell", bundle: nil), forCellWithReuseIdentifier: "localBorsaCell")
//        fodderDetailsCV.register(UINib(nibName: "haederForborsa", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "haederForborsa")

//        self.fodderDetailsCV.register(UINib(nibName: "testBorsaCell", bundle: nil), forCellWithReuseIdentifier: "test")
//        self.fodderDetailsCV.register(UINib(nibName: "StanderCell", bundle: nil), forCellWithReuseIdentifier: "StanderCell")
    }
    
    
    
    //MARK:- featch Fodder Borsa
    func FatchLocalBorsaFodder(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let companyGuide =   "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="

//            let typeParameter = UserDefaults.standard.string(forKey: "she")
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "fodder" , "id": "\(self.fodderID)", "date": "\(result)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.fodderBorsaData = success
                    DispatchQueue.main.async {
                        self.fodderDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    //MARK:- featch Fodder Borsa from comanies filter
    func FatchLocalBorsaFodderFromComapnies(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let companyGuide =   "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date=&comp_id="

            let COMP_ID_Parameter = UserDefaults.standard.string(forKey: "FILTER_COMP_ID") ?? ""
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "fodder" , "id": "\(self.fodderID)", "date": "\(result)", "comp_id" : "\(COMP_ID_Parameter)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.fodderBorsaData = success
                    DispatchQueue.main.async {
                        self.fodderDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    //MARK:- featch Fodder Borsa from feeds filter
    func FatchLocalBorsaFodderFromFilter(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let companyGuide =  "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date=&food_id="

            let Feed_ID_Parameter = UserDefaults.standard.string(forKey: "IDDD_FILTER") ?? ""
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "fodder" , "id": "\(Feed_ID_Parameter)", "date": "\(result)"]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.fodderBorsaData = success
                    DispatchQueue.main.async {
                        self.fodderDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    

    
    
    //MARK:- featch Fodder Borsa from feeds filter
    func FatchLocalBorsaFodderFromFeeds(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let companyGuide =   "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date=&food_id="

            let Feed_ID_Parameter = UserDefaults.standard.string(forKey: "FILTER_Feed_ID") ?? ""
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "fodder" , "id": "\(Feed_ID_Parameter)", "date": "\(result)"]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.fodderBorsaData = success
                    DispatchQueue.main.async {
                        self.fodderDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    


    @IBAction func filteer(_ sender: Any) {
        if let ComapnyVC = storyboard?.instantiateViewController(identifier: "FilterHome") as? FilterHome {
            ComapnyVC.RunFilterDelegetsInStoke = self
            ComapnyVC.stokeTYPE = "fodder"
            self.present(ComapnyVC, animated: true, completion: nil)
        }
        print("qwerthytreeee")
    }
    
    
    @IBAction func comparing(_ sender: Any) {
        if let statisticesVC = storyboard?.instantiateViewController(identifier: "ComapringHome") as? ComapringHome{
            self.present(statisticesVC, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func statistices(_ sender: Any) {
        if let statisticesVC = storyboard?.instantiateViewController(identifier: "StatisticesMembers") as? StatisticesMembers{
            self.navigationController?.pushViewController(statisticesVC, animated: true)
        }
    }
    
    
    
    @IBAction func companySelecte(_ sender: Any) {
        
        if let ComapnyVC = storyboard?.instantiateViewController(identifier: "CompaniesFodderFilter") as? CompaniesFodderFilter {
            ComapnyVC.RunFilterDelegett = self
            self.present(ComapnyVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func itemSelecte(_ sender: Any) {
        if let feedVCc = storyboard?.instantiateViewController(identifier: "feedFodderFilter") as? feedFodderFilter {
            feedVCc.RunFilterDelegettt = self
            self.present(feedVCc, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK:- Date from picker call back
    @IBAction func dateSelecte(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        
//        vc.completionHandler = {backs in
//            print("======== backs \(backs)")
//
//            let hud = JGProgressHUD(style: .dark)
//            hud.textLabel.text = "جاري التحميل"
//            hud.show(in: self.view)
//
//                DispatchQueue.global(qos: .background).async {
//                    let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//                    print("this is token\(api_token ?? "")")
////                    let typeParameter = UserDefaults.standard.string(forKey: "she")
////                    let idParameter = UserDefaults.standard.string(forKey: "he")
////                    let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")
//
//                    let param = ["type": "fodder" , "id": "\(self.fodderID)", "date": "\(backs ?? "")" ]
//                    print("============== request \(param)")
//                    let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
//                    let statisticesByDate = "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="
//
//                    APIServiceForQueryParameter.shared.fetchData(url: statisticesByDate, parameters: param, headers: headers, method: .get) { (success:FodderBorsaModel?, filier:FodderBorsaModel?, error) in
//                        if let error = error{
//                            hud.dismiss()
//
//                            print("============ error \(error)")
//                        }else {
//                            hud.dismiss()
//                            guard let success = success else {return}
//                            self.fodderBorsaData = success
//                            DispatchQueue.main.async {
//                                self.fodderDetailsCV.reloadData()
////                                self.btnLabel.titleLabel?.text = backs
//                                print(success.data ?? "")
//                            }
//
//                        }
//                    }
//                }
//
//            return backs
//        }
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension FodderBorsa: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fodderBorsaData?.data?.members?.count ?? 0
    }

    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "localBorsaCell", for: indexPath) as? localBorsaCell{
            
            cell1.proudectName.text = fodderBorsaData?.data?.members?[indexPath.item].name ?? ""
            cell1.priceOfProudect.text = fodderBorsaData?.data?.members?[indexPath.item].feed ?? ""
            cell1.weightStat.text = String(fodderBorsaData?.data?.members?[indexPath.item].price ?? 0)
            cell1.changeLabel.text = fodderBorsaData?.data?.members?[indexPath.item].change ?? ""
            cell1.changeTwo.text = fodderBorsaData?.data?.members?[indexPath.item].changeDate ?? ""
            let statimage = fodderBorsaData?.data?.members?[indexPath.item].statistics ?? ""
            cell1.configureCell(image: statimage)
             return cell1
          }
        return UICollectionViewCell()
        }
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var id_fod_borsa = fodderBorsaData?.data?.members?[indexPath.row].memID ?? 0
    }

    
    }
    
    
    
    
    
    
extension FodderBorsa:BorsaFilterss{
    func RunFilterDone(filter: ()) {
        FatchLocalBorsaFodderFromFilter()
        
    }
    
    
}
 
    
