//
//  StatShipVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/9/22.
//

import UIKit

class StatShipVC: UIViewController {
    
    @IBOutlet weak var statShipCV: UICollectionView!
    var MainModelStat:ShipsStatModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        showeDataServiceeee()
        statShipCV.delegate = self
        statShipCV.dataSource = self
        self.statShipCV.register(UINib(nibName: "StatisticesCell", bundle: nil), forCellWithReuseIdentifier: "StatisticesCell")
        
        
        
    }
    
    func showeDataServiceeee(){
        let parm = ["id" : "5"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/ships/statistics-ships"
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: nil, headers: nil, method: .get) { (success:ShipsStatModel?, filier:ShipsStatModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
}


