//
//  SectorsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit
import Alamofire
import ProgressHUD


class SectorsVC: UIViewController {
    
    //outlets
    @IBOutlet weak var sectorsCV: UICollectionView!
    var homeDataSectorsModel:HomeSectorsDataModel?
    var homeGuide:GuideCompaniesDataModel?
    
    @IBOutlet weak var videoViewContainer:UIView!
    var sss:HomeData?
    var sector:[Sectors]?
    var arr = [   "القطاع", "مقترح لك", "شركاء النجاح", "البورصة اليومية", "دليل الكناني", "السوق", "الاخبار" ]
//    let images:[UIImage] = [ #imageLiteral(resourceName: "Group 2800-1") , #imageLiteral(resourceName: "Group 1026")  , #imageLiteral(resourceName: "Group 1027") , #imageLiteral(resourceName: "Group 2802") , #imageLiteral(resourceName: "Group 1029") , #imageLiteral(resourceName: "Group 2907")]
    var typeForRecomendition = ""
    
    //    let viewsw = ServiceViewController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    //viewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("yeeeeees")
        setupUI()
        GetHomeDataFromServer()
        print("did apear 123567")
        
        
    }
    
    
    
    
    //MARK:- featch Data from server
    
    func setupUI() {
        sectorsCV.dataSource = self
        sectorsCV.delegate = self
        sectorsCV.collectionViewLayout = creatCompositionalLayout()
        self.sectorsCV.register(UINib(nibName: "SectorsCell", bundle: nil), forCellWithReuseIdentifier: "SectorsCell")
        self.sectorsCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        
        self.sectorsCV.register(UINib(nibName: "successCell", bundle: nil), forCellWithReuseIdentifier: "successCell")
        sectorsCV.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderCell")
    }
    
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    func Sectore(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 30
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    
    
    //composition layout data
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self](index , evnvironemt) -> NSCollectionLayoutSection?in
            return self!.creatSectionFor(index: index, environment: evnvironemt )
        }
        return layout
    }
    
    
    
    
    
    
    func creatSectionFor(index:Int , environment:NSCollectionLayoutEnvironment) ->NSCollectionLayoutSection{
        switch index {
        case 0:
            return creatFirstSection()
        case 1:
            return creatSecondSection()
        case 2:
            return creatthirdSection()
        default:
            return creatSecondSection()
        }
        
    }
    
    
    
    
    
    
    func creatFirstSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.36))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    
    
    
    func creatSecondSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.46))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
    func creatthirdSection() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
    //MARK:- featch Data from server
    func GetHomeDataFromServer(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers:HTTPHeaders = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: HomeSectorsURL,
                                                         parameters: nil,
                                                         headers: headers,
                                                         method: .get) {
                (SuccessfulRequest:HomeSectorsDataModel?,
                 FailureRequest:HomeSectorsDataModel?,
                 error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                    
                }
                else if let loginError = FailureRequest {
                    //Data Wrong From Server
                    print(loginError)
                }
                
                else {
                    ProgressHUD.dismiss()
                    guard let success = SuccessfulRequest else {return}
                    self.homeDataSectorsModel = success
                    DispatchQueue.main.async {
                        self.sectorsCV.reloadData()
                    }
                }
            }
        }
        
    }
    
    
}







//MARK:- featch Data from server

extension SectorsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //section number
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    
    //number of cells on collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //collection count
        switch section {
        case 0:
            return homeDataSectorsModel?.data?.sectors?.count ?? 0
            
        case 1:
            return homeDataSectorsModel?.data?.recomandtion?.count ?? 0
            
        case 2:
            return homeDataSectorsModel?.data?.logos?.count ?? 0
            
            
        case 3:
            return homeDataSectorsModel?.data?.stock?.count ?? 0
            
        case 4:
            return homeDataSectorsModel?.data?.guide?.count ?? 0
            
        case 5:
            return homeDataSectorsModel?.data?.store?.count ?? 0
        case 6:
            return homeDataSectorsModel?.data?.news?.count ?? 0
            
            
        default:
            return homeDataSectorsModel?.data?.sectors?.count ?? 0
            
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            
            if let sectoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as? logosCell {
                let image = homeDataSectorsModel?.data?.sectors?[indexPath.item].image ?? ""
                sectoreCell.configureImage(image: image)
                sectoreCell.logooImage.contentMode = .scaleAspectFill
                
                Sectore(ss: sectoreCell)
                return sectoreCell }
            
        case 1 :
            
            if let recomanditionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell{
                recomanditionCell.SecrorsName.text = homeDataSectorsModel?.data?.recomandtion?[indexPath.row].name ?? "dev test"
                recomanditionCell.SecrorsName.font = UIFont(name: "Cairo", size: 13.0)
                let successMembersImage = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].image ?? ""
                recomanditionCell.configureCell(image: successMembersImage)
                recomanditionCell.sectorImgCell.contentMode = .scaleAspectFill
                ss(ss: recomanditionCell)
                return recomanditionCell }
            
        case 2 :
            
            if  let logosCell = collectionView.dequeueReusableCell(withReuseIdentifier: "successCell", for: indexPath) as? successCell{
                let successMembersImage = homeDataSectorsModel?.data?.logos?[indexPath.item].image ?? "dev test"
                logosCell.configureCell(image: successMembersImage)
                logosCell.sucessMembers.contentMode = .scaleAspectFill
                
                logosCell.layer.cornerRadius = 10
                ss(ss: logosCell)
                return logosCell }
            
        case 3 :
            
            if let stockCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell {
                stockCell.SecrorsName.text = homeDataSectorsModel?.data?.stock?[indexPath.row].name ?? "dev test"
                stockCell.SecrorsName.font = UIFont(name: "Cairo", size: 12.0)
                let successMembersImage = homeDataSectorsModel?.data?.stock?[indexPath.item].image ?? ""
                stockCell.configureCell(image: successMembersImage)
                ss(ss: stockCell)
                return stockCell }
            
        case 4 :
            
            if let guideCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell{
                guideCell.SecrorsName.text = homeDataSectorsModel?.data?.guide?[indexPath.row].name ?? "dev test"
                guideCell.SecrorsName.font = UIFont(name: "Cairo", size: 12.0)
                let successMembersImage = homeDataSectorsModel?.data?.guide?[indexPath.item].image ?? ""
                guideCell.sectorImgCell.contentMode = .scaleAspectFill
                guideCell.configureCell(image: successMembersImage)
                ss(ss: guideCell)
                return guideCell }
            
        case 5 :
            if let storeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell{
                storeCell.SecrorsName.text = homeDataSectorsModel?.data?.store?[indexPath.row].name ?? "dev test"
                storeCell.SecrorsName.font = UIFont(name: "Cairo", size: 14.0)
                let successMembersImage = homeDataSectorsModel?.data?.store?[indexPath.item].image ?? ""
                storeCell.sectorImgCell.contentMode = .scaleAspectFill
                storeCell.configureCell(image: successMembersImage)
                ss(ss: storeCell)
                return storeCell }
            
            
        case 6 :
            
            if let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell{
                newsCell.SecrorsName.text = homeDataSectorsModel?.data?.news?[indexPath.row].name ?? "dev test"
                newsCell.SecrorsName.font = UIFont(name: "Cairo", size: 10.0)
                let successMembersImage = homeDataSectorsModel?.data?.news?[indexPath.item].image ?? ""
                newsCell.sectorImgCell.contentMode = .scaleToFill
                
                newsCell.configureCell(image: successMembersImage)
                ss(ss: newsCell)
                return newsCell }
            print("esvvvs")
            
            
        default:
            
            print("Hello world")
        }
        
        return UICollectionViewCell()
    }
    
    
    //MARK:- didSelecte to Show the screen related
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        var url : NSURL?
        
        
        switch indexPath.section {
        
        case 0 :
            switch indexPath.item {
            
            case 0:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "SectorDetailsTable"))! as SectorDetailsTable
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectorFtomHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
                SectorTables.titleeeee = sectorTitle
            case 1:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "SectorDetailsTable"))! as SectorDetailsTable
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectorFtomHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
                SectorTables.titleeeee = sectorTitle
            case 2:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "SectorDetailsTable"))! as SectorDetailsTable
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectorFtomHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
                SectorTables.titleeeee = sectorTitle
            case 3:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "SectorDetailsTable"))! as SectorDetailsTable
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectorFtomHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
                SectorTables.titleeeee = sectorTitle
            case 4:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "SectorDetailsTable"))! as SectorDetailsTable
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectorFtomHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
                SectorTables.titleeeee = sectorTitle
            case 5:
                let SectorTables = (storyboard?.instantiateViewController(identifier: "CompanyGuideVC"))! as CompanyGuideVC
                navigationController?.pushViewController(SectorTables, animated: true)
                let sectorTypeFrom = homeDataSectorsModel?.data?.sectors?[indexPath.row].type ?? ""
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYYYPE")
                
                UserDefaults.standard.set(sectorTypeFrom, forKey: "TYPE_FOR_FILTER")
                
                
                SectorTables.sectoreTypeFromHome = sectorTypeFrom
                let sectorTitle = homeDataSectorsModel?.data?.sectors?[indexPath.row].name ?? "dev test"
//                SectorTables.titleeeee = sectorTitle
                
            
            default:
                print("hello ")
            }
            
         
            
        case 1 :
            
            switch homeDataSectorsModel?.data?.recomandtion?[indexPath.item].type {
            case "news":
                
                let newsvc = (storyboard?.instantiateViewController(identifier: "NewsDetailsVC"))! as NewsDetailsVC
                newsvc.news_id = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].id ?? 0
                newsvc.title = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].name ?? ""

                newsvc.FatchDataOfNewsDetailsFromHomeRecomindition()
                navigationController?.pushViewController(newsvc, animated: true)
                
            case "showes":
                
                let vc = (storyboard?.instantiateViewController(identifier: "CompanyGuideVC"))! as CompanyGuideVC
                UserDefaults.standard.set( homeDataSectorsModel?.data?.recomandtion?[indexPath.item].id, forKey: "Home_Rec_Id")
                vc.title = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].name ?? ""
                navigationController?.pushViewController(vc, animated: true)
                
            case "store":
                
                let vc = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
                let id_home = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].id ?? 0
                vc.title = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].name ?? ""

                vc.id_froooom_home = id_home
                vc.fetchAdsDetailsHome()
                navigationController?.pushViewController(vc, animated: true)
                
            case "magazines":
                print("hello")
                
            case "guide":
                
                let guideVC = (storyboard?.instantiateViewController(identifier: "CompaniesVC"))! as CompaniesVC
                
                let id = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].id ?? 0
                guideVC.companyTitle = homeDataSectorsModel?.data?.recomandtion?[indexPath.item].name ?? ""

                guideVC.subID_fromGuideHome = id
                guideVC.FatchDatafromHome()
                guideVC.LogosandBanners()
                
                navigationController?.pushViewController(guideVC, animated: true)
                
            case "fodder":
                
                
                print("hello")
                
                
            case "local":
                
                
                print("hello")
                
                
            case "localstock":
                print("hello")
                
                
            default:
                print("hello")
                
            }
            
            
            
            
            
            
            
            
            
        case 2 :
            if let url = NSURL(string: "\(homeDataSectorsModel?.data?.logos?[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
        case 3 :
            let stokevc = (storyboard?.instantiateViewController(identifier: "BorsaDetails"))! as BorsaDetails
            let id_stoke = homeDataSectorsModel?.data?.stock?[indexPath.item].id ?? 0
            UserDefaults.standard.set(id_stoke, forKey: "REC_Id_Stoke")
            let type_stoke = homeDataSectorsModel?.data?.stock?[indexPath.item].type ?? ""
            UserDefaults.standard.set(type_stoke, forKey: "REC_type_Stoke")
            stokevc.title = homeDataSectorsModel?.data?.stock?[indexPath.item].name ?? ""
            stokevc.FatchLocalBorsaFromHomeSelection()
            navigationController?.pushViewController(stokevc, animated: true)
            
            
            
        case 4 :
            let guideVC = (storyboard?.instantiateViewController(identifier: "CompaniesVC"))! as CompaniesVC
            let id = homeDataSectorsModel?.data?.guide?[indexPath.item].id ?? 0
            guideVC.companyTitle = homeDataSectorsModel?.data?.guide?[indexPath.item].name ?? ""
            UserDefaults.standard.set(id, forKey: "REC_Id_Dalil")
            guideVC.FatchDatafromHomeUsingDalil()
            navigationController?.pushViewController(guideVC, animated: true)
            
            
            
            
        case 5 :
            
            let StoreDtails = (storyboard?.instantiateViewController(identifier: "AdsDetails"))! as AdsDetails
            let id_home = homeDataSectorsModel?.data?.store?[indexPath.item].id ?? 0
            
            StoreDtails.keyFromHome = "keyhome"
            
            StoreDtails.id_froooom_home = id_home
            navigationController?.pushViewController(StoreDtails, animated: true)
            
        case 6 :
            let newsvc = (storyboard?.instantiateViewController(identifier: "NewsDetailsVC"))! as NewsDetailsVC
            newsvc.news_id_from_home = homeDataSectorsModel?.data?.news?[indexPath.item].id ?? 0
            newsvc.keyFromHome = "keyhome"
            
            newsvc.FatchDataOfNewsDetailsFromHome()
            navigationController?.pushViewController(newsvc, animated: true)
            
            
            
        default:
            print("Hello world")
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else{
            return UICollectionReusableView()
        }
        view.btnOulet.setTitle(arr[indexPath.section], for: .normal)
        
        return view
    }
    
    
    
    
    
}
