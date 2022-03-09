//
//  GuideCompanyCell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit
import Kingfisher

class GuideCompanyCell: UICollectionViewCell{
   
    
    var companyGuideModel:GuideCompaniesDataModel?
    var testModel:SubSection?
    
    
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var companiesCount: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var logosCollection: UICollectionView!
    @IBOutlet weak var logoImage: UIImageView!
    var arrayTest = [ #imageLiteral(resourceName: "down"), #imageLiteral(resourceName: "privacy-policy (2)") ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logosCollection.dataSource = self
        logosCollection.delegate = self
        self.logosCollection.register(UINib(nibName: "logosCell", bundle: nil), forCellWithReuseIdentifier: "logosCell")
        FatchlogosOfCompanyAtCell()
    }
    
    

    func FatchlogosOfCompanyAtCell(){
        //Handeling Loading view progress
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let typeParameter = UserDefaults.standard.string(forKey: "SECTOR_TYPE")
            let param = ["type": "animal"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let companyGuideLogosIn = "https://elkenany.com/api/guide/section/?type=&sort=&search="
            APIServiceForQueryParameter.shared.fetchData(url: companyGuideLogosIn, parameters: param, headers: headers, method: .get) { (success:GuideCompaniesDataModel?, filier:GuideCompaniesDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                   
                    guard let success = success else {return}
                    self.companyGuideModel = success
                    DispatchQueue.main.async {
                        self.logosCollection.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func configureCell(image:String) {
        let url = URL(string:image)
        companyImage.kf.indicatorType = .activity
        companyImage.kf.setImage(with: url)
    }
    
    
    

}

extension GuideCompanyCell:UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return companyGuideModel?.data?.subSections?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companyGuideModel?.data?.subSections?[section].logoIn?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"logosCell" , for: indexPath) as! logosCell
//        let imageLogin = companyGuideModel?.data?.subSections?[indexPath.item].logoIn?[indexPath.item].image ?? ""
//        let imagetest = testModel?.logoIn?[indexPath.item].image ?? ""
//        let imageLogin = mm?.image?[indexPath.item]
//        cell.configureImage(image: imageLogin)
//        cell.logooImage.image = arrayTest[indexPath.item]
//        let imageee = testModel?.logoIn?[indexPath.item].image ?? "j"
        if let Loimage = companyGuideModel?.data?.subSections?[indexPath.item].logoIn?[indexPath.item].image{
            cell.configureImage(image: Loimage)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("done")
    }
    
}
