//
//  ComparingDone.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/24/22.
//

import UIKit
import JGProgressHUD

class ComparingDone: UIViewController {

    @IBOutlet weak var comparingCV: UICollectionView!
    var DataaCompanyModell:ComperingDoneModel?

    override func viewDidLoad() {
        super.viewDidLoad()
//        GetComparing()
        // Do any additional setup after loading the view.
        
        
            // Do any additional setup after loading the view.
        comparingCV.dataSource = self
        comparingCV.delegate = self
            self.comparingCV.register(UINib(nibName: "CompareingCell", bundle: nil), forCellWithReuseIdentifier: "CompareingCell")
    }
    
    
//
//    func GetComparing(){
//    //Handeling Loading view progress
//    let hud = JGProgressHUD(style: .dark)
//    hud.textLabel.text = "جاري التحميل"
//        hud.show(in: self.view)
//    DispatchQueue.global(qos: .background).async {
//            let companies_id = [132, 133, 135]
//            let fodder_items_id = [236, 238]
//       let idComp =  UserDefaults.standard.string(forKey: "he") ?? ""
//        let SectoreFilterURL = "https://elkenany.com/api/localstock/comprison-fodder-get"
//            let param = ["companies_id[]" : "\(companies_id)" , "fodder_items_id[]" : "\(fodder_items_id)"]
//
////        let param = ["id" : "\(idComp)"]
//        print(param)
//        APIServiceForQueryParameter.shared.fetchData(url: SectoreFilterURL, parameters: param, headers: nil, method: .post) { (success:ComperingDoneModel?, filier:ComperingDoneModel?, error) in
//            if let error = error{
//                hud.dismiss()
//                print("============ error \(error)")
//            }else {
//                hud.dismiss()
//                guard let success = success else {return}
//                self.DataaCompanyModell = success
//                DispatchQueue.main.async {
//                    self.comparingCV.reloadData()
//                    print(success.data ?? "")
//                }
//            }
//        }
//    }
//    }
//
    
    
    
    
    
    
    

    @IBAction func diiiiismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}




extension ComparingDone: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if DataaCompanyModell?.data?.companies?.count == 1 {
//            return 1
//        } else if DataaCompanyModell?.data?.companies?.count == 2 {
//            return 2
//
//        }else{
//            return 3
//
//        }
        return 3
//        return 3
//        return  DataaCompanyModell?.data?.companies?.count ?? 0
        
    }

    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "CompareingCell", for: indexPath) as? CompareingCell{
            cell1.compName.text = DataaCompanyModell?.data?.companies?[indexPath.item].name ?? ""
             return cell1
          }
        return UICollectionViewCell()
        }
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 , height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    
    }
    
    
