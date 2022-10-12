//
//  gallaryTVCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 10/12/22.
//

import UIKit

class gallaryTVCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    var companyDetailsModel:CompanyDetailsDataModel?

    var commID = 0
    @IBOutlet weak var hideStttak: UIStackView!
    @IBOutlet weak var gallaryCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gallaryCell.delegate = self
        gallaryCell.dataSource = self
        gallaryCell.register(UINib(nibName: "sliderCellShow", bundle: nil), forCellWithReuseIdentifier: "sliderCellShow")
        FeatchCompanyInformations()
        
    }
    
    func FeatchCompanyInformations(){
 
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
                        self.gallaryCell.reloadData()
                        
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyDetailsModel?.data?.gallary?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCellShow", for: indexPath) as? sliderCellShow {
            let image = companyDetailsModel?.data?.gallary?[indexPath.item].image ?? ""
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
