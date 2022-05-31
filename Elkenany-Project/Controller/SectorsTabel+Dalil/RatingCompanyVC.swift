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
    
    //MARK:Outlet and Vars
    @IBOutlet weak var RatingView: CosmosView!
    var ratingModel:RatingModel?
    var magazineRating:MagazineRating?
    var CompanyID = 0
    var magazineID = 0
    var rat = 0
    var ratingKey = ""
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handeltheRatingValue()
        RatingView.settings.fillMode = .precise
    }
    
    
    //MARK: Rating Value handling
    func handeltheRatingValue(){
        RatingView.didTouchCosmos = { [self]ratingg in
            rat = Int(ratingg)
            print("Rating:\(rat)")
            ReatingDelegete?.reatingVal(value: rat)
        }
    }
    
    
    //handel Delegete of Rating
    var ReatingDelegete:ReatingValue?
    
    
    //dismiss view
    @IBAction func dissssmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- Handling Rating button clicks
    @IBAction func ConfirmRating(_ sender: Any) {
        let isloggineIn = UserDefaults.standard.bool(forKey: "LOGIN_STAUTS")
        
        if isloggineIn {
            
            switch ratingKey {
            case "MAGAZINE":
                SendDataOfRatingViewForMagazine()
            case "COMAPNIES":
                SendDataOfRatingView()

            default:
                print("hello world . . . . Rating not completed")
            }
            
            
        }else{
            if let vc = storyboard?.instantiateViewController(identifier: "popupToSignIN") as? popupToSignIN {
                self.present(vc, animated: true, completion: nil)
            }
            
        }
    }
    
    
    //MARK:- Handling The service of rating
    func SendDataOfRatingView(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التقييم"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["company_id": "\(self.CompanyID)", "reat": "\(self.rat)"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyRating, parameters: param, headers: headers, method: .post) { (success:RatingModel?, filier:RatingModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    //MARK:- Handling The service of rating
    func SendDataOfRatingViewForMagazine(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التقييم"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let param = ["maga_id": "\(self.magazineID)", "reat": "\(self.rat)"]
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            let ratingUrl = "https://elkenany.com/api/magazine/rating-magazine"
            APIServiceForQueryParameter.shared.fetchData(url: ratingUrl , parameters: param, headers: headers, method: .post) { (success:MagazineRating?, filier:MagazineRating?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}

