//
//  BorsaDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/25/21.
//

import UIKit
import ProgressHUD

class BorsaDetails: UIViewController, BorsaFilterss {
    
    func RunFilterDone(filter: ()) {
        FatchLocalBorsaFromFilter()
    }
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var LocalBorsaCV: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var logosCV: UICollectionView!
    @IBOutlet weak var bannersCV: UICollectionView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var logosView: UIView!
    
    @IBOutlet weak var updateLabel: UILabel!
    
    
    var variaTest = ""
    var fodderTypeParamter = ""
    var fodder_id_Parameter = 0
    var fodderTitle = ""
    var localTitle = ""
    var borsaTit = ""
    var loc_id = 0
    var type = ""
    var sto_type = "local"
    let date = Date()
    let formatter = DateFormatter()
    var timer:Timer?
    var startIndex: Int! = 1
    var currentIndex = 0
    
    //Proparites and Outlets
    var localBorsaData:LocaBorsa?
    var fodderBorsaData:FodderBorsaModel?
    var logossModel:[logg] = []
    var bannerssModel:[Bannerr] = []
    var arrone = ["الاسم" , "السعر" , "مقدار" , "نظام الشحن" ,"اتجاه السعر"]
    var arrTwo = ["الاسم" , "السعر" , "مقدار" ,"اتجاه السعر"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        //        setTimer()
        title = "تفاصيل البورصة"
        print("vTest \(variaTest)")
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "zh")

        let result = formatter.string(from: date)
        //        btnLabel.setTitle( result, for: .normal )
        LogosandBanners()
        
        
    }
    
    
    
    
    //MARK:- setup ui for Borsa Collection
    fileprivate func SetupUI() {
        // Do any additional setup after loading the view.
        LocalBorsaCV.dataSource = self
        LocalBorsaCV.delegate = self
        logosCV.delegate = self
        logosCV.dataSource = self
        bannersCV.delegate = self
        bannersCV.dataSource = self
        logosCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        self.bannersCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.LocalBorsaCV.register(UINib(nibName: "localBorsaCell", bundle: nil), forCellWithReuseIdentifier: "localBorsaCell")
        self.LocalBorsaCV.register(UINib(nibName: "testBorsaCell", bundle: nil), forCellWithReuseIdentifier: "test")
        self.LocalBorsaCV.register(UINib(nibName: "StanderCell", bundle: nil), forCellWithReuseIdentifier: "StanderCell")
    }
    
    
    
    //MARK:- Timer of slider and page controller ?? 0 -1
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MoveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func MoveToNextIndex(){
        if currentIndex < bannerssModel.count {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        bannersCV.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        //        pageControle.currentPage = currentIndex
    }
    
    
    
    
    //MARK:- present picker view for choose Date
    @IBAction func presentDate(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    func FatchLocalBorsa(){
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "zh")

        let result = formatter.string(from: date)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide =   "https://admin.elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="
            
            let param = ["type": "local" , "id": "\(self.loc_id)", "date": "\(result)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }  else if let loginErrorr = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()
                    
                    print(loginErrorr.message ?? "6666666666666")
                }
                
                else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                        print(success)
                        
                    }
                }
            }
        }
    }
    
    
    func LogosandBanners(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        let param = ["type": "local" , "id": "\(self.loc_id)" ]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["Authorization": "\(api_token ?? "")" ]
            let SearchGuide = "https://admin.elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="
            APIServiceForQueryParameter.shared.fetchData(url: SearchGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    let successDatalogos = success?.data?.logos ?? []
                    self.logossModel.append(contentsOf: successDatalogos)
                    let successDatabanners = success?.data?.banners ?? []
                    self.bannerssModel.append(contentsOf: successDatabanners)
                    DispatchQueue.main.async {
                        
                        
                        
                        
                        if self.logossModel.isEmpty == true && self.bannerssModel.isEmpty == false {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = false
                            self.bannersCV.reloadData()
                            
                            
                        } else if self.logossModel.isEmpty == false && self.bannerssModel.isEmpty == true {
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = true
                            self.logosCV.reloadData()
                            self.bannersCV.reloadData()
                            
                            
                            
                        }else if self.logossModel.isEmpty  == true && self.bannerssModel.isEmpty == true {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = true
                            
                            
                        }else{
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = false
                            
                            self.bannersCV.reloadData()
                            self.logosCV.reloadData()
                        }
                        
         
                    }
                }
            }
        }
    }
    
    
    
    
    
    func FatchLocalBorsaFromFilter(){
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "zh")

        let result = formatter.string(from: date)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide =   "https://admin.elkenany.com/api/localstock/new-local-stock-show-sub-section?id=&type=&date="
            let paramaaa = UserDefaults.standard.string(forKey: "ID_FILTER") ?? ""
      
            let param = ["type": "local" , "id": "\(paramaaa )", "date": "\(result)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                        print(success)
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    func FatchLocalBorsaFromHomeSelection(){
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://admin.elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let typeParameter = UserDefaults.standard.string(forKey: "REC_type_Stoke")
            let idParameter = UserDefaults.standard.string(forKey: "REC_Id_Stoke")
            
            let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                        
                        
                        
                    }
                    
                }
            }
        }
    }
    
    
    
    @IBAction func toStatisticesMainVC(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StatisticesMembers") as? StatisticesMembers
        vc?.typeFromBorsa = variaTest
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func toFilter(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterHome") as? FilterHome
        vc?.stokeTYPE = sto_type
        vc?.RunFilterDelegetsInStoke = self
        //        vc?.presentHomeFilter = "home"
        self.present(vc!, animated: true, completion: nil)
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
    
}



//MARK:- For Borsa details
extension BorsaDetails:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    // number of sections --------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    //number of row in section ------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == logosCV{ return logossModel.count}
        else if collectionView == bannersCV{ return bannerssModel.count}
        else if collectionView == LocalBorsaCV{ return localBorsaData?.data?.members?.count ?? 0}
        else{ return 1 }
    }
    
    
    
    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        updateLabel.text = success?.data?.members?[indexPath.item]
        
        
        if collectionView == logosCV{
            if let Logoscell = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as? logosCell{
                let imageeee = logossModel[indexPath.item].image ?? ""
                Logoscell.configureImage(image: imageeee)
                ss(ss: Logoscell)
                //                Logoscell.logooImage.contentMode = .scaleAspectFit
                return Logoscell
            }
            
        }
        else if collectionView == bannersCV{
            if let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell{
                let imageeee = bannerssModel[indexPath.item].image ?? ""
                bannerCell.configureCell(image: imageeee)
                bannerCell.bannerImage.contentMode = .scaleToFill
                ss(ss: bannerCell )
                return bannerCell
            }
        }
        else if collectionView == LocalBorsaCV{
            if localBorsaData?.data?.members?[indexPath.item].newColumns?.count == nil && localBorsaData?.data?.members?.count != nil{
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "StanderCell", for: indexPath) as! StanderCell
                cell1.proudectLabel.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
                cell1.priceLabel.text = localBorsaData?.data?.members?[indexPath.item].price ?? ""
                cell1.changeLabel.text = localBorsaData?.data?.members?[indexPath.item].change ?? ""
                cell1.changeTwo.text = localBorsaData?.data?.members?[indexPath.item].changetwo ?? ""
                let statimage = localBorsaData?.data?.members?[indexPath.item].statistics ?? ""
                cell1.configureCell(image: statimage)
                view1.isHidden = true
                view2.isHidden = false
                
                if localBorsaData?.data?.members?[indexPath.item].type == 1 {
                    cell1.rankView.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
                }
                
                
                
                return cell1
                
                
            } else if localBorsaData?.data?.members?[indexPath.item].newColumns?.count == 1  && localBorsaData?.data?.members?.count != nil{
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "localBorsaCell", for: indexPath) as! localBorsaCell
                cell2.proudectName.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
                cell2.priceOfProudect.text = localBorsaData?.data?.members?[indexPath.item].price ?? ""
                cell2.changeLabel.text = localBorsaData?.data?.members?[indexPath.item].change ?? ""
                cell2.changeTwo.text = localBorsaData?.data?.members?[indexPath.item].changetwo ?? ""
                for i in localBorsaData?.data?.members?[indexPath.item].newColumns ?? []{
                    cell2.weightStat?.text = i
                    
                }
                
                let imageStat = localBorsaData?.data?.members?[indexPath.item].statistics ?? ""
                cell2.configureCell(image: imageStat)
                view1.isHidden = false
                view2.isHidden = true
                return cell2
                
            }else{
                ///missed
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! testBorsaCell
                cell3.proudectName.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
                cell3.price.text = localBorsaData?.data?.members?[indexPath.item].price ?? ""
                //            cell3.kindd.text = localBorsaData?.data?.members?[indexPath.item].kind ?? ""
                cell3.changes.text = localBorsaData?.data?.members?[indexPath.item].change ?? ""
                cell3.changeTwo.text = localBorsaData?.data?.members?[indexPath.item].changetwo ?? ""
                //            cell3.proudectName.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
                for i in localBorsaData?.data?.members?[indexPath.item].newColumns ?? []{
                    cell3.weight.text = i
                    
                }
                
                
                let imageStat = localBorsaData?.data?.members?[indexPath.item].statistics ?? ""
                cell3.configureCell(image: imageStat)
                
                
                return cell3
            }
        }
        
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannersCV {
            if let url = NSURL(string: "\(bannerssModel[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
        }else if collectionView == logosCV{
            if let url = NSURL(string: "\(logossModel[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
        }else{
            print("helloooo world")
        }
    }
    
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: collectionView.frame.width, height: 65)
        
        if collectionView == logosCV{ return CGSize(width: 65, height: 60)}
        else if collectionView == bannersCV{ return CGSize(width: collectionView.frame.width, height: 100)}
        else if collectionView == LocalBorsaCV{ return CGSize(width: collectionView.frame.width, height: 60)}
        else{  return CGSize(width: collectionView.frame.width, height: 60) }
    }
    
    
}
















extension BorsaDetails:BackDate{
    func backDateToMain(date: String) {
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let typeParameter = UserDefaults.standard.string(forKey: "she")
            let idParameter = UserDefaults.standard.string(forKey: "he")
            //                    let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")
            
            let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")", "date": "\(date)" ]
            print("============== request \(param)")
            //            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let statisticesByDate = "https://admin.elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            
            APIServiceForQueryParameter.shared.fetchData(url: statisticesByDate, parameters: param, headers: nil, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    
                    print("============ error \(error)")
                }  else if let loginErrorr = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()
                    
                    print(loginErrorr.message ?? "6666666666666")
                    self.LocalBorsaCV.isHidden = true
                    self.errorView.isHidden = false
                    
                }
                
                
                
                else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                        self.LocalBorsaCV.isHidden = false
                        self.errorView.isHidden = true
                    }
                    
                }
            }
        }
    }
    
    
}

