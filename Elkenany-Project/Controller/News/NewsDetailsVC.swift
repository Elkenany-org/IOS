//
//  NewsDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import ProgressHUD
import Alamofire
import WebKit
class NewsDetailsVC: UIViewController {
    
    @IBOutlet weak var newTable: UITableView!
    //MARK:- Outlets and Proparites
    var newsDetails:NewsDetialsDataModel?
    @IBOutlet weak var NewsDetailsCV: UICollectionView!
    //main
    var newsIdFromHome = 0
    //recommend
    var news_id_from_home = 0
    var news_id = 0
    var keyFromHome = ""
    var id_home_search = 0
    
    
    
    //viewdidload -------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        newTable.estimatedRowHeight = 150
        newTable.rowHeight = UITableView.automaticDimension
        FatchDataOfNewsDetails()
    }
    
    
    
    //Setup UI
    fileprivate func SetUpUI() {
        NewsDetailsCV.delegate = self
        NewsDetailsCV.dataSource = self

        newTable.register(UINib(nibName: "detailOne", bundle: nil), forCellReuseIdentifier: "detailOne")
        newTable.register(UINib(nibName: "detailTwo", bundle: nil), forCellReuseIdentifier: "detailTwo")
        self.NewsDetailsCV.register(UINib(nibName: "collectioncell", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
        self.NewsDetailsCV.register(UINib(nibName: "newsDetailsCell", bundle: nil), forCellWithReuseIdentifier: "newsDetailsCell")
        title = "تفاصيل الخبر"
    }
    
    
    //MARK:- FatchDataOfNewsDetails from home [main data from sector at home]
    func FatchDataOfNewsDetails(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.newsIdFromHome)"]
            print(param)
            let newsDetailsURL = "https://admin.elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.newsDetails = success
                    DispatchQueue.main.async {
                        self.NewsDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    
    
    //MARK:- FatchDataOfNewsDetails from home [main data from sector at home]
    func FatchDataOfNewsDetailsFromHomeSearch(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.id_home_search)"]
            print(param)
            let newsDetailsURL = "https://admin.elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.newsDetails = success
                    DispatchQueue.main.async {
                        self.NewsDetailsCV.reloadData()
                        print(success.data ?? "")
                    }
                }
            }
        }
    }
    
    
    //MARK:- choose news from home collection to present the news collection
    func FatchDataOfNewsDetailsFromHome(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.news_id_from_home)"]
            let newsDetailsURL = "https://admin.elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.newsDetails = success
                    DispatchQueue.main.async {
                        self.NewsDetailsCV.reloadData()
                        
                        
                    }
                }
            }
        }
    }
    
    //MARK:- choose news from recommendition collection to present the news collection
    
    func FatchDataOfNewsDetailsFromHomeRecomindition(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.news_id)"]
            let newsDetailsURL = "https://admin.elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.newsDetails = success
                    DispatchQueue.main.async {
                        self.NewsDetailsCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    
    
    //MARK:- Featch Data Of News Details Insid from home
    func FatchDataOfNewsDetailsInsid(){
        // Handeling Loading view progress
        ProgressHUD.colorAnimation = #colorLiteral(red: 0.189121604, green: 0.4279403687, blue: 0.1901243627, alpha: 1)
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let param = ["id": "\(self.newsIdFromHome)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let newsURL = "https://admin.elkenany.com/api/news/news-detials?id="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    ProgressHUD.dismiss()
                    print("============ error \(error)")
                }else {
                    ProgressHUD.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.newsDetails = success
                    DispatchQueue.main.async {
                        self.NewsDetailsCV.reloadData()
                    }
                }
            }
        }
    }
    
}


//MARK:- collection view methods  of Details
extension NewsDetailsVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let NewsDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsDetailsCell", for: indexPath) as! newsDetailsCell
            
            NewsDetailsCell.newsTitle.text = newsDetails?.data?.title ?? "جاري التحميل"
            NewsDetailsCell.newsDate.text = newsDetails?.data?.createdAt ?? "جاري التحميل"
            NewsDetailsCell.newsDescription.loadHTMLString(newsDetails?.data?.desc ?? "test", baseURL: nil)
            if let imagee = newsDetails?.data?.image {
                NewsDetailsCell.configureCell(image: imagee)
            }

            return NewsDetailsCell
            
        } else {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! collectioncell
        
            if keyFromHome == "keyhome"{
                cell1.id_param = news_id_from_home
                cell1.FatchDataOfNews()
                
            }else{
                cell1.id_param = newsIdFromHome
                cell1.FatchDataOfNews()
                
            }

            return cell1
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: collectionView.frame.width, height: collectionView.contentSize.height)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }
    }
    
    

}


