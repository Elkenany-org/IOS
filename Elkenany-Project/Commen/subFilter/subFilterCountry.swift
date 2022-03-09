//
//  subFilterCountry.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD
class subFilterCountry: UIViewController {
    
    @IBOutlet weak var countryTV: UITableView!
    var countryModel :SubGuideFilter?
    var country_id = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        countryTV.delegate = self
        countryTV.dataSource = self
        countryTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
        GetFilterData()
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
    
    func GetFilterData(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        DispatchQueue.global(qos: .background).async {
            ///data not real
            let param = ["sector_id": "\(1)"]
            let subGuideFilterURL = "https://elkenany.com/api/guide/filter-guide-companies?sector_id="
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:SubGuideFilter?, filier:SubGuideFilter?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.countryModel = success
                    DispatchQueue.main.async {
                        self.countryTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
}

//MARK:- tableView Methodes
extension subFilterCountry:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryModel?.data?.countries?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = countryModel?.data?.countries?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let SectionVC = storyboard?.instantiateViewController(identifier: "subFilterCity") as? subFilterCity {
            let contryID = countryModel?.data?.countries?[indexPath.row].id ?? 0
            SectionVC.Con_ID_Param = contryID
            ///save data idooooooo
            UserDefaults.standard.set(contryID, forKey: "FILTER_COUN_ID")
            FilterAnimation.shared.filteranmation(vieww: view)

            self.present(SectionVC, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    
}
