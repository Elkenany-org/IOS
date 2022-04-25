//
//  shortCutFilter.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 4/25/22.
//

import UIKit

class shortCutFilter: UIViewController {

    @IBOutlet weak var shortCutTV: UITableView!
    var array = ["الاكثر تداولا", "الرسايل", "الموبيل", "كلاهما"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    fileprivate func setupUI() {
        shortCutTV.delegate = self
        shortCutTV.dataSource = self
        shortCutTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    

}

extension shortCutFilter:UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
//        cell.SectreTitle.text = homeDataFilter?.data?.sectors?[indexPath.row].name ?? ""
//        let tyyype = homeDataFilter?.data?.sectors?[indexPath.row].type ?? ""
//        let selecteddd = homeDataFilter?.data?.sectors?[indexPath.row].selected ?? 0
        cell.SectreTitle.text = array[indexPath.row]
        
        if indexPath.row == 0 {
            cell.imageSelected.image = #imageLiteral(resourceName: "check")

        }

//        if  selecteddd == 1{
//            cell.imageSelected.image = #imageLiteral(resourceName: "check")
//        }else{
//            
//            cell.imageSelected.image = #imageLiteral(resourceName: "square")
//
//        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell

                FilterAnimation.shared.filteranmation(vieww: view)
            cell.imageSelected.image = #imageLiteral(resourceName: "check")

        dismiss(animated: true, completion: nil)

    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
//        let selecteddd = homeDataFilter?.data?.sectors?[indexPath.row].selected ?? 0
//
//        let typeeee = homeDataFilter?.data?.sectors?[indexPath.row].type ?? ""
//        if  selecteddd == 1{
//            cell.imageSelected.image = #imageLiteral(resourceName: "check")
//        }else{
//            
//            cell.imageSelected.image = #imageLiteral(resourceName: "square")
//
//        }
//        self.typppppe = typeeee
//
//        let ID_FOR_SEC = homeDataFilter?.data?.sectors?[indexPath.row].id ?? 0
//        UserDefaults.standard.set(ID_FOR_SEC, forKey: "ID_FILTER")
//        UserDefaults.standard.set(typeeee, forKey: "TYPE_FOR_FILTER")
////        if typppppe == typeeee {
////            cell.imageSelected.image = #imageLiteral(resourceName: "check")
//////            cell.selectItem(at: indexPath, animated: true, scrollPosition: .right)
////        } else {
////            cell.imageSelected.image = #imageLiteral(resourceName: "square")
////
////        }
//        
////        if(cell.isSelected == true)
////        {
////            cell.imageSelected.image = #imageLiteral(resourceName: "check")
////        }
//        print("foooooooooor", UserDefaults.standard.string(forKey: "TYPE_FOR_FILTER" ) ?? "")
//        //        TypeDeleget?.sectorBack(typeBack: typee)
//        //        TypeDeleget.self = (typeeee as! SectoreDataBacke)
////        cell.imageSelected.image  = #imageLiteral(resourceName: "check")
//        FilterAnimation.shared.filteranmation(vieww: view)
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
//        let typeeee = homeDataFilter?.data?.sectors?[indexPath.row].type ?? ""
////        if typppppe == typeeee {
////            cell.imageSelected.image = #imageLiteral(resourceName: "check")
//////            cell.selectItem(at: indexPath, animated: true, scrollPosition: .right)
////        } else {
////            cell.imageSelected.image = #imageLiteral(resourceName: "square")
////
////        }
//        if(cell.isSelected == false)
//        {
//            cell.imageSelected.image = #imageLiteral(resourceName: "square")
//            
//        }
//        
//    }
//    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
