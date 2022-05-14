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
    var arr = [ "المعارض", "الدلائل والمجلات"]
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
//        GetHomeDataFromServerServices()

        print("will apeaar")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    func GetHomeDataFromServerServices(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let headers:HTTPHeaders = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: "https://elkenany.com/api/home-services",
                                                         parameters: nil,
                                                         headers: nil,
                                                         method: .get) {
                (SuccessfulRequest:HomeServiceDataModel?,
                 FailureRequest:HomeServiceDataModel?,
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
                        print(SuccessfulRequest?.ServiceData?.magazine ?? "")
                    }
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
            return 4
        }
        else if section == 1 {
            return homeServiceDataModel?.ServiceData?.recomandtion?.count ?? 3
        }else if section == 2{
            return homeServiceDataModel?.ServiceData?.logos?.count ?? 5

        }else if section == 3{
            return homeServiceDataModel?.ServiceData?.show?.count ?? 6

        }else if section == 4{
            return homeServiceDataModel?.ServiceData?.magazine?.count ?? 7

        }
        else{
            return homeServiceDataModel?.ServiceData?.magazine?.count ?? 5

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
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "showesVC") as! showesVC
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else{
            return UICollectionReusableView()
        }
//        view.title = indexPath.section == 2 ? "الخدامات" : "القطاعات"
//        view.title = arr[indexPath.section]
        return view
    }
    
    
    
}
