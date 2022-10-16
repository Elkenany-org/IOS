//
//  subFilterSection.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD

class subFilterSection: UIViewController {
    
    @IBOutlet weak var SectionPopupTV: UITableView!
    var subGuideFilter:SubGuideFilter?
    var secId = UserDefaults.standard.value(forKey: "FILTER_SEC_ID") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GetFilterSection()

        
    }
    
    fileprivate func setupUI() {
        SectionPopupTV.delegate = self
        SectionPopupTV.dataSource = self
        SectionPopupTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
    }
    
    
    fileprivate func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func GetFilterSection(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            ///data not real
            let param = ["sector_id": "\(self.secId)"]
            let subGuideFilterURL = "https://admin.elkenany.com/api/guide/filter-guide-companies?sector_id="
            print("============== request \(param)")
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:SubGuideFilter?, filier:SubGuideFilter?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.subGuideFilter = success
                    DispatchQueue.main.async {
                        self.SectionPopupTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
}
//MARK:- tableView Methodes
extension subFilterSection:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subGuideFilter?.data?.sectors?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = subGuideFilter?.data?.subSections?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let subId = subGuideFilter?.data?.subSections?[indexPath.row].id ?? 0
        ///save the data of filter 
        UserDefaults.standard.set(subId, forKey: "FILTER_SUB_ID")
        FilterAnimation.shared.filteranmation(vieww: view)

        dismiss(animated: true, completion: nil)
        
    }
    
    
}



