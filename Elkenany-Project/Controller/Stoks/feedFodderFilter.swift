//
//  feedFodderFilter.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/20/22.
//

import UIKit
import JGProgressHUD

protocol FilterFeedDone {
    func RunFilterr(filter:())
}



class feedFodderFilter: UIViewController {

    @IBOutlet weak var FeedFilter: UITableView!
    @IBOutlet weak var fodderCategories: UICollectionView!
    var FilterFeed:FeedModelData?
    var iddddd = 0
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetFilterDataForFeed()
        fodderCategories.semanticContentAttribute = .forceRightToLeft
        // Do any additional setup after loading the view.
    }
    

    
    fileprivate func setupUI() {
        FeedFilter.delegate = self
        FeedFilter.dataSource = self
        fodderCategories.delegate = self
        fodderCategories.dataSource = self
        FeedFilter.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
        fodderCategories.register(UINib(nibName: "SelectedSectorCell", bundle: nil), forCellWithReuseIdentifier: "SelectedSectorCell")
    }
    
    var RunFilterDelegettt :FilterFeedDone?

    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK:- get data of filter Popup
    func GetFilterDataForFeed(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
                  ///data not real
            let stoID = UserDefaults.standard.string(forKey: "he") ?? ""

            let param = ["stock_id": "\(stoID)" , "mini_id" : "\(self.iddddd)"]

//            let param = ["stock_id": "13" , "food_id" : "457"]
            let subGuideFilterURL = "https://elkenany.com/api/localstock/feeds-items?stock_id=&mini_id=&food_id="
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:FeedModelData?, filier:FeedModelData?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.FilterFeed = success
                    DispatchQueue.main.async {
                        self.FeedFilter.reloadData()
                        self.fodderCategories.reloadData()
                        print(success.data ?? "")
                        
                    }
                }
            }
        }
    }
    
    
    //MARK:- get data of filter Popup
    func GetFilterDataForFeedSelected(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
                  ///data not real
            let stoID = UserDefaults.standard.string(forKey: "he") ?? ""

            let param = ["stock_id": "\(stoID)" , "mini_id" : "\(self.iddddd)"]
            let subGuideFilterURL = "https://elkenany.com/api/localstock/feeds-items?stock_id=&mini_id=&food_id="
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:FeedModelData?, filier:FeedModelData?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.FilterFeed = success
                    DispatchQueue.main.async {
                        self.FeedFilter.reloadData()
                        self.fodderCategories.reloadData()
                        print(success.data ?? "")
                        
                    }
                }
            }
        }
    }

}

//MARK:- tableView Methodes
extension feedFodderFilter:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterFeed?.data?.fodderList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = FilterFeed?.data?.fodderList?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterSection") as? subFilterSection {
        let feed_id = FilterFeed?.data?.fodderList?[indexPath.row].id ?? 0
//            SectionVC.secId = sec_id
            /// save idddddddddd
            UserDefaults.standard.set(feed_id, forKey: "FILTER_Feed_ID")
//            FilterAnimation.shared.filteranmation(vieww: view)

//            self.present(SectionVC, animated: true, completion: nil)
        RunFilterDelegettt?.RunFilterr(filter: ())
            dismiss(animated: true, completion: nil)
        
//        }
    }
    
}




extension feedFodderFilter:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterFeed?.data?.fodderCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let feedCatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as? SelectedSectorCell{
            feedCatCell.titleLabel.text = FilterFeed?.data?.fodderCategories?[indexPath.item].name ?? ""
            if FilterFeed?.data?.fodderCategories?[indexPath.item].selected == 1 {
                feedCatCell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
//                feedCatCell.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            }else{
                feedCatCell.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            }
            return feedCatCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let list_ID = FilterFeed?.data?.fodderCategories?[indexPath.item].id ?? 0
        self.iddddd = list_ID
        GetFilterDataForFeedSelected()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let feedCatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSectorCell", for: indexPath) as! SelectedSectorCell
        if FilterFeed?.data?.fodderCategories?[indexPath.item].selected != 1 {
            feedCatCell.cooo.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.2, alpha: 1)
//                feedCatCell.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        }else{
            feedCatCell.cooo.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
        }
        
        return CGSize(width: 100, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectedSectorCell{
            
            if(cell.isSelected == false)
            {
                cell.cooo.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }
        }
    }
    
}
