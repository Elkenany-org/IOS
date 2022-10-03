//
//  ProfileVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit
import ProgressHUD
import Kingfisher

class ProfileVC: UIViewController {
    
    @IBOutlet weak var validationView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    var profileDataa:ProfileData?
    var logoutmm:LogoutModel?

    
    
    
 //viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            FatchDataProfile()
            validationView.isHidden = true
            profileView.isHidden = false
            
        }else{
            profileView.isHidden = true
            validationView.isHidden = false
        }
    }
    
    
    
    
    //from validation
    @IBAction func toLogin(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    //from profile
    @IBAction func pressToLoginFromProfile(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as? LoginVC {
            FatchDataProfileOut()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //edite profile
    @IBAction func pressToEditeProfile(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "PrivicyProfile") as? PrivicyProfile {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }

    }
    
    
    @IBAction func toAdsDetails(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "BlankView") as? BlankView {
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    //featch data of profile
    func FatchDataProfile(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let profileURL = "https://elkenany.com/api/profile"
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: profileURL, parameters: nil, headers: headers, method: .get) { (success:ProfileData?, filier:ProfileData?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.profileDataa = success
                    DispatchQueue.main.async {
                        print("hellllo sucess")
                        self.userNameLabel.text = success.data?.name ?? " لا يوجد اسم مستخدم"
                        self.emailUser.text = success.data?.email ?? "لا يوجد اسم مستخدم"

                        let url = URL(string:success.data?.image ?? "")
                        self.userImage.kf.indicatorType = .activity
                        self.userImage.kf.setImage(with: url)
                    }
                }
            }
        }
    }
    
    
    
    //featch data of profile
    func FatchDataProfileOut(){
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
         
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let profileURL = "https://elkenany.com/api/logout"
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: profileURL, parameters: nil, headers: headers, method: .get) { (success:LogoutModel?, filier:LogoutModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = success else {return}
                    self.logoutmm = success
                    DispatchQueue.main.async {
                        print("out sucess")
                        UserDefaults.standard.removeObject(forKey: "API_TOKEN")
                  
                    }
                }
            }
        }
    }
    
    

    
    
    
}

