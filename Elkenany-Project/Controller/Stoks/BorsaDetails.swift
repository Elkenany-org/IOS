//
//  BorsaDetails.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/25/21.
//

import UIKit
import JGProgressHUD

class BorsaDetails: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var LocalBorsaCV: UICollectionView!

    var variaTest = ""
    var fodderTypeParamter = ""
    var fodder_id_Parameter = 0
    var fodderTitle = ""
    var localTitle = ""
    var borsaTit = ""
    var loc_id = 0
    var type = ""
    let date = Date()
    let formatter = DateFormatter()
    


    
 
    //Proparites and Outlets
    var localBorsaData:LocaBorsa?
    var arrone = ["الاسم" , "السعر" , "مقدار" , "نظام الشحن" ,"اتجاه السعر"]
    var arrTwo = ["الاسم" , "السعر" , "مقدار" ,"اتجاه السعر"]

    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        title = ""
        print("vTest \(variaTest)")
       

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        FatchLocalBorsa()
    }
    
    
    
    //MARK:- setup ui for Borsa Collection
    fileprivate func SetupUI() {
        // Do any additional setup after loading the view.
        LocalBorsaCV.dataSource = self
        LocalBorsaCV.delegate = self
        self.LocalBorsaCV.register(UINib(nibName: "localBorsaCell", bundle: nil), forCellWithReuseIdentifier: "localBorsaCell")
        self.LocalBorsaCV.register(UINib(nibName: "testBorsaCell", bundle: nil), forCellWithReuseIdentifier: "test")
        self.LocalBorsaCV.register(UINib(nibName: "StanderCell", bundle: nil), forCellWithReuseIdentifier: "StanderCell")
    }
    

    
    //MARK:- present picker view for choose Date
    @IBAction func presentDate(_ sender: Any) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "BorsaDatePiker"))! as BorsaDatePiker
        
        vc.completionHandler = {backs in
            print("======== backs \(backs)")
            
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "جاري التحميل"
            hud.show(in: self.view)
                
                DispatchQueue.global(qos: .background).async {
                    let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
                    print("this is token\(api_token ?? "")")
                    let typeParameter = UserDefaults.standard.string(forKey: "she")
                    let idParameter = UserDefaults.standard.string(forKey: "he")
//                    let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

                    let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")", "date": "\(backs ?? "")" ]
                    print("============== request \(param)")
                    let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
                    let statisticesByDate = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="

                    APIServiceForQueryParameter.shared.fetchData(url: statisticesByDate, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                        if let error = error{
                            hud.dismiss()

                            print("============ error \(error)")
                        }else {
                            hud.dismiss()
                            guard let success = success else {return}
                            self.localBorsaData = success
                            DispatchQueue.main.async {
                                self.LocalBorsaCV.reloadData()
                                self.btnLabel.titleLabel?.text = backs
                            }
                       
                        }
                    }
                }
            
            return backs
        }
        
        self.present(vc, animated: true, completion: nil)
       
    }
    
    
    
    
    func FatchLocalBorsa(){
        //Handeling Loading view progress
//        formatter.dateFormat = "dd.MM.yyyy"
        formatter.dateFormat = "yyyy-MM-dd"

        let result = formatter.string(from: date)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
            let typeParameter = UserDefaults.standard.string(forKey: "she")
            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")", "date": "\(result)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    func FatchLocalBorsaFodder(){
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id=&date="
//            let typeParameter = UserDefaults.standard.string(forKey: "she")
//            let idParameter = UserDefaults.standard.string(forKey: "he")
//            let DateParameter = UserDefaults.standard.string(forKey: "Date_From_Picker")

            let param = ["type": "\(self.fodderTypeParamter)" , "id": "\(self.fodder_id_Parameter)", "date": "\(result)" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    func FatchLocalBorsaFromHomeSelection(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let companyGuide = "https://elkenany.com/api/localstock/local-stock-show-sub-section?type=&id="
            let typeParameter = UserDefaults.standard.string(forKey: "REC_type_Stoke")
            let idParameter = UserDefaults.standard.string(forKey: "REC_Id_Stoke")

            let param = ["type": "\(typeParameter ?? "")" , "id": "\(idParameter ?? "")" ]
            print("============== request \(param)")
            let headers = ["Authorization": "Bearer \(api_token ?? "")" ]
            APIServiceForQueryParameter.shared.fetchData(url: companyGuide, parameters: param, headers: headers, method: .get) { (success:LocaBorsa?, filier:LocaBorsa?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.localBorsaData = success
                    DispatchQueue.main.async {
                        self.LocalBorsaCV.reloadData()
                   
                            

                    }

                }
            }
        }
    }
    
    
    
    @IBAction func toStatisticesMainVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "StatisticesMembers") as? StatisticesMembers
        vc?.typeFromBorsa = variaTest
        navigationController?.pushViewController(vc!, animated: true)
           
    }
    
    
    
}



//MARK:- For Borsa details
extension BorsaDetails:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    

    // number of sections --------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    //number of row in section ------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localBorsaData?.data?.members?.count ?? 0
    }
    
    
    
    // cell configuration --------------------- cell for row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
//        if fodderTypeParamter ! {
//
//
//        }
        
        
        
        
        
        if localBorsaData?.data?.members?[indexPath.item].newColumns?.count == nil && localBorsaData?.data?.members?.count != nil{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "StanderCell", for: indexPath) as! StanderCell
            cell1.proudectLabel.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
            cell1.priceLabel.text = String(localBorsaData?.data?.members?[indexPath.item].price ?? 0) ?? ""
            cell1.changeLabel.text = localBorsaData?.data?.members?[indexPath.item].change ?? ""
            cell1.changeTwo.text = localBorsaData?.data?.members?[indexPath.item].changetwo ?? ""
            let statimage = localBorsaData?.data?.members?[indexPath.item].statistics ?? ""
            cell1.configureCell(image: statimage)
            view1.isHidden = true
            view2.isHidden = false
             return cell1
            
            
        } else if localBorsaData?.data?.members?[indexPath.item].newColumns?.count == 1  && localBorsaData?.data?.members?.count != nil{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "localBorsaCell", for: indexPath) as! localBorsaCell
            cell2.proudectName.text = localBorsaData?.data?.members?[indexPath.item].name ?? ""
            cell2.priceOfProudect.text = String(localBorsaData?.data?.members?[indexPath.item].price ?? 0)
            cell2.changeLabel.text = localBorsaData?.data?.members?[indexPath.item].change ?? ""
            cell2.changeTwo.text = localBorsaData?.data?.members?[indexPath.item].changetwo ?? ""
//            cell2.weightStat.text = localBorsaData?.data?.members?[indexPath.item].newColumns?[indexPath.item] ?? "dev test"
//            for itemss in localBorsaData?.data?.members?[indexPath.item].newColumns?[indexPath.item] ?? ""{
//                cell2.changeLabel.text = itemss[indexPath.item]
//            }
            
//            cell2.weightStat.text = "تيست"
            let imageStat = localBorsaData?.data?.members?[indexPath.item].statistics ?? ""
            cell2.configureCell(image: imageStat)
            view1.isHidden = false
            view2.isHidden = true
            return cell2
            
        }else{
            ///missed
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! testBorsaCell
            return cell3
        }
//        return UICollectionViewCell()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // cell height ----------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    


}
