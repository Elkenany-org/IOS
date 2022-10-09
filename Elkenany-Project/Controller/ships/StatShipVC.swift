//
//  StatShipVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/9/22.
//

import UIKit
import ProgressHUD

class StatShipVC: UIViewController {
    
    @IBOutlet weak var statShipCV: UICollectionView!
    @IBOutlet weak var btnTitle: UIButton!
    
    @IBOutlet weak var btnMonshaLabel: UIButton!
    @IBOutlet weak var fromDateTitle: UIButton!
    @IBOutlet weak var toDateTitle: UIButton!
    var MainModelStat:ShipsStatModel?
    let date = Date()
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "الاحصائيات"
        showeDataServiceeee()
        statShipCV.delegate = self
        statShipCV.dataSource = self
        self.statShipCV.register(UINib(nibName: "StatisticesCell", bundle: nil), forCellWithReuseIdentifier: "StatisticesCell")
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        fromDateTitle.setTitle(result, for: .normal)
        toDateTitle.setTitle(result, for: .normal)
    }
    
    
    
    func showeDataServiceeee(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        let parm = ["id" : "5"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/ships/statistics-ships"
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: nil, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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
                    self.MainModelStat = success
                
                    DispatchQueue.main.async {
                  
                        self.statShipCV.reloadData()
                        print("hellllllllo")
                 
                        
                    }
                }
            }
        }
    }
    
    
    //manshaaa
    
    
    @IBAction func toView(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "organizationVC"))! as organizationVC
        vc.contryDelegete = self
        self.present(vc, animated: true, completion: nil)
    }
    
    //typeeeee
    
    @IBAction func toType(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "clockVC"))! as clockVC
        vc.MonshaDelegete = self
        self.present(vc, animated: true, completion: nil)
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
    
    
}



extension StatShipVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainModelStat?.data?.ships?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticesCell", for: indexPath) as!  StatisticesCell
        cell.typeTitle.text = MainModelStat?.data?.ships?[indexPath.item].product ?? ""
        cell.chanageTitle.text = String (MainModelStat?.data?.ships?[indexPath.item].load ?? 0)
        cell.pricetitle.text = MainModelStat?.data?.ships?[indexPath.item].country ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = (storyboard?.instantiateViewController(identifier: "ShipsDetailsVC"))! as ShipsDetailsVC
        vc.proudectTypee = MainModelStat?.data?.ships?[indexPath.item].product ?? ""
        vc.proudectID = MainModelStat?.data?.ships?[indexPath.item].id ?? 0
        vc.countryTITle = MainModelStat?.data?.ships?[indexPath.item].country ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
}



extension StatShipVC: countryReturn{
    func returnCountry(country: String) {
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["country" : "\(country)"]
            let url = "https://elkenany.com/api/ships/statistics-ships?country="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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
                    self.MainModelStat = success
                
                    DispatchQueue.main.async {
                  
                        self.statShipCV.reloadData()
                        self.btnTitle.setTitle(country, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
}

extension StatShipVC: MonshaReturn{
    func returnMonsha(Monsha: String , monshaNamee: String) {
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["type" : "\(Monsha)"]
            let url = "https://elkenany.com/api/ships/statistics-ships?type="
            
            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    ProgressHUD.dismiss()

                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    ProgressHUD.dismiss()

                    guard let success = success else {return}
                    self.MainModelStat = success
                
                    DispatchQueue.main.async {
                  
                        self.statShipCV.reloadData()
                        self.btnMonshaLabel.setTitle(monshaNamee, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
    

}


extension StatShipVC:  DataBackProtocol {
    func dataBackFromPicker(dateFrom: String) {
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["from" : "\(dateFrom)"]
            let url = "https://elkenany.com/api/ships/statistics-ships?from="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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
                    self.MainModelStat = success
                
                    DispatchQueue.main.async {
                  
                        self.statShipCV.reloadData()
                        self.fromDateTitle.setTitle(dateFrom, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
    
    
    }
    
    
    
    
extension StatShipVC: DataBackProtocolTwo  {
    func dataBackTOPicker(dateTo: String) {
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        DispatchQueue.global(qos: .background).async {
            
            let parm = ["to" : "\(dateTo)"]
            let url = "https://elkenany.com/api/ships/statistics-ships?to="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
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
                    self.MainModelStat = success
                
                    DispatchQueue.main.async {
                  
                        self.statShipCV.reloadData()
                        self.toDateTitle.setTitle(dateTo, for: .normal)
                        print("hellllllllo")
                        

                    }
                }
            }
        }
    }
    
    
}
