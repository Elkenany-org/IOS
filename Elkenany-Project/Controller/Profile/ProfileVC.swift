//
//  ProfileVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit
import JGProgressHUD
import Kingfisher

class ProfileVC: UIViewController {
    
    @IBOutlet weak var validationView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    var profileDataa:ProfileData?
    
    
    
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
    
    
    

    
    
    
}

