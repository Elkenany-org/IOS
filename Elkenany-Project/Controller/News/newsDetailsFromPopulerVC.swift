//
//  newsDetailsFromPopulerVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 2/6/22.
//

import UIKit
import JGProgressHUD


class newsDetailsFromPopulerVC: UIViewController {

    @IBOutlet weak var DetailsCollectionFromPopuler: UICollectionView!
    var detailsModel: NewsDetialsDataModel?
    var id_MoreNwes = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        DetailsCollectionFromPopuler.delegate = self
        DetailsCollectionFromPopuler.dataSource = self
        self.DetailsCollectionFromPopuler.register(UINib(nibName: "collectioncell", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
        self.DetailsCollectionFromPopuler.register(UINib(nibName: "newsDetailsCell", bundle: nil), forCellWithReuseIdentifier: "newsDetailsCell")
        title = "تفاصيل الخبر"

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FatchDataOfNewsDetailsFromPopuler()
    }
    

    func FatchDataOfNewsDetailsFromPopuler(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
//            let idParameter = UserDefaults.standard.string(forKey: "NEWS_ID")
            let param = ["id": "\(self.id_MoreNwes)"]
            let headers = ["app-id": "\(api_token ?? "")" ]
            let newsURL = "https://elkenany.com/api/news/news-detials?id="

            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (NewsDetailssuccess:NewsDetialsDataModel?, NewsDetailsfilier:NewsDetialsDataModel?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = NewsDetailssuccess else {return}
                    self.detailsModel = success
                    DispatchQueue.main.async {
                        self.DetailsCollectionFromPopuler.reloadData()
                        
                    }
                }
            }
        }
    }

 

}


//MARK:- collection view methods  of Details

extension newsDetailsFromPopulerVC:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let NewsDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsDetailsCell", for: indexPath) as! newsDetailsCell
            NewsDetailsCell.newsTitle.text = detailsModel?.data?.title ?? "test"
            NewsDetailsCell.newsDate.text = detailsModel?.data?.createdAt ?? "test"
            NewsDetailsCell.newsDescription.loadHTMLString(detailsModel?.data?.desc ?? "test", baseURL: nil)
            NewsDetailsCell.Image.contentMode = .scaleAspectFill
           if let imagee = detailsModel?.data?.image {

            NewsDetailsCell.configureCell(image: imagee)

            }
            return NewsDetailsCell
            
        } else {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! collectioncell
//            cell1.id_param = newsIdFromHome
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
    
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.item == 0{
            print("helllo ")
        }else{
            print("helllo world")
        }
      }
   }


//MARK:- parseing html to String
extension String {
    var htmlllToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlllToString: String {
        return htmlllToAttributedString?.string ?? ""
    }
}
