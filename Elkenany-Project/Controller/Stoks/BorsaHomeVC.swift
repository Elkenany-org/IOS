//
//  BorsaHomeVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/19/21.
//

import UIKit
import Alamofire
import JGProgressHUD

protocol testProtocol {
    var name:String { get }
    var id:Int { get set}
    
}


class BorsaHomeVC: UIViewController  {
    
    //MARK:- Outlets
    @IBOutlet weak var SelectedSector: UICollectionView!
    @IBOutlet weak var bannersCV: UICollectionView!
    @IBOutlet weak var pageControle: UIPageControl!
    @IBOutlet weak var logosCV: UICollectionView!
    @IBOutlet weak var BorsaCV: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchBarView: UISearchBar!
    
    @IBOutlet weak var logosView: UIView!
    @IBOutlet weak var bannerView: UIView!
    //MARK:- prametars
    var timer:Timer?
    var currentIndex = 0
    var itemsArray = [  "zoz" , "zoz" , "zoz"]
    var borsaData:BorsaHomeDataModel?
    var Sector = "poultry"
    var sectorTypeFromHeader = ""
    private var  BorsaSubModel:[Sections] = []
    private var  fodderSubModel:[FodSections] = []
    private var  sectorSubModel:[Sectorss] = []
    private var  logosSubModel:[log] = []
    private var  bannersSubModel:[Banner] = []
    var startIndex: Int! = 1
    
    
    
    //MARK:- view DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTimer()
        title = "البورصة اليومية"
        featchBorsaSubSections()
        setupSearchBar()
        
    }
    
    
    //MARK:- Setup UI
    fileprivate func setupUI() {
        SelectedSector.dataSource = self
        SelectedSector.delegate = self
        bannersCV.dataSource = self
        bannersCV.delegate = self
        BorsaCV.dataSource = self
        BorsaCV.delegate = self
        logosCV.dataSource = self
        logosCV.delegate = self
        self.SelectedSector.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
        self.bannersCV.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        self.BorsaCV.register(UINib(nibName: "GuideCompanyCell", bundle: nil), forCellWithReuseIdentifier: "GuideCompanyCell")
        self.logosCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        
    }
    
    
    //MARK:- Timer of slider and page controller ?? 0 -1
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MoveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func MoveToNextIndex(){
        if currentIndex < bannersSubModel.count {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        bannersCV.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    //MARK:- FeatchData for Borsa by saerching  [Sectors]
    func searchForBorsa(){
        let searchParamater = self.searchBarView.text ?? ""
        let param = ["type": "\(self.Sector)" , "search": "\(searchParamater)"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-sections?type=&search="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (Borsasuccess:BorsaHomeDataModel?, Borsafilier:BorsaHomeDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    let successData = Borsasuccess?.data?.subSections ?? []
                    self.BorsaSubModel.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
                        self.BorsaCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    
    //MARK:- FeatchData for Borsa [Company sub_sections] and data for the main
    func featchBorsaSubSections(){
        
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "\(self.Sector)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-sections?type=&search="
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (Borsasuccess:BorsaHomeDataModel?, Borsafilier:BorsaHomeDataModel?, error) in
                if let error = error{
                    hud.dismiss()

                    print("============ error \(error)")
                    
                }else {
                    hud.dismiss()

                    let successData = Borsasuccess?.data?.sectors?.reversed() ?? []
                    self.sectorSubModel.append(contentsOf: successData)
                    let successDataaa = Borsasuccess?.data?.subSections ?? []
                    self.BorsaSubModel.append(contentsOf: successDataaa)
                    ///for banners and logs
                    let successDataaaBanners = Borsasuccess?.data?.banners ?? []
                    self.bannersSubModel.append(contentsOf: successDataaaBanners)
                    let successDataLogos = Borsasuccess?.data?.logos ?? []
                    self.logosSubModel.append(contentsOf: successDataLogos)
                    let successDatafodder = Borsasuccess?.data?.fodSections ?? []
                    self.fodderSubModel.append(contentsOf: successDatafodder)
                    
                    DispatchQueue.main.async {
                      
//                        self.bannersCV.reloadData()
//                        self.logosCV.reloadData()
//                        self.BorsaCV.reloadData()
                        
                        
                        
                        if self.logosSubModel.isEmpty == true && self.bannersSubModel.isEmpty == false {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = false
                            self.bannersCV.reloadData()
                            
                            
                        } else if self.logosSubModel.isEmpty == false && self.bannersSubModel.isEmpty == true {
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = true
                            self.logosCV.reloadData()
                            
                            
                        }else if self.logosSubModel.isEmpty  == true && self.bannersSubModel.isEmpty == true {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = true
                            
                            
                        }else{
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = false
                            
                            self.bannersCV.reloadData()
                            self.logosCV.reloadData()
                        }
                        
                        self.BorsaCV.reloadData()
                        self.SelectedSector.reloadData()
                        
                        
                    }
                }
            }
        }
    }
    
    func featchBorsaSubSectionsFromMore(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["type": "poultry"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-sections?type=&search="
            
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (Borsasuccess:BorsaHomeDataModel?, Borsafilier:BorsaHomeDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    
                    let successData = Borsasuccess?.data?.sectors ?? []
                    self.sectorSubModel.append(contentsOf: successData)
                    let successDataaa = Borsasuccess?.data?.subSections ?? []
                    self.BorsaSubModel.append(contentsOf: successDataaa)
                    ///for banners and logs
                    let successDataaaBanners = Borsasuccess?.data?.banners ?? []
                    self.bannersSubModel.append(contentsOf: successDataaaBanners)
                    let successDataLogos = Borsasuccess?.data?.logos ?? []
                    self.logosSubModel.append(contentsOf: successDataLogos)
                    let successDatafodder = Borsasuccess?.data?.fodSections ?? []
                    self.fodderSubModel.append(contentsOf: successDatafodder)
                    
                    
                    DispatchQueue.main.async {
                        self.BorsaCV.reloadData()
                        self.SelectedSector.reloadData()
                        self.bannersCV.reloadData()
                        self.logosCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    //MARK:- FeatchData for Borsa [Company sub_sections]
    func FatchBorsaBySector(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-sections?type=&search="
            let param = ["type": "\(self.sectorTypeFromHeader )"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:BorsaHomeDataModel?, filier:BorsaHomeDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.BorsaSubModel.removeAll()
                    self.logosSubModel.removeAll()
                    self.bannersSubModel.removeAll()
                    self.fodderSubModel.removeAll()
                    
                    
                    let successData = success?.data?.subSections ?? []
                    self.BorsaSubModel.append(contentsOf: successData)
                    let successDataaaBanners = success?.data?.banners ?? []
                    self.bannersSubModel.append(contentsOf: successDataaaBanners)
                    let successDataLogos = success?.data?.logos ?? []
                    self.logosSubModel.append(contentsOf: successDataLogos)
                    let successDatafodder = success?.data?.fodSections ?? []
                    self.fodderSubModel.append(contentsOf: successDatafodder)
                    
                    DispatchQueue.main.async {
                        
                        
//                        self.SelectedSector.reloadData()
                        //                        self.bannersCV.reloadData()
                        //                        self.logosCV.reloadData()
                        //                        self.BorsaCV.reloadData()
                        
                        
                        
                        if self.logosSubModel.isEmpty == true && self.bannersSubModel.isEmpty == false {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = false
                            self.bannersCV.reloadData()
                            
                            
                        } else if self.logosSubModel.isEmpty == false && self.bannersSubModel.isEmpty == true {
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = true
                            self.logosCV.reloadData()
                            self.bannersCV.reloadData()

                            
                            
                        }else if self.logosSubModel.isEmpty  == true && self.bannersSubModel.isEmpty == true {
                            self.logosView.isHidden = true
                            self.bannerView.isHidden = true
                            
                            
                        }else{
                            self.logosView.isHidden = false
                            self.bannerView.isHidden = false
                            
                            self.bannersCV.reloadData()
                            self.logosCV.reloadData()
                        }
                        
                        self.BorsaCV.reloadData()

                        
                        
                        
                        
                        
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
    
    
    //MARK:- statistics Inside Main
    @IBAction func mainStastices(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "statisticsInsideMain"))! as statisticsInsideMain
        vc.stoType = Sector
        //        vc.stoType = sectorTypeFromHeader
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Filter Inside Main
    @IBAction func filterBorsaVC(_ sender: Any) {
        let filtervc = (storyboard?.instantiateViewController(identifier: "FilterVC"))! as FilterVC
        filtervc.RunFilterDeleget = self
        present(filtervc, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func toFilter(_ sender: Any) {
        
        let filtervc = (storyboard?.instantiateViewController(identifier: "FilterVC"))! as FilterVC
        filtervc.presentKey = "keeey"
        filtervc.RunFilterDeleget = self
        //        filtervc.presentHomeFilter = "home"
        
        present(filtervc, animated: true, completion: nil)
        
    }
    
    
    
    //search appearnce handling btn
    @IBAction func showSearchView(_ sender: Any) {
        searchView.isHidden = false
        view1.isHidden = true
    }
    
}



//MARK:- Configuer Collections
extension BorsaHomeVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == SelectedSector { return 1 }
        else if collectionView == bannersCV { return 1 }
        else if collectionView == logosCV{ return 1 }
        else if collectionView == BorsaCV{ return 2 }
        else{ return 1}
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == SelectedSector { return sectorSubModel.count }
        else if collectionView == bannersCV { return bannersSubModel.count}
        else if collectionView == logosCV{ return logosSubModel.count }
        else if collectionView == BorsaCV{
            switch section {
            case 0: return BorsaSubModel.count
            case 1: return fodderSubModel.count
            default: return 1 }}
        else{ return 1 }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == SelectedSector { 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
            cell.titleLabel.text = sectorSubModel[indexPath.item].name ?? ""
            let typeeee = sectorSubModel[indexPath.item].type ?? "test"
            
            if typeeee == Sector {
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
                SelectedSector.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            }else{ cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1) }
            return cell
        }
        
        
        else if collectionView == bannersCV {
            if  let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCell {
            let imageSlider = bannersSubModel[indexPath.item].image ?? ""
            ss(ss: cell2)
            cell2.configureCell(image: imageSlider)
            return cell2
            }
        }
        
        else if collectionView == logosCV{
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as! logosCell
            let imageeee = logosSubModel[indexPath.item].image ?? ""
            cell3.logooImage.contentMode = .scaleAspectFit
            ss(ss: cell3)
            
            cell3.configureImage(image: imageeee)
            return cell3
        }
        
        
        else if collectionView == BorsaCV{
            if indexPath.section == 0{
                let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCompanyCell", for: indexPath) as! GuideCompanyCell
                cell4.companyTitle.text = BorsaSubModel[indexPath.item].name ?? ""
                //                cell4.companiesCount.text = String( BorsaSubModel[indexPath.item].members ?? 0)
                
                let imageBorsaSubSection = BorsaSubModel[indexPath.row].image ?? ""
                cell4.companyImage.contentMode = .scaleToFill
                
                cell4.configureCell(image: imageBorsaSubSection)
                ss(ss: cell4)
                return cell4
            }
            
            else if indexPath.section == 1{
                let cell5 = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCompanyCell", for: indexPath) as! GuideCompanyCell
                cell5.companyTitle.text = fodderSubModel[indexPath.item].name ?? ""
                //                cell5.companiesCount.text = String( fodderSubModel[indexPath.item].members ?? 0)
                let imageBorsaFoder = fodderSubModel[indexPath.row].image ?? ""
                cell5.configureCell(image: imageBorsaFoder)
                ss(ss: cell5)
                return cell5
            }
        }else{ return UICollectionViewCell()}
        return UICollectionViewCell()
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selected from sectore at header
        if collectionView == SelectedSector {
            let typeOfSector = sectorSubModel[indexPath.item].type ?? ""
            UserDefaults.standard.set(typeOfSector, forKey: "TYPE_FOR_FILTER")
            self.sectorTypeFromHeader = typeOfSector
            let cell = collectionView.cellForItem(at: indexPath) as! SelectedSectorCell
            if(cell.isSelected == true)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.5882352941, blue: 0, alpha: 1)
                SelectedSector.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            }
            FatchBorsaBySector()
        }
        else if collectionView == bannersCV {
            if let url = NSURL(string: "\(bannersSubModel[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
        }
        
        else if collectionView == logosCV{
            if let url = NSURL(string: "\(logosSubModel[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
        }
        
        
        //selected from cells
        else if collectionView == BorsaCV{
            if indexPath.section == 0{
                
                if let vc = (storyboard?.instantiateViewController(identifier: "BorsaDetails")) as? BorsaDetails{
                    let id = BorsaSubModel[indexPath.item].id ?? 0
                    let type1 = BorsaSubModel[indexPath.item].type ?? ""
                    let BorsaTitle = BorsaSubModel[indexPath.item].name ?? ""
                    vc.localTitle = BorsaTitle
                    UserDefaults.standard.set(id, forKey: "he")
                    UserDefaults.standard.set(type1, forKey: "she")
                    vc.variaTest = type1
                    vc.title = BorsaTitle
                    vc.loc_id = id
                    vc.FatchLocalBorsa()
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            else if indexPath.section == 1{
                let vc = (storyboard?.instantiateViewController(identifier: "FodderBorsa"))! as FodderBorsa
                //                vc.fodderParam = fodderSubModel[indexPath.item].type ?? ""
                //                vc.fodder_id = fodderSubModel[indexPath.item].id ?? 0
                let FodderType = fodderSubModel[indexPath.item].type ?? ""
                UserDefaults.standard.set(FodderType, forKey: "she")
                
                let FodderID = fodderSubModel[indexPath.item].id ?? 0
                UserDefaults.standard.set(FodderID, forKey: "he")
                
                let fooderTit = fodderSubModel[indexPath.item].name ?? ""
                UserDefaults.standard.set(fooderTit, forKey: "BORSA_TITLEEEE")
                
                //                vc.fodderTypeParamter = FodderType
                vc.fodderID = FodderID
                vc.title = fooderTit
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let sizeOne = (collectionView.frame.size.width - 35 ) / 5
        if collectionView == SelectedSector { return CGSize(width:sizeOne, height: 55) }
        
        else if collectionView == bannersCV {
            return CGSize(width: collectionView.frame.width - 5, height: collectionView.frame.height )
        }
        else if collectionView == logosCV{
            return CGSize(width: 80, height: 60)
            
        }else if collectionView == BorsaCV{
            
            if indexPath.section == 0{
                let size = (collectionView.frame.size.width )
                return CGSize(width: size, height: 120)
            }else if indexPath.section == 1{
                let size = (collectionView.frame.size.width )
                return CGSize(width: size, height: 110)
            }
        }else{
            return CGSize(width: 200, height: 200)
        }
        return CGSize(width: 200, height: 200)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectedSectorCell{
            
            if(cell.isSelected == false)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }
        }
    }
}




//MARK:- Handling UISearch bar inside the main Borsa
extension BorsaHomeVC : UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBarView.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false {
            //your model
            let data = borsaData?.data?.subSections ?? []
            //your array
            BorsaSubModel = data.filter({ ($0.name?.contains(searchText) ?? (0 != 0)) })
            BorsaSubModel.removeAll()
            
            //Api func
            searchForBorsa()
        }
        
        //reload
        BorsaCV.reloadData()
        
    }
    
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let cBtn = searchBar.value(forKey: "cancelButton") as? UIButton {
            cBtn.setTitle("الغاء", for: .normal)
            searchBar.tintColor = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        }
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.isHidden = true
        view1.isHidden = false
        BorsaSubModel.removeAll()
        self.logosSubModel.removeAll()
        self.bannersSubModel.removeAll()
        self.fodderSubModel.removeAll()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        featchBorsaSubSections()
        hud.dismiss()
        
        print("cancellllld")
    }
}




//MARK:- filter service
extension BorsaHomeVC : FilterDone {
    func RunFilter(filter: ()) {
        let typeFilter = UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER")
        let sortFilter = UserDefaults.standard.string(forKey: "SORT_FOR_FILTER")
        let param = ["type": "\(typeFilter ?? "")" , "sort": "\(sortFilter ?? "")"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-sections?type=&search=&sort="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (Borsasuccess:BorsaHomeDataModel?, Borsafilier:BorsaHomeDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    self.BorsaSubModel.removeAll()
                    self.fodderSubModel.removeAll()
                    let successData = Borsasuccess?.data?.subSections ?? []
                    self.BorsaSubModel.append(contentsOf: successData)
                    let successDatafodder = Borsasuccess?.data?.fodSections ?? []
                    self.fodderSubModel.append(contentsOf: successDatafodder)
                    
                    DispatchQueue.main.async {
                        self.BorsaCV.reloadData()
                        
                    }
                }
            }
        }
    }
}

