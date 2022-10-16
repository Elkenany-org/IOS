//
//  subFilterCity.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/25/22.
//

import UIKit
import JGProgressHUD

class subFilterCity: UIViewController {
    
    
    @IBOutlet weak var cityTV: UITableView!
    var Con_ID_Param = UserDefaults.standard.value(forKey: "FILTER_COUN_ID") ?? ""
    var cityModel:SubGuideFilter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTV.delegate = self
        cityTV.dataSource = self
        cityTV.register(UINib(nibName: "SelectedCell", bundle: nil), forCellReuseIdentifier: "SelectedCell")
        GetTheCityByCountry()
        
    }
    
    fileprivate func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    @IBAction func dissmis(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func GetTheCityByCountry(){
        //Handeling Loading view progress
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "جاري التحميل"
        hud.show(in: self.view)
        
        DispatchQueue.global(qos: .background).async {
            ///data not real
            let param = ["sector_id": "\(1)", "country_id": "\(self.Con_ID_Param)"]
            let subGuideFilterURL = "https://admin.elkenany.com/api/guide/filter-guide-companies?country_id=&sector_id="
            print("============== request \(param)")
            APIServiceForQueryParameter.shared.fetchData(url: subGuideFilterURL, parameters: param, headers: nil, method: .get) { (success:SubGuideFilter?, filier:SubGuideFilter?, error) in
                if let error = error{
                    hud.dismiss()
                    print("============ error \(error)")
                }else {
                    hud.dismiss()
                    guard let success = success else {return}
                    self.cityModel = success
                    DispatchQueue.main.async {
                        self.cityTV.reloadData()
                        
                    }
                }
            }
        }
    }
    
    
    
    
}

//MARK:- tableView Methodes
extension subFilterCity:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityModel?.data?.cities?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell") as! SelectedCell
        cell.SectreTitle.text = cityModel?.data?.cities?[indexPath.row].name ?? ""
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city_Id = cityModel?.data?.cities?[indexPath.row].id ?? 0
        UserDefaults.standard.set(city_Id, forKey: "FILTER_CITY_ID")
        FilterAnimation.shared.filteranmation(vieww: view)

        dismiss(animated: true, completion: nil)
        
    }
}
