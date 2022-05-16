//
//  notificationVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit
import Alamofire
import JGProgressHUD

class notificationVC: UIViewController {

    var notificationdata:NotificationModel?
    @IBOutlet weak var notificationCV: UICollectionView!
    @IBOutlet weak var validationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        FatchDataOfNotif()

//        badgeValue = String(notificationdata?.data?.nots?.count ?? 0)
        
        
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
                        
        }else{
            
        }

        
    }
    


    func setupUI() {
        notificationCV.dataSource = self
        notificationCV.delegate = self
        self.notificationCV.register(UINib(nibName: "NotificationCell", bundle: nil), forCellWithReuseIdentifier: "NotificationCell")
        //Dynamice Hight cell
 
    }
    
    func FatchDataOfNotif(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""
        let headers = ["Authorization": "Bearer \(api_token)" ]
        DispatchQueue.global(qos: .background).async {
            
            let notURL = "https://elkenany.com/api/v2/notifications"
            APIServiceForQueryParameter.shared.fetchData(url: notURL, parameters: nil, headers: headers, method: .get) { (success:NotificationModel?, filier:NotificationModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.notificationdata = success
                    DispatchQueue.main.async {
                        self.notificationCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0, height: 1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.5
        ss.layer.masksToBounds = false

    }
}


extension notificationVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  notificationdata?.data?.result?.count ?? 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.notTitle.text = notificationdata?.data?.result?[indexPath.item].title ?? ""
        cell.notDescription.text = notificationdata?.data?.result?[indexPath.item].desc ?? ""
        let imageeee = notificationdata?.data?.result?[indexPath.item].image ?? ""
        cell.configureCell(image: imageeee)
        //ss(ss: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailsVC = storyboard?.instantiateViewController(identifier: "NotificationDetails") as! NotificationDetails
        let sel_title = notificationdata?.data?.result?[indexPath.item].title ?? ""
        DetailsVC.com_title = sel_title
        let sel_desc = notificationdata?.data?.result?[indexPath.item].desc ?? ""
        DetailsVC.com_desc = sel_desc
        let imageeee = notificationdata?.data?.result?[indexPath.item].image ?? ""
        DetailsVC.com_Image = imageeee

        present(DetailsVC, animated: true, completion: nil)
    }
    
}
