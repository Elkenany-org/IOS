//
//  proudectsCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 10/12/22.
//

import UIKit

class proudectsCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    var companyDetailsModel:CompanyDetailsDataModel?
    var comID = 0
    @IBOutlet weak var proudectCV: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        proudectCV.delegate = self
        proudectCV.dataSource = self
        proudectCV.register(UINib(nibName: "sliderCellShow", bundle: nil), forCellWithReuseIdentifier: "sliderCellShow")
        FeatchCompanyInformationsProudect()
        
    }
    
    func FeatchCompanyInformationsProudect(){
 
        DispatchQueue.global(qos: .background).async {
            let userDD = UserDefaults.standard.value(forKey: "IDDD") ?? ""

            let param = ["id": "\(userDD)"]
            let companyDetailes = "https://elkenany.com/api/guide/company/?id="
            APIServiceForQueryParameter.shared.fetchData(url: companyDetailes, parameters: param, headers: nil, method: .get) { (success:CompanyDetailsDataModel?, filier:CompanyDetailsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.companyDetailsModel = success
                    DispatchQueue.main.async {
                        self.proudectCV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyDetailsModel?.data?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCellShow", for: indexPath) as? sliderCellShow {
            let image = companyDetailsModel?.data?.products?[indexPath.item].image ?? ""
            cell3.configureImage(image: image )
            return cell3
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 120)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
}
