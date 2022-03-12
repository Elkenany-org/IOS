//
//  MoreVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class MoreVC: UIViewController {
    
    @IBOutlet weak var MoreCollectionView: UICollectionView!
    var codata:[MoreDataa] = MoreDataa.moredata
    var logoutmm:LogoutModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "القائمة"
    }
    
    
    func setupUI() {
        MoreCollectionView.dataSource = self
        MoreCollectionView.delegate = self
        self.MoreCollectionView.register(UINib(nibName: "MoreCV", bundle: nil), forCellWithReuseIdentifier: "MoreCV")
        MoreCollectionView.register(UINib(nibName: "headerLine", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerLine")
        
        
    }
    
    
    
    func logoutService(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
//            let headers:HTTPHeaders = ["Authorization": "Bearer \(api_token ?? "")" ]
            let headerrrs = ["Authorization": "Bearer \(api_token ?? "")"]
            let logoutURL = "https://elkenany.com/api/logout"
            APIServiceForQueryParameter.shared.fetchData(url: logoutURL, parameters: nil, headers: headerrrs, method: .post) { (logSuccess:LogoutModel?, logFilier:LogoutModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = logSuccess else {return}
                    self.logoutmm = success
                    DispatchQueue.main.async {
                        print("yaaaaaaaaaaa")
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func logOutBTN(_ sender: Any) {
        logoutService()
        
    }
    
    
}


extension MoreVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 11
        case 1:
            return 0
        default:
            return 2
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCV", for: indexPath) as! MoreCV
        let dataaa = codata[indexPath.item]
        cell.featureTitle.text = dataaa.title
        cell.featureImage.image = dataaa.coverImage 
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width , height: 50)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width:collectionView.frame.width , height: 0)
        case 1:
            return CGSize(width:collectionView.frame.width / 3 , height: 2)
        default:
            print("")
        }
        return CGSize(width:collectionView.frame.width , height: 0)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            print("")
        case 1:
            let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
            return headerrrr
        default:
            print("")
        }
        
        
        
        let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
        return headerrrr
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "CompanyGuideVC") as! CompanyGuideVC
            vc.FatchGuidMainDataaaaaaaaa()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "CompanyGuideVC") as! CompanyGuideVC
            navigationController?.pushViewController(vc, animated: true)
            
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "NewsVC") as! NewsVC
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
            navigationController?.pushViewController(vc, animated: true)
            
        case 6:
            print("settings")
        case 7:
            let vc = storyboard?.instantiateViewController(identifier: "AboutVC") as! AboutVC
            navigationController?.pushViewController(vc, animated: true)
            print("about elkenany")
            
        case 8:
            let vc = storyboard?.instantiateViewController(identifier: "abouUsVC") as! abouUsVC
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("hamada")
        }
        
        
    }
    
    
}
