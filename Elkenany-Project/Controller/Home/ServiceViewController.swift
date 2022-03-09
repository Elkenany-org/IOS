//
//  ServicesVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/4/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class ServiceViewController: UIViewController {

    var homeServiceDataModel:HomeServiceDataModel?

    var arr = ["الخدمات","مقترح لك","شركاء النجاح", "المعارض", "الدلائل والمجلات"]
    
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
        print("will apeaar")
    }

    
    func setupUI() {
        ServicesCV.dataSource = self
        ServicesCV.delegate = self
        self.ServicesCV.register(UINib(nibName: "SectorsCell", bundle: nil), forCellWithReuseIdentifier: "SectorsCell")
        self.ServicesCV.register(UINib(nibName: "successCell", bundle: nil), forCellWithReuseIdentifier: "successCell")
        ServicesCV.register(UINib(nibName: "HeaderCell", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderCell")
        ServicesCV.collectionViewLayout = creatCompositionalLayout()
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
            return creatFirstSectionn()
        case 1:
            return creatSecondSectionn()
        case 2:
            return creatthirdSectionn()
        default:
            return creatSecondSectionn()
        }
        
    }
    
    
    
    func creatFirstSectionn() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
  
    
    
    func creatSecondSectionn() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    
    func creatthirdSectionn() -> NSCollectionLayoutSection{
        let inset:CGFloat = 7
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //headers
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }


    //MARK:- featch Data from server
//    func featchServesData(){
//        DispatchQueue.global(qos: .background).async {
//            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let companyGuide = "https://elkenany.com/api/home-services"
////            let typeParameter = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
////            let param = ["type": "\(typeParameter ?? "")"]
//            let headers = ["app-id": "\(api_token ?? "")" ]
//            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: nil, headers: headers, method: .get) { (success:HomeServiceDataModel?, filier:HomeServiceDataModel?, error) in
//                if let error = error{
//                    print("============ error \(error)")
//                }else {
//                    guard let success = success else {return}
//                    self.homeServiceDataModel = success
//                    DispatchQueue.main.async {
//                        self.ServicesCV.reloadData()
//                    }
//
//
//                }
//            }
//
//
//        }
//
//}
    
//    func featchDataaaa(){
////                let hud = JGProgressHUD(style: .extraLight)
////                hud.textLabel.text = "Loading..."
////                hud.show(in: self.view)
////
//        let api_toke = String(UserDefaults.standard.string(forKey: "API_TOKEN") ?? "")
//
//        let headers:HTTPHeaders = ["api_token": "Bearer \(api_toke)"]
//        APIService.shared.fetchData(url: "https://elkenany.com/api/home-services" , parameters: nil, headers: headers, method: .get) {[weak self] (ServiceData:HomeServiceDataModel?, ServiceError:HomeServiceDataModel?, error) in
//        guard let self = self else {return}
//        if let error = error{
//
//            print("error ===========================")
//            print(error.localizedDescription)
////                    hud.dismiss()
//
//        }else{
//            self.homeServiceDataModel = ServiceData
////                    print(self.homeDataSectorsModel?.data?.sectors)
//            //print(self.homeDataSectorsModel?.data?.sectors)
////                    hud.dismiss()
//            DispatchQueue.main.async { [self] in
//                self.ServicesCV.reloadData()
////                print("======================= \(self.homeServiceDataModel?.ServiceData?.magazine)")
//            }
//        }
//    }
//}
    
    func featchService(){
//                let hud = JGProgressHUD(style: .extraLight)
//                hud.textLabel.text = "Loading..."
//                hud.show(in: self.view)
//
        let api_toke = String(UserDefaults.standard.string(forKey: "API_TOKEN") ?? "")
       let  Serviceurl = "https://elkenany.com/api/home-services"
        let headers:HTTPHeaders = ["Authorization": "Bearer \(api_toke)"]
        APIService.shared.fetchData(url: Serviceurl , parameters: nil, headers: headers, method: .get) {[weak self] (SectorData:HomeServiceDataModel?, postsError:HomeServiceDataModel?, error) in
        guard let self = self else {return}
        if let error = error{
            
            print("error ===========================")
            print(error.localizedDescription)
//                    hud.dismiss()

        }else{
            self.homeServiceDataModel = SectorData
//                    print(self.homeDataSectorsModel?.data?.sectors)
            //print(self.homeDataSectorsModel?.data?.sectors)
//                    hud.dismiss()
            DispatchQueue.main.async {
                self.ServicesCV.reloadData()
            }
        }
    }
}

    
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return homeServiceDataModel?.ServiceData?.recomandtion?.count ?? 0
        }
        else if section == 1 {
            return homeServiceDataModel?.ServiceData?.recomandtion?.count ?? 0
        }else if section == 2{
            return homeServiceDataModel?.ServiceData?.logos?.count ?? 0

        }else if section == 3{
            return homeServiceDataModel?.ServiceData?.show?.count ?? 0

        }else if section == 4{
            return homeServiceDataModel?.ServiceData?.magazine?.count ?? 0

        }
        else{
            
            return homeServiceDataModel?.ServiceData?.magazine?.count ?? 0

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0 :
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            let successServiceRecommndition = homeServiceDataModel?.ServiceData?.recomandtion?[indexPath.item].image ?? "fff"
            cell1.SecrorsName.text = homeServiceDataModel?.ServiceData?.recomandtion?[indexPath.item].name ?? ""
            print(homeServiceDataModel?.ServiceData?.recomandtion?[indexPath.item].name ?? "")
            cell1.configureCell(image: successServiceRecommndition)
            return cell1
            
            
        case 1 :
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
            cell2.layer.cornerRadius = 15.0
            cell2.layer.borderWidth = 0.0
            cell2.layer.shadowColor = UIColor.black.cgColor
            cell2.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell2.layer.shadowRadius = 5.0
            cell2.layer.shadowOpacity = 0.5
            cell2.layer.masksToBounds = false
            
            cell2.SecrorsName.text = homeServiceDataModel?.ServiceData?.recomandtion?[indexPath.row].name ?? ""
            let successRecommendition = homeServiceDataModel?.ServiceData?.recomandtion?[indexPath.item].image ?? ""
            cell2.configureCell(image: successRecommendition)
            return cell2
            
        case 2 :
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "successCell", for: indexPath) as! successCell
//           if let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name {
//            cell.configuerCell(SectorsCon:pp)
//            }
            
//            cell3.SecrorsName.text = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
//            let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
 
//            print(pp)
            
            let successMembersImagee = homeServiceDataModel?.ServiceData?.logos?[indexPath.item].image ?? ""
            cell3.configureCell(image: successMembersImagee)
            return cell3
            
        case 3 :
            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
//           if let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name {
//            cell.configuerCell(SectorsCon:pp)
//            }
            
//            cell3.SecrorsName.text = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
//            let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
 
//            print(pp)
            
            cell4.SecrorsName.text = homeServiceDataModel?.ServiceData?.show?[indexPath.row].name

            let successShowe = homeServiceDataModel?.ServiceData?.show?[indexPath.item].image ?? ""
            cell4.configureCell(image: successShowe)
            return cell4
            
        case 4 :
            let cell5 = collectionView.dequeueReusableCell(withReuseIdentifier: "SectorsCell", for: indexPath) as! SectorsCell
//           if let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name {
//            cell.configuerCell(SectorsCon:pp)
//            }
            
//            cell3.SecrorsName.text = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
//            let pp = homeDataSectorsModel?.data?.sectors?[indexPath.row].name
 
//            print(pp)
            
            cell5.SecrorsName.text = homeServiceDataModel?.ServiceData?.magazine?[indexPath.row].name

            let successMagazine = homeServiceDataModel?.ServiceData?.magazine?[indexPath.item].image ?? ""
            cell5.configureCell(image: successMagazine)
            return cell5
            

            
        default:
            print("Hello world")
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else{
            return UICollectionReusableView()
        }
//        view.title = indexPath.section == 2 ? "الخدامات" : "القطاعات"
        view.title = arr[indexPath.section]
        return view
    }
    
    
    
}
