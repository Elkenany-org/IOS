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
        switch section {
        case 0:
            return 2
        case 1:
            return 0
        default:
            return 2
        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutUsCell", for: indexPath) as! aboutUsCell
            cell.locationtitle.text = "مقر الشركة بالمنصورة"
            cell.mobile.text = "+20502210179"
            cell.fax.text = "+20502210179"

            return cell
            
        case 1:
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutUsCell", for: indexPath) as! aboutUsCell
            cell1.locationtitle.text = "مقر الشركة بالقاهرة"
            cell1.locationDesc.text = "مصر - مدينة نصر - ٣٧ شارع مصطفي النحاس - اعلي البنك الاهلي"
            cell1.mobile.text = "+20222730688"
            cell1.fax.text = "+20502210179"
            

            return cell1
            
        default:
            return UICollectionViewCell()
        }
        
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width , height: 485)

    }


//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        switch  {
//        case 0:
//            return CGSize(width:collectionView.frame.width , height: 50)
//        case 1:
//            return CGSize(width:collectionView.frame.width / 3 , height: 50)
//        default:
//            print("")
//        }
//        return CGSize(width:collectionView.frame.width , height: 0)
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch indexPath.item {
        case 0:
            let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
            return headerrrr
        case 1:
            let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
            return headerrrr
        default:
            print("")
        }
        return UICollectionReusableView()
    }
        
//        let headerrrr = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "headerLine", for: indexPath) as! headerLine
//        return headerrrr
//    }
    
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        switch indexPath.row {
//        case 0:
//            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
//            navigationController?.pushViewController(vc, animated: true)
//        case 1:
//            let vc = storyboard?.instantiateViewController(identifier: "CompanyGuideVC") as! CompanyGuideVC
//            navigationController?.pushViewController(vc, animated: true)
//        case 2:
//            let vc = storyboard?.instantiateViewController(identifier: "CompanyGuideVC") as! CompanyGuideVC
//            navigationController?.pushViewController(vc, animated: true)
//
//        case 3:
//            let vc = storyboard?.instantiateViewController(identifier: "NewsVC") as! NewsVC
//            navigationController?.pushViewController(vc, animated: true)
//        case 4:
//            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
//            navigationController?.pushViewController(vc, animated: true)
//        case 5:
//            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
//            navigationController?.pushViewController(vc, animated: true)
//
//        case 6:
////            let vc = storyboard?.instantiateViewController(identifier: "BorsaHomeVC") as! BorsaHomeVC
////            navigationController?.pushViewController(vc, animated: true)
//
//            print("settings")
//        case 7:
//            let vc = storyboard?.instantiateViewController(identifier: "AboutVC") as! AboutVC
//            navigationController?.pushViewController(vc, animated: true)
//            print("about elkenany")
//        default:
//            print("hamada")
//        }
//
//
//    }
    
    


}
