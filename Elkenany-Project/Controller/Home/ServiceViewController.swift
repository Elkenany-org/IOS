//
//  ServicesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit
import JGProgressHUD

class ServiceViewController: UIViewController {

    var homeServiceDataModel:HomeTestModelss?
//    var hoooooo: HomeTestModel?
    
    var homeDataSectorsModel:HomeSectorsDataModel?
    var magazineHomeModel:MagazineS?

    var homeGuide:GuideCompaniesDataModel?
    var arr = [ "المعارض", "الدلائل والمجلات"]
    var arrayOfData = ["معارض" , "دلائل ومجالات", "حركة السفن"]
    var sectionsData = ["الخدمات", "مقترح لك", "شركاء النجاح", "المعارض", "الدلائل والمجلات"]
    var arrayOfImage:[UIImage] = [#imageLiteral(resourceName: "store") , #imageLiteral(resourceName: "fax-1") , #imageLiteral(resourceName: "news") ]
    @IBOutlet weak var ServicesCV: UICollectionView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("did apeaar")

        //featchServesData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        featchService()
        //        GetHomeDataFromServerServices()
        GetHomeDataFromServer()

        print("will apeaar")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        GetHomeDataFromServer()

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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    //MARK:- featch Data from server
    func GetHomeDataFromServer(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
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
                    hud.dismiss()
                    print("============ error \(error)")
                    
                }
                else if let loginError = FailureRequest {
                    //Data Wrong From Server
                    print(loginError)
                }
                
                else {
                    hud.dismiss()
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
            if let sectoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as? SectorsCell{
                sectoreCell.SecrorsName.text = arrayOfData[indexPath.item]
                sectoreCell.sectorImgCell.image = arrayOfImage[indexPath.item]
                sectoreCell.SecrorsName.font = UIFont(name: "Cairo-Black", size: 16.0)
                sectoreCell.sectorImgCell.contentMode = .scaleAspectFit
                Sectore(ss: sectoreCell)
                return sectoreCell }
            
            
        case 1 :
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            cell2.SecrorsName.text = homeServiceDataModel?.data?.recomandtion?[indexPath.item].name
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
    
    
    //-----------
    
    //MARK:- didSelecte to Show the screen related
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        var url : NSURL?
        
        
        switch indexPath.section {
        
        case 0 :
            switch indexPath.item {
            case 0:
                
                let Showesvc = storyboard?.instantiateViewController(withIdentifier: "showesVC") as! showesVC
                Showesvc.typeFromhome = "poultry"
                navigationController?.pushViewController(Showesvc, animated: true)
            case 1:
                
                let MagazineVC = storyboard?.instantiateViewController(withIdentifier: "MagazineHomeVC") as! MagazineHomeVC
//                Showesvc.typeFromhome = "poultry"
                navigationController?.pushViewController(MagazineVC, animated: true)

                
            case 2:
                let ShipsVC = storyboard?.instantiateViewController(withIdentifier: "shipsVC") as! shipsVC
//                Showesvc.typeFromhome = "poultry"
                navigationController?.pushViewController(ShipsVC, animated: true)

                
            default:
                print("Hello world")

            }
            
            
            
        case 1 :
            print("Hello world")
    
            
        case 2 :
            if let url = NSURL(string: "\(homeServiceDataModel?.data?.logos?[indexPath.item].link ?? "")") {
                UIApplication.shared.openURL(url as URL)
            }
        
        case 3 :
            print("Hello world")

            
            
        case 4 :

            let Showesvc = storyboard?.instantiateViewController(withIdentifier: "MagazinVC") as! MagazinVC
            let magazineID = homeServiceDataModel?.data?.magazine?[indexPath.item].id ?? 0
            Showesvc.magazineIdFromHome = magazineID
            Showesvc.FeatchCMagazineFromHome()
            navigationController?.pushViewController(Showesvc, animated: true)
      
        
        default:
            print("Hello world")
        }
        
    }
    
    
    
    
    
    
    
    //-------------
    
    
    
    
    
    
    
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else{
            return UICollectionReusableView()
        }
//        view.title = indexPath.section == 2 ? "الخدامات" : "القطاعات"
        view.title = sectionsData[indexPath.section]
        return view
    }
    
    
    
}
