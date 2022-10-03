//
//  ServicesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit
import ProgressHUD

class ServiceViewController: UIViewController {
    
    var homeServiceDataModel:HomeTestModelss?
    //    var hoooooo: HomeTestModel?
    
    var homeDataSectorsModel:HomeSectorsDataModel?
    var magazineHomeModel:MagazineS?
    
    var homeGuide:GuideCompaniesDataModel?
    var arr = [ "المعارض", "الدلائل والمجلات"]
    var arrayOfData = ["معارض" , "دلائل ومجالات", "حركة السفن"]
    var sectionsData = ["الخدمات", "مقترح لك", "شركاء النجاح", "المعارض", "الدلائل والمجلات"]
    var arrayOfImage:[UIImage] = [#imageLiteral(resourceName: "Group 2803") , #imageLiteral(resourceName: "Group 2805") , #imageLiteral(resourceName: "Group 2804") ]
    @IBOutlet weak var ServicesCV: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetHomeDataFromServer()
        
    }
    

    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        ServicesCV.dataSource = self
        ServicesCV.delegate = self
        ServicesCV.collectionViewLayout = creatCompositionalLayout()
        self.ServicesCV.register(UINib(nibName: "SectorsCell", bundle: nil), forCellWithReuseIdentifier: "SectorsCell")
        self.ServicesCV.register(UINib(nibName: "successCell", bundle: nil), forCellWithReuseIdentifier: "successCell")
        self.ServicesCV.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")

        ServicesCV.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderCell")
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
            let headers = ["Authorization": "\(api_token ?? "")" ]
            let Servicesurl = "https://elkenany.com/api/home-services"
            
            APIServiceForQueryParameter.shared.fetchData(url: Servicesurl,
                                                         parameters: nil,
                                                         headers: headers,
                                                         method: .get) {
                (SuccessfulRequest:HomeTestModelss?,
                 FailureRequest:HomeTestModelss?,
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
                    self.homeServiceDataModel = success
                    DispatchQueue.main.async {
                        self.ServicesCV.reloadData()
                    }
                }
            }
        }
        
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
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    
    
    
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return  arrayOfData.count
            
        case 1:
            return homeServiceDataModel?.data?.recomandtion?.count ?? 3
            
        case 2:
            return homeServiceDataModel?.data?.logos?.count  ?? 3
            
            
        case 3:
            return homeServiceDataModel?.data?.show?.count  ?? 3
            
            
        default:
            return homeServiceDataModel?.data?.magazine?.count  ?? 3
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        
        case 0 :
            if let sectoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "logosCell", for: indexPath) as? logosCell{
                sectoreCell.logooImage.image = arrayOfImage[indexPath.item]
                sectoreCell.logooImage.contentMode = .scaleToFill
                Sectore(ss: sectoreCell)
                return sectoreCell }
            
            
        case 1 :
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            cell2.SecrorsName.text = homeServiceDataModel?.data?.recomandtion?[indexPath.item].name ?? ""
            let imageo = homeServiceDataModel?.data?.recomandtion?[indexPath.item].image ?? ""
            cell2.configureCell(image: imageo)
            cell2.SecrorsName.font = UIFont(name: "Cairo", size: 13.0)
            cell2.sectorImgCell.contentMode = .scaleAspectFit
            Sectore(ss: cell2)
            return cell2
            
        case 2 :
            if  let logosCell = collectionView.dequeueReusableCell(withReuseIdentifier: "successCell", for: indexPath) as? successCell{
                let successMembersImage = homeServiceDataModel?.data?.logos?[indexPath.item].image ?? "dev test"
                logosCell.configureCell(image: successMembersImage)
                logosCell.layer.cornerRadius = 10
                ss(ss: logosCell)
                return logosCell }
            
        case 3 :
            
            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            cell4.SecrorsName.text = homeServiceDataModel?.data?.show?[indexPath.item].name ?? ""
            let imageo = homeServiceDataModel?.data?.show?[indexPath.item].image ?? ""
            cell4.configureCell(image: imageo)
            cell4.SecrorsName.font = UIFont(name: "Cairo", size: 13.0)
            cell4.sectorImgCell.contentMode = .scaleAspectFit
            Sectore(ss: cell4)
            return cell4
            
        case 4 :
            let cell5 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            cell5.SecrorsName.text = homeServiceDataModel?.data?.magazine?[indexPath.item].name ?? ""
            let imageo = homeServiceDataModel?.data?.magazine?[indexPath.item].image ?? ""
            cell5.configureCell(image: imageo)
            cell5.SecrorsName.font = UIFont(name: "Cairo", size: 13.0)
            cell5.sectorImgCell.contentMode = .scaleAspectFit
            Sectore(ss: cell5)
            return cell5
            
            
            
        default:
            print("Hello world")
        }
        return UICollectionViewCell()
    }
    
        
    //MARK:- didSelecte to Show the screen related
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch indexPath.section {
        // collection 1
        case 0 :
            switch indexPath.item {
            case 0:
                
                let Showesvc = storyboard?.instantiateViewController(withIdentifier: "showesVC") as! showesVC
                Showesvc.typeFromhome = "poultry"
                navigationController?.pushViewController(Showesvc, animated: true)
                
            case 1:
                let MagazineVC = storyboard?.instantiateViewController(withIdentifier: "MagazineHomeVC") as! MagazineHomeVC
                navigationController?.pushViewController(MagazineVC, animated: true)
                
            case 2:
                let ShipsVC = storyboard?.instantiateViewController(withIdentifier: "shipsVC") as! shipsVC
                navigationController?.pushViewController(ShipsVC, animated: true)
                
            default:
                print("Hello world")
                
            }
            
            
        //collection recommmendition
        case 1 :
            switch homeServiceDataModel?.data?.recomandtion?[indexPath.item].type ?? ""  {
            case "show":
                
                let Showesvc = storyboard?.instantiateViewController(withIdentifier: "showDetailsVC") as! showDetailsVC
                let idShowHome = homeServiceDataModel?.data?.recomandtion?[indexPath.item].id ?? 0
                Showesvc.presentKeyHome = "hommmmeREC"
                UserDefaults.standard.set(idShowHome, forKey: "IDDHOMEREC")
                navigationController?.pushViewController(Showesvc, animated: true)
                
            case "magazines":
                let MagazineVC = storyboard?.instantiateViewController(withIdentifier: "MagazinVC") as! MagazinVC
                let idFromHomeMagazine = homeServiceDataModel?.data?.recomandtion?[indexPath.item].id ?? 0
                UserDefaults.standard.set(idFromHomeMagazine, forKey: "testt")
                MagazineVC.presentKK = "hommme"
                MagazineVC.FeatchCMagazineFromHome()
                navigationController?.pushViewController(MagazineVC, animated: true)
                
            default:
                print("rr tt tt")
            }
            
            
            
        case 2 :
            if let url = NSURL(string: "\(homeServiceDataModel?.data?.logos?[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
            
            
        case 3 :
            let Showesvc = storyboard?.instantiateViewController(withIdentifier: "showDetailsVC") as! showDetailsVC
            let idShowHome = homeServiceDataModel?.data?.show?[indexPath.item].id ?? 0
            Showesvc.presentKeyHome = "hoome"
            UserDefaults.standard.set(idShowHome, forKey: "IDDHOME")
            navigationController?.pushViewController(Showesvc, animated: true)
            
            
        case 4 :
            
            let Showesvc = storyboard?.instantiateViewController(withIdentifier: "MagazinVC") as! MagazinVC
            let magazineID = homeServiceDataModel?.data?.magazine?[indexPath.item].id ?? 0
            UserDefaults.standard.set(magazineID, forKey: "testt")
            Showesvc.magazineIdFromHome = magazineID
            Showesvc.presentKK = "hommme"
            Showesvc.FeatchCMagazineFromHome()
            navigationController?.pushViewController(Showesvc, animated: true)
            
            
        default:
            print("Hello world")
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else{
            return UICollectionReusableView()
        }
        view.title = sectionsData[indexPath.section]
        return view
    }
    
    
    
}
