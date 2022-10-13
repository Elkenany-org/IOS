//
//  ShipsDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 10/9/22.
//

import UIKit
import ProgressHUD


class ShipsDetailsVC: UIViewController {
    @IBOutlet weak var statDetailsShipCV: UICollectionView!
    @IBOutlet weak var btnMonshaLabel: UIButton!
    @IBOutlet weak var fromDateTitle: UIButton!
    @IBOutlet weak var toDateTitle: UIButton!
    @IBOutlet weak var proudectType: UILabel!

    
    var MainModelStatDetailss:StatisticsShipsDetialsModel?
    var proudectTypee = "النوع"
    var proudectID = 2
    var countryTITle = "اوكرانيا"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proudectType.text = proudectTypee
        title = proudectTypee
        // Do any additional setup after loading the view.
        showeDataServiceeee()
        statDetailsShipCV.delegate = self
        statDetailsShipCV.dataSource = self
        self.statDetailsShipCV.register(UINib(nibName: "StanderCell", bundle: nil), forCellWithReuseIdentifier: "StanderCell")
    }
    




func showeDataServiceeee(){
    // Handeling Loading view progress
    ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
    ProgressHUD.animationType = .circleStrokeSpin
    ProgressHUD.show()
    DispatchQueue.global(qos: .background).async {
        let parm = ["id" : "\(self.proudectID)" , "country" :" \(self.countryTITle)" ]

        let url = "https://admin.elkenany.com/api/ships/statistics-ships-detials?from=&to=&country=&id="
        

        APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:StatisticsShipsDetialsModel?,  filier:StatisticsShipsDetialsModel?, error) in
            if let error = error{
                //internet error
                ProgressHUD.dismiss()
                print("============ error \(error)")
                
            }
            else if let loginError = filier {
                //Data Wrong From Server
                ProgressHUD.dismiss()

                print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
            }
            else {
                ProgressHUD.dismiss()

                guard let success = success else {return}
                self.MainModelStatDetailss = success
            
                DispatchQueue.main.async {
              
                    self.statDetailsShipCV.reloadData()
                    print("hellllllllo")
                    print(self.MainModelStatDetailss?.data?.countries ?? "")
             
                    
                }
            }
        }
    }
}
    
    
    
    //from
    
    @IBAction func fromPickerDate(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "FromPicker"))! as FromPicker
        vc.DataBackDeleget = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    //tooo
    @IBAction func toPickerDate(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "ToPicker"))! as ToPicker
        vc.DataBackDelegettwo = self
        self.present(vc, animated: true, completion: nil)
    }
    
    //manshaaa
    
    
    @IBAction func toView(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "organizationVC"))! as organizationVC
//        vc.contryDelegete = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    

}








extension ShipsDetailsVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainModelStatDetailss?.data?.companies?.count ?? 0

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StanderCell", for: indexPath) as! StanderCell
        cell.proudectLabel.text = MainModelStatDetailss?.data?.companies?[indexPath.item].name ?? ""
        cell.priceLabel.text = MainModelStatDetailss?.data?.companies?[indexPath.item].data?[indexPath.item].country ?? ""
        
        cell.changeLabel.text = String (MainModelStatDetailss?.data?.companies?[indexPath.item].data?[indexPath.item].load ?? 0)
        
        cell.changeTwo.text = MainModelStatDetailss?.data?.companies?[indexPath.item].data?[indexPath.item].nums ?? ""
         
        return cell
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    
}




extension ShipsDetailsVC:  DataBackProtocol {
    func dataBackFromPicker(dateFrom: String) {
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["from" : "\(dateFrom)"]
            let url = "https://admin.elkenany.com/api/ships/statistics-ships-detials?from=&to=&country=&id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:StatisticsShipsDetialsModel?, filier:StatisticsShipsDetialsModel?, error) in
                if let error = error{
                    //internet error
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()

                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    ProgressHUD.dismiss()

                    guard let success = success else {return}
                    self.MainModelStatDetailss = success
                
                    DispatchQueue.main.async {
                  
                        self.statDetailsShipCV.reloadData()
                        self.fromDateTitle.setTitle(dateFrom, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
    
    
    }
    
    
    
    
extension ShipsDetailsVC: DataBackProtocolTwo  {
    func dataBackTOPicker(dateTo: String) {
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["to" : "\(dateTo)"]
            let url = "https://admin.elkenany.com/api/ships/statistics-ships-detials?from=&to=&country=&id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:StatisticsShipsDetialsModel?, filier:StatisticsShipsDetialsModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    ProgressHUD.dismiss()

                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    ProgressHUD.dismiss()

                    guard let success = success else {return}
                    self.MainModelStatDetailss = success
                
                    DispatchQueue.main.async {
                  
                        self.statDetailsShipCV.reloadData()
                        self.toDateTitle.setTitle(dateTo, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
    
    
}
