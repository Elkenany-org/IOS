//
//  abouUsVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/27/21.
//

import UIKit

class abouUsVC: UIViewController {
    
    @IBOutlet weak var aboutUsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutUsCollection.delegate = self
        aboutUsCollection.dataSource = self
        // Do any additional setup after loading the view.
        self.aboutUsCollection.register(UINib(nibName: "aboutUsCell", bundle: nil), forCellWithReuseIdentifier: "aboutUsCell")
        self.aboutUsCollection.register(UINib(nibName: "aboooooout", bundle: nil), forCellWithReuseIdentifier: "aboooooout")
        aboutUsCollection.register(UINib(nibName: "headerLine", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerLine")
        
        
    }
    
    
    func ss(ss:UICollectionViewCell){
        ss.layer.cornerRadius = 15.0
        ss.layer.borderWidth = 0.0
        ss.layer.shadowColor = UIColor.black.cgColor
        ss.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        ss.layer.shadowRadius = 5.0
        ss.layer.shadowOpacity = 0.4
        ss.layer.masksToBounds = false
        
    }
    
    
    
    @IBAction func customerServes(_ sender: Any) {
        let vc = (storyboard?.instantiateViewController(identifier: "customerserviceVC"))! as customerserviceVC
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
}



extension abouUsVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutUsCell", for: indexPath) as! aboutUsCell
//            cell.locationtitle.text = "مقر الشركة بالمنصورة"
//            cell.mobile.text = "+20502210179"
//            cell.fax.text = "+20502210179"
            return cell
            
        case 1:
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "aboooooout", for: indexPath) as! aboooooout
            return cell1
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        switch indexPath.item {
//        case 0:
//            
//            break
//            
//            
//        case 1:
//            
//            break
//            
//            
//        default:
//            print("hellllllo")
//        }
        
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            switch indexPath.item {
            case 0:
                return CGSize(width:collectionView.frame.width , height: 485)
    
            case 1:
                return CGSize(width:collectionView.frame.width , height: 485)
    
            default:
                return CGSize(width:collectionView.frame.width , height: 485)
            }
    
    
    
    
        }
    
        
        
    }
    

    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch indexPath.item {
//        case 0:
//            let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
//            return headerrrr
//        case 1:
//            let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
//            return headerrrr
//        default:
//            print("")
//        }
//        return UICollectionReusableView()
//    }
//
    
    
    
    

