//
//  FilterMainVC.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 6/22/22.
//

import UIKit

protocol FilterShowMagazine {
    func runFilterShow()
}


class FilterMainVC: UIViewController {

    //outlets
    @IBOutlet weak var FilterMainCV: UICollectionView!
    var subFilterMainModel:SubGuideFilter?
    var listOfData = ["القطاع", "الدول","المدينة", "الترتيب"]
    var presentFilterKey = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var filterShowMagzzineDeleget: FilterShowMagazine?
    
    fileprivate func setupUI() {
        FilterMainCV.delegate = self
        FilterMainCV.dataSource = self
        self.FilterMainCV.register(UINib(nibName: "filterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    
    
    
    @IBAction func applayFilter(_ sender: Any) {
        filterShowMagzzineDeleget?.runFilterShow()
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func dismissss(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    

}


//MARK:- For Borsa details
extension FilterMainVC:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! filterCell
        cell.filterTitle.text = listOfData[indexPath.item]
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let selectedVCSectore = storyboard?.instantiateViewController(withIdentifier: "subFilterSectore") as! subFilterSectore
            present(selectedVCSectore, animated: true, completion: nil)
 
        case 1:
            let selectedVCCountry = storyboard?.instantiateViewController(withIdentifier: "subFilterCountry") as! subFilterCountry
            present(selectedVCCountry, animated: true, completion: nil)
        case 2:
            let selectedVCCity = storyboard?.instantiateViewController(withIdentifier: "subFilterCity") as! subFilterCity
            present(selectedVCCity, animated: true, completion: nil)
        case 3:
            let selectedVCOrganization = storyboard?.instantiateViewController(withIdentifier: "subFilterOrganize") as! subFilterOrganize
            present(selectedVCOrganization, animated: true, completion: nil)
        default:
            print("hhhhh")
        }
    }
    
    
}


