//
//  ToPicker.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit


protocol DataBackProtocolTwo {
    func dataBackTOPicker(dateTo: String)
}
protocol DateAfterSelecte {
    func dataBackTOPickerAfterSelecte(dateTo: String , idAfter: Int)

}
class ToPicker: UIViewController {

    @IBOutlet weak var toDatePicker: UIDatePicker!
    var selectedDate:Date?
    var dateString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        let _dataStr = dateFormatter.string(from: toDatePicker.date)
        return _dataStr
    }
    
    //current Date
    var currrentDate:String{
        let dateFormatter = DateFormatter()
        toDatePicker.date = Date()
//        fromPickerDate.timeZone = .none
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
//        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy-M-d"
        dateFormatter.locale = Locale.current

//        let currnt = dateFormatter.string(from: fromPickerDate.date)
        return dateFormatter.string(from: toDatePicker.date)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handelTap()

    }
    
    
    var DataBackDelegettwo:DataBackProtocolTwo?
    var DataAfterSelecte: DateAfterSelecte?

//    var completionHandlerToDate: ((String) -> String)?

    
    
    
    func handelTap() {
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    
    
    @IBAction func toPickerAction(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
    }
    
    
    @IBAction func chooseDateDone(_ sender: Any) {
        let dateForApitwo = dateString
        let currentdate = currrentDate
//        let datee = completionHandlerToDate?(dateForApi)
        print( "complation to date=============================== \(dateForApitwo)")
        print( "complation to date two =============================== \(currentdate)")
        DataBackDelegettwo?.dataBackTOPicker(dateTo: dateForApitwo)
        
        dismiss(animated: true, completion: nil)
    }
    
 

}
