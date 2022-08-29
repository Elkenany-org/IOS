//
//  SectorDetailsTable.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 12/7/21.
//

import UIKit

class SectorDetailsTable: UIViewController {
    
    //outlets and variables
    @IBOutlet weak var SectorDetailsTabel: UITableView!
    var titleFromCell = ""
    var sectorFtomHome = ""
    var titleeeee = ""
    var tabelData:[UIImage] = [#imageLiteral(resourceName: "new-banner5") , #imageLiteral(resourceName: "new-banner7") , #imageLiteral(resourceName: "new-banner1") , #imageLiteral(resourceName: "new-banner3")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title =  titleeeee
    }
    
    
    //configuer cell
    func setupUI() {
        SectorDetailsTabel.dataSource = self
        SectorDetailsTabel.delegate = self
        SectorDetailsTabel.register(UINib(nibName: "SectorDetailsCell", bundle: nil), forCellReuseIdentifier: "SectorDetailsCell")
    }
    
}


//MARK:- tableView methods of sectors sections

extension SectorDetailsTable:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabelData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectorDetailsCell") as! SectorDetailsCell
        cell.tableImage.image = tabelData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
        switch indexPath.row {
        case 0:
            let BorsaVC = (storyboard?.instantiateViewController(identifier: "BorsaHomeVC"))! as BorsaHomeVC
            BorsaVC.Sector = sectorFtomHome
            navigationController?.pushViewController(BorsaVC, animated: true)
            
        case 1:
            let GuideVC = (storyboard?.instantiateViewController(identifier: "CompanyGuideVC"))! as CompanyGuideVC
            GuideVC.sectoreTypeFromHome = sectorFtomHome
            navigationController?.pushViewController(GuideVC, animated: true)
            
        case 2:
            let GuideVC = (storyboard?.instantiateViewController(identifier: "MainStoreVC"))! as MainStoreVC
            GuideVC.typeFromHomeForStore = sectorFtomHome
            navigationController?.pushViewController(GuideVC, animated: true)
            
        case 3:
            let newsVC = (storyboard?.instantiateViewController(identifier: "NewsVC"))! as NewsVC
            newsVC.typeFromhome = sectorFtomHome
            navigationController?.pushViewController(newsVC, animated: true)
            print("hello world")
            
        default:
            print("hello world")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
