//
//  AdsViewController.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/19/22.
//

import UIKit
import JGProgressHUD
import Photos

class AdsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var adsTitle: UITextField!
    @IBOutlet weak var adsPrice: UITextField!
    @IBOutlet weak var adsAdreess: UITextField!
    @IBOutlet weak var adsPhone: UITextField!
    @IBOutlet weak var adsDescription: UITextField!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt4: UIButton!
    var sec_id = ""
    var images:[String] = []
    var addAdsModel:AddAds?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bt1.setImage(UIImage(named:"Checkmark"), for: .selected)
        bt1.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt2.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt2.setImage(UIImage(named:"Checkmark"), for: .selected)
        bt4.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        bt4.setImage(UIImage(named:"Checkmark"), for: .selected)
        // Do any additional setup after loading the view.
        
        print(images)
    }
    
    
    func addAds() {
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "تم اضافة اعلان للسوق"
        hud.show(in: self.view)
        //Handel Parametars
        let typeParameter = UserDefaults.standard.string(forKey: "ADS_ID") ?? ""

        let parm = [
            "title": adsTitle.text ?? "" , "salary": adsPrice.text ?? "" , "address": adsAdreess.text ?? "" , "phone": adsPhone.text ?? "" ,"desc": adsDescription.text ?? "" , "section_id" : "\(typeParameter)" , "con_type" : "mobile",
            "images[]" : "\(images)"
        ]
        //Handel Parametars
        let api_token = UserDefaults.standard.string(forKey: "API_TOKEN") ?? ""

        let headers = ["Authorization":"Bearer \(api_token)"]
        //Networking
        let url = "https://elkenany.com/api/store/add-ads-store"
        APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm , headers: headers, method: .post) { (Success:AddAds?, Failed:AddAds?, error) in
            if let error = error {
                // Internet Offline
                print(error)
                hud.dismiss()
//                self.ErrorHandeling(errorMessage: error.localizedDescription)
            }
            else if let loginError = Failed {
                //Data Wrong From Server
                hud.dismiss()
//                self.ErrorHandeling(errorMessage: loginError.error ?? "خطآ في تسجيل الدخول تاكد من البيانات الرقم السري او البريد الالكتروني ")
                print(loginError)
            }
            else {
                hud.dismiss()
//                self.chatTV.reloadData()
                
                print("goooooooooood")
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    

    
    @IBOutlet var dissmiss: UIView!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func radPhone(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func radMessage(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    @IBAction func radAll(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    ///imageeeeee from device
    class func convertImageToBase64(image: UIImage) -> String {
          let imageData = image.pngData()!
          return imageData.base64EncodedString()
      }
    
    @IBAction func updateImage(_ sender: Any) {
        let imageController = UIImagePickerController()
                imageController.delegate = self
          imageController.allowsEditing = true
            imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imageController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
//            print(image)
        
//        let photo = info[.phAsset] as? PHAsset
//        if let filename = photo?.value(forKey: "filename") as? String {
//            print("===========" ,filename)
//
//        }
        guard let url = info[.imageURL] as? NSURL else { return }
        let filename = url.lastPathComponent!
        images.append(filename)
        print(filename)
        
        self.dismiss(animated: true, completion: nil)
       
}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func add(_ sender: Any) {
        addAds()
    }
    
    
    
}
