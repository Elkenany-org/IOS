//
//  FilterHome.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 3/21/22.
//

import UIKit

protocol BorsaFilterss {
    func RunFilterDone(filter:())

}


class FilterHome: UIViewController {

    @IBOutlet weak var filterHomeCV: UICollectionView!
    var stokeTYPE = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        //configuer UI
        filterHomeCV.delegate = self
        filterHomeCV.dataSource = self
        filterHomeCV.register(UINib(nibName: "filterHeader", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "filterHeader")
        self.filterHomeCV.register(UINib(nibName: "filterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    var RunFilterDelegetsInStoke :BorsaFilterss?

    
    //BTN used to send data -------------
    @IBAction func ConfirmFilterBorsa(_ sender: Any) {
        RunFilterDelegetsInStoke?.RunFilterDone(filter: ())
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}


//MARK:- methods of tableview
extension FilterHome:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! filterCell
        switch indexPath.item{
        case 0:
//            cell.filterTitle.text = cellItems[indexPath.item]
            cell.filterTitle.text = "القطاع"
            cell.filterImage.image = #imageLiteral(resourceName: "settings (1)")
        case 1:
            cell.filterTitle.text = "البورصة"
            cell.filterImage.image = #imageLiteral(resourceName: "store")
        default:
            return UICollectionViewCell()
        }
        return cell

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "SelectionPopuVC") as! SelectionPopuVC
            present(selectedVC, animated: true, completion: nil)
            
        case 1:
            
            let selectedVC = storyboard?.instantiateViewController(withIdentifier: "SectorFilterVC") as! SectorFilterVC
            selectedVC.typeOfBorsa = stokeTYPE
            present(selectedVC, animated: true, completion: nil)
            
        default:
            print("not selected for any filter --------------")
        }
        
    }
    
    
}


