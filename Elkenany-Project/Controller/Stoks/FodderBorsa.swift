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
    
    @IBOutlet weak var logosview: UIView!
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var logosCollection: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    var fodderBorsaData:FodderBorsaModel?
    
    let date = Date()
    let formatter = DateFormatter()
    var fodderID = 0
    var comType = "fodder"
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var itemSelection: UILabel!
    
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
        
        logosCollection.dataSource = self
        logosCollection.delegate = self
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        self.fodderDetailsCV.register(UINib(nibName: "localBorsaCell", bundle: nil), forCellWithReuseIdentifier: "localBorsaCell")
        self.bannerCollectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.logosCollection.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        
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
                        
                        
                        if self.fodderBorsaData?.data?.logos?.isEmpty == true && self.fodderBorsaData?.data?.banners?.isEmpty == false {
                            self.logosview.isHidden = true
                            self.bannerView.isHidden = false
                            self.bannerCollectionView.reloadData()
                            self.fodderDetailsCV.reloadData()
                            
                            
                        } else if self.fodderBorsaData?.data?.logos?.isEmpty == false && self.fodderBorsaData?.data?.banners?.isEmpty == true {
                            self.logosview.isHidden = false
                            self.bannerView.isHidden = true
                            self.logosCollection.reloadData()
                            self.fodderDetailsCV.reloadData()
                            
                            
                        }else if self.fodderBorsaData?.data?.logos?.isEmpty == true && self.fodderBorsaData?.data?.banners?.isEmpty == true {
                            self.logosview.isHidden = true
                            self.bannerView.isHidden = true
                            self.fodderDetailsCV.reloadData()

                            
                        }else{
                            self.logosview.isHidden = false
                            self.bannerView.isHidden = false
                            
                            self.fodderDetailsCV.reloadData()
                            self.logosCollection.reloadData()
                            self.bannerCollectionView.reloadData()
                            print(success.data ?? "")
                        }
                        
                        
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
    
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 5.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.darkGray.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
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
            
            let Feed_ID_Parameter = UserDefaults.standard.string(forKey: "FILTER_Feed_ID") ?? ""
            let companyGuide =   "https://elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date=&food_id="
            
            //            let idParameter = UserDefaults.standard.string(forKey: "he")
            //            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")
            
            let param = ["type": "fodder" , "food_id": "\(Feed_ID_Parameter)", "date": "\(result)" , "id" : "\(self.fodderID)"]
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
        
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension FodderBorsa: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == fodderDetailsCV {
            return fodderBorsaData?.data?.members?.count ?? 0
        } else if collectionView == logosCollection {
            
            return fodderBorsaData?.data?.logos?.count ?? 0
        } else {
            return fodderBorsaData?.data?.banners?.count ?? 0
        }
        
        
        
        
        
    }
    
    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == fodderDetailsCV {
            
            if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "localBorsaCell", for: indexPath) as? localBorsaCell{
                selectionLabel.text = fodderBorsaData?.data?.members?[indexPath.item].name ?? ""
                itemSelection.text = fodderBorsaData?.data?.members?[indexPath.item].feed ?? ""
                cell1.proudectName.text = fodderBorsaData?.data?.members?[indexPath.item].name ?? ""
                cell1.priceOfProudect.text = fodderBorsaData?.data?.members?[indexPath.item].feed ?? ""
                cell1.weightStat.text = String(fodderBorsaData?.data?.members?[indexPath.item].price ?? 0)
                cell1.changeLabel.text = fodderBorsaData?.data?.members?[indexPath.item].change ?? ""
                cell1.changeTwo.text = fodderBorsaData?.data?.members?[indexPath.item].changeDate ?? ""
                let statimage = fodderBorsaData?.data?.members?[indexPath.item].statistics ?? ""
                cell1.configureCell(image: statimage)
                return cell1
            }
            
            
            
        } else if collectionView == logosCollection {
            
            
            if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as? logosCell{
                let logoImage = fodderBorsaData?.data?.logos?[indexPath.item].image ?? ""
                ss(ss: cell1)
                cell1.configureImage(image: logoImage)
                return cell1
            } }
        
        else {
            if let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell{
                let bannerImage = fodderBorsaData?.data?.banners?[indexPath.item].image ?? ""
                ss(ss: cell2)
                cell2.configureCell(image: bannerImage)
                return cell2
                
            }}
        
        return UICollectionViewCell()
    }
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == fodderDetailsCV {
            return CGSize(width: collectionView.frame.width, height: 60)
        } else if collectionView == logosCollection {
            return CGSize(width: 65, height: 65)
            
        } else {
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}








extension FodderBorsa:BorsaFilterss{
    func RunFilterDone(filter: ()) {
        FatchLocalBorsaFodderFromFilter()
    }
}


