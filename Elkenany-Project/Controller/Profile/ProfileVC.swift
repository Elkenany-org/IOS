//
//  ProfileVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/26/21.
//

import UIKit

class ProfileVC: UIViewController {
    
    var profileDataa:ProfileData?
    @IBOutlet weak var profileCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        self.profileCollectionView.register(UINib(nibName: "profileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        self.profileCollectionView.register(UINib(nibName: "EditeProfileCell", bundle: nil), forCellWithReuseIdentifier: "EditeProfileCell")
        FatchDataProfile()
        
        var isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        if isloggineIn {
            if let vc = storyboard?.instantiateViewController(identifier: "popupToSignIN") as? popupToSignIN {
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            print("helllllo ")

            
           }
        
        
    }
    
  
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    
    
    func FatchDataProfile(){
        //Handeling Loading view progress
        //        let hud = JGProgressHUD(style: .dark)
        //        hud.textLabel.text = "جاري التحميل"
        //        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let profileURL = "https://elkenany.com/api/profile"
            //            let typeParameter = UserDefaults.standard.string(forKey: "Selected_Sec_Com")
            //            let param = ["type": "\(typeParameter ?? "")"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: profileURL, parameters: nil, headers: headers, method: .get) { (success:ProfileData?, filier:ProfileData?, error) in
                if let error = error{
                    //                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    //                    hud.dismiss()
                    guard let success = success else {return}
                    self.profileDataa = success
                    DispatchQueue.main.async {
                        self.profileCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
}


extension ProfileVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 2
            
        }else{
            return 2
            
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! profileCell
            cell.ProfileName.text = profileDataa?.data?.name ?? ""
            
            print("--------------\(profileDataa?.data?.name ?? "")")
            cell.acountType.text = profileDataa?.data?.state ?? ""
            let Profileimage = profileDataa?.data?.image ?? ""
            cell.configureCell(image: Profileimage)
            ss(ss: cell)
            return cell
            
        }else if indexPath.section == 1{
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "EditeProfileCell", for: indexPath) as! EditeProfileCell
            if indexPath.item == 0 {
                
                cell2.profileEdaiteLabel.text = "البيانات الاساسية"
                cell2.profileEditeImage.image = #imageLiteral(resourceName: "user (2)")
            }else{
                cell2.profileEdaiteLabel.text = "الخصوصية"
                cell2.profileEditeImage.image = #imageLiteral(resourceName: "privacy-policy (2)")
            }
            
            
            //cell2.profileEditeImage.image = #imageLiteral(resourceName: <#T##String#>)
            ss(ss: cell2)
            return cell2
        }
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            
            
            
        }else if indexPath.section == 1{
            
            if indexPath.item == 0{
                
                let vc = storyboard?.instantiateViewController(identifier: "MainInfoProfil") as! MainInfoProfil
                present(vc, animated: true, completion: nil)
            }else if indexPath.item == 1{
                
                let vc = storyboard?.instantiateViewController(identifier: "PrivicyProfile") as! PrivicyProfile
                present(vc, animated: true, completion: nil)
                
            }else{
                print("")
            }
            
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: collectionView.frame.width, height: 150)
        }else if indexPath.section == 1{
            return CGSize(width: collectionView.frame.width, height: 85)
        }
        return CGSize(width: collectionView.frame.width, height: 150)
        
    }
    
    
}
























