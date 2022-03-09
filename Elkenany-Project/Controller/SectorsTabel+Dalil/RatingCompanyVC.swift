//
//  RatingCompanyVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/13/21.
//

import UIKit
import Cosmos
import JGProgressHUD

//call back using the rating value of company
protocol ReatingValue {
    func reatingVal(value:Int)
}


class RatingCompanyVC: UIViewController {
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var RatingView: CosmosView!

    var ratingModel:RatingModel?
    var CompanyID = 0
    var rat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        handelTap()
        // Do any additional setup after loading the view.
        handeltheRatingValue()
        RatingView.settings.fillMode = .precise
      
    }
    
    //handel Delegete of Rating
    var ReatingDelegete:ReatingValue?
    
    func handeltheRatingValue(){
        RatingView.didTouchCosmos = { [self]ratingg in
            rat = Int(ratingg)
            print("Rating:\(rat)")
            ReatingDelegete?.reatingVal(value: rat)
        }
    }
    

    
    
    
    //MARK:- Handling Tabs of button clicks
    
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    

    //backBTN ----------------------
    @IBAction func backBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Doing Rating ------------------
    @IBAction func ConfirmRating(_ sender: Any) {
        FatchDatafromHome()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK:- Handling Tabs of button clicks
    func FatchDatafromHome(){
      //Handeling Loading view progress
      let hud = JGProgressHUD(style: .dark)
      hud.textLabel.text = "جاري التحميل"
      hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let companyGuide = "https://elkenany.com/api/guide/rating-company"
            let param = ["company_id": "\(self.CompanyID)", "reat": "\(self.rat)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .post) { (success:RatingModel?, filier:RatingModel?, error) in
                if let error = error{
                  hud.dismiss()
                    print("============ error \(error)")
                }else {
                  hud.dismiss()
                        print("Rating Done")
                }
            }
        }
    }
    
}

