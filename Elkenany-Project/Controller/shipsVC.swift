//
//  shipsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/6/22.
//

import UIKit


class shipsVC: UIViewController, BackDate {
    func backDateToMain(date: String) {
        print("hello world ----")
    }
    
    
    @IBOutlet weak var statistecsBTN: UIButton!
    @IBOutlet weak var dataPicker: UIButton!
    @IBOutlet weak var shipCV: UICollectionView!
    
    var shipSubModel:ShipsModel?
    
    var shipsSubModelData:[Ship] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        GetshipsData()
        shipCV.dataSource = self
        shipCV.delegate = self
        self.shipCV.register(UINib(nibName: "localBorsaCell", bundle: nil), forCellWithReuseIdentifier: "localBorsaCell")
        
    }
    
    
    @IBAction func datePickerClick(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        vc.dateDelgete = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func statisticesClicke(_ sender: Any) {
    }
    
    
    
    func GetshipsData(){
        let param = ["date": "2022-06-3"]
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/ships/all-ships?date="
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: nil, method: .get) { (Datasuccess:ShipsModel?, Datafailure:ShipsModel?, error) in
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
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "localBorsaCell", for: indexPath) as! localBorsaCell
        cell1.changeLabel.text = shipsSubModelData[indexPath.item].name ?? ""
//        cell1.changeLabel.text = "werty"
        return cell1
    }
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 65)
        
    }
    
}
