//
//  showDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 5/14/22.
//

import UIKit


class showDetailsVC: UIViewController {


    
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var showDesc: UILabel!
    @IBOutlet weak var gooooootitle: UIButton!

    
    var showModel:ShoweModel?
    var idOfShow = 0
    var presentKeyHome = ""
//    var idShowHome = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollection.dataSource = self
        imageCollection.delegate = self
        self.imageCollection.register(UINib(nibName: "sliderCellShow", bundle: nil), forCellWithReuseIdentifier: "sliderCellShow")
        if presentKeyHome == "hoome"{
            showeDataServiceHome()
            
        }else if presentKeyHome == "hommmmeREC" {
            showeDataServiceHomeREC()

        }else{
            showeDataService()
        }



    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func showeDataService(){
        let idShow = UserDefaults.standard.string(forKey: "IDDD") ?? ""
        let parm = ["id" : "\(idShow)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show/?id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShoweModel?, filier:ShoweModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.showModel = success
                
                    DispatchQueue.main.async {
                        self.viewCount.text = String(success.data?.viewCount ?? 0)
                        self.showDesc.text = success.data?.shortDesc ?? ""
                        self.imageCollection.reloadData()
                        print("hellllllllo")
                        print("helllllllllllllo", success.data?.shortDesc ?? "")
                        
                    }
                }
            }
        }
    }
    
    func showeDataServiceHome(){
        let idShowHome = UserDefaults.standard.string(forKey: "IDDHOME") ?? ""
        let parm = ["id" : "\(idShowHome)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show/?id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShoweModel?, filier:ShoweModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.showModel = success
                
                    DispatchQueue.main.async {
                        self.viewCount.text = String(success.data?.viewCount ?? 0)
                        self.showDesc.text = success.data?.shortDesc ?? ""
                        self.imageCollection.reloadData()
                        print("hellllllllo")
                        print("helllllllllllllo", success.data?.shortDesc ?? "")
                        
                    }
                }
            }
        }
    }
    
    
    func showeDataServiceHomeREC(){
        let idShowHome = UserDefaults.standard.string(forKey: "IDDHOMEREC") ?? ""
        let parm = ["id" : "\(idShowHome)"]
        DispatchQueue.global(qos: .background).async {
            let url = "https://elkenany.com/api/showes/one-show/?id="
            

            APIServiceForQueryParameter.shared.fetchData(url: url, parameters: parm, headers: nil, method: .get) { (success:ShoweModel?, filier:ShoweModel?, error) in
                if let error = error{
                    //internet error
                    print("============ error \(error)")
                    
                }
                else if let loginError = filier {
                    //Data Wrong From Server
                    print("--========== \(loginError.error?.localizedCapitalized ?? "") ")
                }
                else {
                    guard let success = success else {return}
                    self.showModel = success
                
                    DispatchQueue.main.async {
                        self.viewCount.text = String(success.data?.viewCount ?? 0)
                        self.showDesc.text = success.data?.shortDesc ?? ""
                        self.imageCollection.reloadData()
                        print("hellllllllo")
                        print("helllllllllllllo", success.data?.shortDesc ?? "")
                        
                    }
                }
            }
        }
    }


    @IBAction func showDate(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "teicketVC") as! teicketVC
        vc.setupKey = "moreData"
        vc.showIdd = idOfShow
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func showCost(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "teicketVC") as! teicketVC
        vc.setupKey = "cost"
        vc.showIdd = idOfShow

        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func showTime(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "teicketVC") as! teicketVC
        vc.setupKey = "time"
        vc.showIdd = idOfShow

        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func showOrganize(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "teicketVC") as! teicketVC
        vc.setupKey = "organizne"
        vc.showIdd = idOfShow

        present(vc, animated: true, completion: nil)
        
    }
    
}


//MARK:- show details image
extension showDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showModel?.data?.images?.count ?? 0
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCellShow", for: indexPath) as! sliderCellShow
        let image = showModel?.data?.images?[indexPath.item].image ?? ""
//        cell1.logooImage.contentMode = .scaleAspectFit
        cell1.configureImage(image: image)
        return cell1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageSliderVC") as! ImageSliderVC
        present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.2 , height: 90)
        
    }
    
}
