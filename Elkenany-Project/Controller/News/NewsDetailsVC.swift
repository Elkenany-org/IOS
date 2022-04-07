//
//  NewsDetailsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import JGProgressHUD
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
        newTable.delegate = self
        newTable.dataSource = self
        newTable.register(UINib(nibName: "detailOne", bundle: nil), forCellReuseIdentifier: "detailOne")
        newTable.register(UINib(nibName: "detailTwo", bundle: nil), forCellReuseIdentifier: "detailTwo")
        self.NewsDetailsCV.register(UINib(nibName: "collectioncell", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
        self.NewsDetailsCV.register(UINib(nibName: "newsDetailsCell", bundle: nil), forCellWithReuseIdentifier: "newsDetailsCell")
        title = "تفاصيل الخبر"
    }
    
    
    //MARK:- FatchDataOfNewsDetails from home [main data from sector at home]
    func FatchDataOfNewsDetails(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.newsIdFromHome)"]
            print(param)
            let newsDetailsURL = "https://elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.news_id_from_home)"]
            let newsDetailsURL = "https://elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            let headers = ["app-id": "\(api_token ?? "")" ]
            let param = ["id": "\(self.news_id)"]
            let newsDetailsURL = "https://elkenany.com/api/news/news-detials?id="
            APIServiceForQueryParameter.shared.fetchData(url: newsDetailsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let param = ["id": "\(self.newsIdFromHome)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let newsURL = "https://elkenany.com/api/news/news-detials?id="
            
            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
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
            cell1.id_param = newsIdFromHome
            cell1.FatchDataOfNews()
            return cell1
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    

}


//MARK:- Taableeeeeeeeeeee View
extension NewsDetailsVC: UITableViewDelegate , UITableViewDataSource, UIWebViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            
            let NewsDetailsCell = tableView.dequeueReusableCell(withIdentifier: "detailOne", for: indexPath) as! detailOne
            NewsDetailsCell.descriptionDetail.loadHTMLString(newsDetails?.data?.desc ?? "test", baseURL: nil)
            NewsDetailsCell.detailDate.text = newsDetails?.data?.createdAt ?? "جاري التحميل"
            NewsDetailsCell.detailTitle.text = newsDetails?.data?.title ?? "جاري التحميل"
            return NewsDetailsCell

        } else {
            let NewsDetailsCell = tableView.dequeueReusableCell(withIdentifier: "detailTwo", for: indexPath) as! detailTwo
            return NewsDetailsCell
        }
    }
}



