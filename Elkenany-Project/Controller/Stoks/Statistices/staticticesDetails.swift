//
//  staticticesDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/10/22.
//

import UIKit

class staticticesDetails: UIViewController {
    @IBOutlet weak var DetailsCollection: UICollectionView!
    
    @IBOutlet weak var toPicker: UIButton!
    
    @IBOutlet weak var FromPicker: UIButton!
    var DetailsModel:DetailsDetailsMainModel?
    var idFromSelect = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        featchBorsaDetails()

        // Do any additional setup after loading the view.
        DetailsCollection.dataSource = self
        DetailsCollection.delegate = self
        self.DetailsCollection.register(UINib(nibName: "DetailsCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCell")
        DetailsCollection.register(UINib(nibName: "DetailsHeader", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "DetailsHeader")
        title = UserDefaults.standard.string(forKey: "Name_Details") ?? ""
        
        
    }
    

    
    //MARK:- FeatchData for Borsa [Company Logos]
    func featchBorsaDetails(){
        DispatchQueue.global(qos: .background).async {
            let companyDetailsurl = "https://elkenany.com/api/localstock/statistics-detials-local-stock?id="
            let idParameter = UserDefaults.standard.string(forKey: "ID_Details")
            let param = ["id": "5"]
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailsurl, parameters: param, headers: nil, method: .get) { (Detailssuccess:DetailsDetailsMainModel?, Detailsfilier:DetailsDetailsMainModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = Detailssuccess else {return}
                    self.DetailsModel = success
                    DispatchQueue.main.async {
                        self.DetailsCollection.reloadData()
                        print(success.data ?? "rtyuiop")
                    }
                }
            }
        }
    }

    

}

extension staticticesDetails:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    // number of sections --------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    //number of row in section ------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailsModel?.data?.members?.count ?? 0
    }
    
    
    
    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell1.nameLabel.text = DetailsModel?.data?.members?[indexPath.item].name ?? "name"
        cell1.countlabel.text = String(DetailsModel?.data?.members?[indexPath.item].counts ?? 0)
        cell1.dayesChange.text = DetailsModel?.data?.members?[indexPath.item].days ?? "day"
        cell1.weekChange.text = DetailsModel?.data?.members?[indexPath.item].week ?? "week"
        cell1.monthlyChange.text = DetailsModel?.data?.members?[indexPath.item].oldprice ?? "years"
        return cell1
    }
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    
    // header height --------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:100 , height: 55)
    }
    
    
    //header ------------------------------
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerrrr2 = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "DetailsHeader", for: indexPath) as! DetailsHeader
        return headerrrr2
}
    
    
}
