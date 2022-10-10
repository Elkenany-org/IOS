//
//  subFilterMain.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD


protocol FilterSubData {
    func runFilter()
}



class subFilterMain: UIViewController {
    //Model
    @IBOutlet weak var subMainCV: UICollectionView!
    var subFilterMainModel:SubGuideFilter?
    var listOfData = ["القطاع", "الاقسام", "الدول","المدينة", "الترتيب"]
    var filterDelegete:FilterSubData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        subMainCV.delegate = self
        subMainCV.dataSource = self
        self.subMainCV.register(UINib(nibName: "filterCell", bundle: nil), forCellWithReuseIdentifier: "filterCell")
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func applayFilter(_ sender: Any) {
        filterDelegete?.runFilter()
        dismiss(animated: true, completion: nil)
    }
    
    
}


//MARK:- For Borsa details
extension subFilterMain:UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let selectedVCSectore = storyboard?.instantiateViewController(withIdentifier: "subFilterSectore") as! subFilterSectore
            present(selectedVCSectore, animated: true, completion: nil)
        case 1:
            let selectedVCSection = storyboard?.instantiateViewController(withIdentifier: "subFilterSection") as! subFilterSection
            present(selectedVCSection, animated: true, completion: nil)
        case 2:
            let selectedVCCountry = storyboard?.instantiateViewController(withIdentifier: "subFilterCountry") as! subFilterCountry
            present(selectedVCCountry, animated: true, completion: nil)
        case 3:
            let selectedVCCity = storyboard?.instantiateViewController(withIdentifier: "subFilterCity") as! subFilterCity
            present(selectedVCCity, animated: true, completion: nil)
        case 4:
            let selectedVCOrganization = storyboard?.instantiateViewController(withIdentifier: "subFilterOrganize") as! subFilterOrganize
            present(selectedVCOrganization, animated: true, completion: nil)
        default:
            print("hhhhh")
        }
    }
    
    
}


