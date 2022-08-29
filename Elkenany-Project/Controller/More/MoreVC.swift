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
    
    @IBOutlet weak var looogOutIn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var MoreCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    var codata:[MoreDataa] = MoreDataa.moredata
    var logoutmm:LogoutModel?
    var profileDataa:ProfileData?

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        FatchDataProfile()
        title = "القائمة"
        
        /// reverse the functions bc this a check only ----
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn == true{
         print("rtyuio")
                
            
        }else{
            looogOutIn.isHidden = true
            loginBtn.isHidden = false
        }
    
        
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
                        if let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        }
    }
    
    //featch data of profile
    
    func FatchDataProfile(){
        // Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let profileURL = "https://elkenany.com/api/profile"
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: profileURL, parameters: nil, headers: headers, method: .get) { (success:ProfileData?, filier:ProfileData?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.profileDataa = success
                    DispatchQueue.main.async {
                        print("hellllo sucess")
                        self.userName.text = success.data?.name ?? " لا يوجد اسم مستخدم"
                        self.userEmail.text = success.data?.email ?? "لا يوجد اسم مستخدم"

                        let url = URL(string:success.data?.image ?? "")
                        self.userImage.kf.indicatorType = .activity
                        self.userImage.kf.setImage(with: url)
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func logOutBTN(_ sender: Any) {
        logoutService()
    }
    
    
    
    @IBAction func toLogin(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC{
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }

        
    }
    
    
    
}


extension MoreVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
        return CGSize(width:collectionView.frame.width , height: 37)
        
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
            vc.featchBorsaSubSectionsFromMore()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "CompanyGuideVC") as! CompanyGuideVC
            vc.FatchGuidMainDataaaaaaaaa()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "MainStoreVC") as! MainStoreVC
//            vc.FatchDataOfStoreFromMore()
//            vc.FeatchDataOfectores()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "NewsVC") as! NewsVC
            vc.FatchDataforNewsHomeFromMore()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "showesVC") as! showesVC
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = storyboard?.instantiateViewController(identifier: "MagazineHomeVC") as! MagazineHomeVC
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = storyboard?.instantiateViewController(identifier: "shipsVC") as! shipsVC
            navigationController?.pushViewController(vc, animated: true)
            
        case 7:
            let vc = storyboard?.instantiateViewController(identifier: "AboutVC") as! AboutVC
            navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = storyboard?.instantiateViewController(identifier: "abouUsVC") as! abouUsVC
            navigationController?.pushViewController(vc, animated: true)
        case 9:
            if let url = NSURL(string: "https://apps.apple.com/us/app/%D8%A7%D9%84%D9%83%D9%86%D8%A7%D9%86%D9%8A/id1608815820") {
                UIApplication.shared.openURL(url as URL)
            }
            
        case 10:
            // Setting description
            let firstActivityItem = "    يمكنك الاستمتاع بتجربة فريدة مع ابلكيشن الكناني رقم واحد في المجال البيطري والزراعي في الشرق الاوسط"
            
            // Setting url
            let secondActivityItem : NSURL = NSURL(string: "https://apps.apple.com/eg/app/%D8%A7%D9%84%D9%83%D9%86%D8%A7%D9%86%D9%8A/id1608815820")!
            
            // If you want to use an image
            let image : UIImage = UIImage(named: "AppIcon")!
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
            
            // This lines is for the popover you need to show in iPad
            //                activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
            
            // This line remove the arrow of the popover to show in iPad
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            
            // Pre-configuring activity items
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
                
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
            
        case 11:
            //            let vc = storyboard?.instantiateViewController(identifier: "AboutVC") as! AboutVC
            //            navigationController?.pushViewController(vc, animated: true)
            print("about elkenany")
            
        case 12:
            //            let vc = storyboard?.instantiateViewController(identifier: "abouUsVC") as! abouUsVC
            //            navigationController?.pushViewController(vc, animated: true)
            print("jjjjjjjjjjjjj")
            
        default:
            print("hamada")
        }
        
        
    }
    
    
}
