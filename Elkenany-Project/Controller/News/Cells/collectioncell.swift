//
//  collectioncell.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/14/21.
//

import UIKit
import JGProgressHUD
import Alamofire

class collectioncell: UICollectionViewCell {
    
    
    @IBOutlet weak var testCV: UICollectionView!
    var dataDetails:NewsDetialsDataModel?
    var id_param = 0
    var news_id_from_home = 0
    var fromMore = 0

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        testCV.dataSource = self
        testCV.delegate = self
        self.testCV.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        self.testCV.register(UINib(nibName: "newsDetailsCell", bundle: nil), forCellWithReuseIdentifier: "newsDetailsCell")
        self.testCV.register(UINib(nibName: "collectioncell", bundle: nil), forCellWithReuseIdentifier: "collectioncell")
    }
    
    
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 1, height: 1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.7
        ss.layer.masksToBounds = false

    }
    
   
    
   

    func FatchDataOfNews(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let param = ["id": "\(self.id_param)"]
            let newsURL = "https://elkenany.com/api/news/news-detials?id="

            let headers = ["app-id": "\(api_token ?? "")" ]

            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:NewsDetialsDataModel?, filier:NewsDetialsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.dataDetails = success
                    DispatchQueue.main.async {
                        self.testCV.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    func FatchDataOfNewsMore(){
        DispatchQueue.global(qos: .background).async {
            let api_token = UserDefaults.standard.string(forKey: "API_TOKEN")
            print("this is token\(api_token ?? "")")
            let param = ["id": "\(self.fromMore)"]
            let newsURL = "https://elkenany.com/api/news/news-detials?id="

            let headers = ["app-id": "\(api_token ?? "")" ]

            APIServiceForQueryParameter.shared.fetchData(url: newsURL, parameters: param, headers: headers, method: .get) { (success:NewsDetialsDataModel?, filier:NewsDetialsDataModel?, error) in
                if let error = error{
                    print("============ error \(error)")
                }else {
                    guard let success = success else {return}
                    self.dataDetails = success
                    DispatchQueue.main.async {
                        self.testCV.reloadData()
                    }
                }
            }
        }
    }

    
}





extension collectioncell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataDetails?.data?.news?.count ?? 0
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.newsTitle.text = dataDetails?.data?.news?[indexPath.item].title ?? ""
        cell.newsDate.text = dataDetails?.data?.news?[indexPath.item].createdAt ?? "test"
        if let image = dataDetails?.data?.news?[indexPath.item].image{
            cell.configureCell(image: image)
        }
        ss(ss: cell)
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboard.instantiateViewController(identifier: "newsDetailsFromPopulerVC") as! newsDetailsFromPopulerVC
        let MoreNews_id = dataDetails?.data?.news?[indexPath.row].id ?? 0
        vcc.id_MoreNwes = MoreNews_id
        if let vc = self.nextttt(ofType: UIViewController.self) {
            vc.navigationController?.pushViewController(vcc, animated: true)
        }
    }
    
}






extension UIResponder {
    func nextttt<T:UIResponder>(ofType: T.Type) -> T? {
        let r = self.next
        if let r = r as? T ?? r?.next(ofType: T.self) {
            return r
        } else {
            return nil
        }
    }
}







//MARK:- parseing html to String
//extension String {
//    var htmllToAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return nil
//        }
//    }
//    var htmllToString: String {
//        return htmllToAttributedString?.string ?? ""
//    }
//}


