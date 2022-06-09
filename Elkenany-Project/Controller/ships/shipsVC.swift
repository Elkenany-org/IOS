//
//  shipsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/6/22.
//

import UIKit


class shipsVC: UIViewController {
    
    
    @IBOutlet weak var statistecsBTN: UIButton!
    @IBOutlet weak var dataPicker: UIButton!
    @IBOutlet weak var shipCV: UICollectionView!
    @IBOutlet weak var membershipV: UIView!
    let date = Date()
    let formatter = DateFormatter()
    var shipSubModel:ShipsModel?
    var shipsSubModelData:[Ship] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetshipsData()
        shipCV.dataSource = self
        shipCV.delegate = self
        self.shipCV.register(UINib(nibName: "shipsCell", bundle: nil), forCellWithReuseIdentifier: "shipsCell")
        formatter.dateFormat = "yyyy-MM-dd"
        let dateDay = formatter.string(from: date)
        dataPicker.setTitle(dateDay, for: .normal)
        title = "حركة السفن"
        
        
    }
    
    
    @IBAction func datePickerClick(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func statisticesClicke(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "StatShipVC"))! as StatShipVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func GetshipsData(){
        formatter.dateFormat = "yyyy-MM-dd"
        let dateOfDay = formatter.string(from: date)
        let param = ["date" : "\(dateOfDay )"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/ships/all-ships?date="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide,  parameters: param, headers: nil, method: .get) { (Datasuccess:ShipsModel?, Datafailure:ShipsModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    
                    let successData = Datasuccess?.data?.ships ?? []
                    self.shipsSubModelData.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
                        self.shipCV.reloadData()
                        print(successData)
                        
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
        //        cell1.changeLabel.text = shipsSubModelData[indexPath.item].name ?? ""
        //        cell1.changeLabel.text = "werty"
        cell1.name.text = shipsSubModelData[indexPath.item].name ?? ""
        cell1.date.text = shipsSubModelData[indexPath.item].date ?? ""
        cell1.container.text = String( shipsSubModelData[indexPath.item].load ?? 0)
        cell1.type.text = shipsSubModelData[indexPath.item].product ?? ""
        cell1.fromM.text = shipsSubModelData[indexPath.item].country ?? ""
        cell1.arrivalDate.text = shipsSubModelData[indexPath.item].dirDate ?? ""
        cell1.distanition.text = shipsSubModelData[indexPath.item].company ?? ""
        cell1.wakel.text = shipsSubModelData[indexPath.item].agent ?? ""
        cell1.minaa.text = shipsSubModelData[indexPath.item].port ?? ""
        return cell1
    }
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
        
    }
    
}

extension shipsVC:BackDate{
    func backDateToMain(date: String) {
        let param = ["date" : "\(date )"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/ships/all-ships?date="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide,  parameters: param, headers: nil, method: .get) { (Datasuccess:ShipsModel?, Datafailure:ShipsModel?, error) in
                if let error = error{
                    print("============ error \(error)")
            
                }    else if let loginErrorr = Datafailure {
                    //Data Wrong From Server
                    
                    print(loginErrorr.message ?? "6666666666666")
                    self.shipCV.isHidden = true
                    self.membershipV.isHidden = false
                    
                }
                
                
                else {
                    self.shipsSubModelData.removeAll()
                    let successData = Datasuccess?.data?.ships ?? []
                    self.shipsSubModelData.append(contentsOf: successData)
                    
                    DispatchQueue.main.async {
                        self.shipCV.isHidden = false
                        self.membershipV.isHidden = true
                        self.shipCV.reloadData()
                        print(successData)
                        
                    }
                    self.dataPicker.setTitle(date, for: .normal)
                }
            }
        }
        
    }
}
