//
//  shipsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/6/22.
//

import UIKit
import ProgressHUD

class shipsVC: UIViewController {
    
    //MARK: Vars and Outlet
    @IBOutlet weak var statistecsBTN: UIButton!
    @IBOutlet weak var dataPicker: UIButton!
    @IBOutlet weak var shipCV: UICollectionView!
    @IBOutlet weak var membershipV: UIView!
    @IBOutlet weak var notFoundView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    let date = Date()
    let formatter = DateFormatter()
    var shipSubModel:ShipsModel?
    var shipsSubModelData:[Ship] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetshipsData()
        setupUI()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateDay = formatter.string(from: date)
        dateLabel.text = dateDay
        title = "حركة السفن"
    }
    
    
    fileprivate func setupUI() {
        shipCV.dataSource = self
        shipCV.delegate = self
        self.shipCV.register(UINib(nibName: "shipsCell", bundle: nil), forCellWithReuseIdentifier: "shipsCell")
    }
    
    //picker for date
    @IBAction func datePickerClick(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
    }
    
    //staticstices ship
    @IBAction func statisticesClicke(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "StatShipVC"))! as StatShipVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Get Ships data
    func GetshipsData(){
        formatter.dateFormat = "yyyy-MM-dd"
        let dateOfDay = formatter.string(from: date)
        let param = ["date" : "\(dateOfDay)"]
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let shipsURL = "https://elkenany.com/api/ships/all-ships?date="
            APIServiceForQueryParameter.shared.fetchData(url: shipsURL,  parameters: param, headers: nil, method: .get) { (Datasuccess:ShipsModel?, Datafailure:ShipsModel?, error) in
                
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()

                    let successData = Datasuccess?.data?.ships ?? []
                    self.shipsSubModelData.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
                        if  self.shipsSubModelData.isEmpty == false{
                            self.notFoundView.isHidden = true
                            self.shipCV.isHidden = false
                            self.shipCV.reloadData()

                        }else if self.shipsSubModelData.isEmpty == true{
                            
                            self.notFoundView.isHidden = false
                            self.shipCV.isHidden = true
                            self.shipCV.reloadData()
                            print(successData)
                            
                        }else{
                            print("hellllo erooorr")
                            
                        }
                    }
                }
            }
        }
    }
    
}



//MARK:- For Borsa details
extension shipsVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    // number of sections --------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    //number of row in section ------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipsSubModelData.count
        
    }
    
    
    
    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "shipsCell", for: indexPath) as! shipsCell
        
        cell1.name.text = shipsSubModelData[indexPath.item].name ?? ""
        cell1.date.text = shipsSubModelData[indexPath.item].dirDate ?? ""
        cell1.container.text = String( shipsSubModelData[indexPath.item].load ?? 0)
        cell1.type.text = shipsSubModelData[indexPath.item].product ?? ""
        cell1.fromM.text = shipsSubModelData[indexPath.item].country ?? ""
        cell1.arrivalDate.text = shipsSubModelData[indexPath.item].date ?? ""
        cell1.distanition.text = shipsSubModelData[indexPath.item].company ?? ""
        cell1.wakel.text = shipsSubModelData[indexPath.item].port ?? ""
        cell1.minaa.text = shipsSubModelData[indexPath.item].agent ?? ""
        return cell1
    }
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
        
    }
    
}


//MARK: filter by date 
extension shipsVC:BackDate{
    
    func backDateToMain(date: String) {
        
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        
        let param = ["date" : "\(date )"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let shipsArivalURL = "https://elkenany.com/api/ships/all-ships?date="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: shipsArivalURL,  parameters: param, headers: nil, method: .get) { (Datasuccess:ShipsModel?, Datafailure:ShipsModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()

                    print("============ error \(error)")
                    
                }    else if let loginErrorr = Datafailure {
                    ProgressHUD.dismiss()

                    //Data Wrong From Server
                    print(loginErrorr.message ?? "6666666666666")
                    self.shipCV.isHidden = true
                    self.membershipV.isHidden = false
                    self.notFoundView.isHidden = true
                    self.dateLabel.text = date

                    
                } else {
                    ProgressHUD.dismiss()

                    self.shipsSubModelData.removeAll()
                    let successData = Datasuccess?.data?.ships ?? []
                    self.shipsSubModelData.append(contentsOf: successData)
                    
                    if  self.shipsSubModelData.isEmpty == false{
                        self.shipCV.isHidden = false
                        self.membershipV.isHidden = true
                        self.notFoundView.isHidden = true
                        self.shipCV.reloadData()
//                        self.dataPicker.setTitle(date, for: .normal)
                        self.dateLabel.text = date
                        
                    }else if  self.shipsSubModelData.isEmpty == true{
                        self.shipCV.isHidden = true
                        self.membershipV.isHidden = false
                        self.notFoundView.isHidden = false
                        self.dateLabel.text = date

                    }
                }
            }
        }
        
    }
}


