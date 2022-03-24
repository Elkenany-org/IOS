//
//  FromPicker.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 1/5/22.
//

import UIKit

//1
protocol DataBackProtocol {
    func dataBackFromPicker(dateFrom: String)

}


class FromPicker: UIViewController {

    @IBOutlet weak var fromPickerDate: UIDatePicker!
    var selectedDate:Date?
    var dateString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        let _dataStr = dateFormatter.string(from: fromPickerDate.date)
        return _dataStr
    }
    
    //current Date
    var currrentDate:String{
        let dateFormatter = DateFormatter()
        fromPickerDate.date = Date()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-M-d"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: fromPickerDate.date)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        handelTap()
    }
    
    
    //2
    var DataBackDeleget:DataBackProtocol?
    var HelloWorld:statisticsInsideMain?

    
    


    func handelTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePop))
        view.addGestureRecognizer(tap)
    }

    
    @objc func closePop(){
        dismiss(animated: true)
    }
    
    @IBAction func fromActio(_ sender: UIDatePicker) {
        self.selectedDate = sender.date
    }
    
    
    
    @IBAction func ChooseDateDone(_ sender: Any) {
        let dateForApi = dateString
//        let currentDat = Date.tomorrow
        DataBackDeleget?.dataBackFromPicker(dateFrom: dateForApi)
//        UserDefaults.standard.set(dateForApi, forKey: "DATE_FROM")
        dismiss(animated: true, completion: nil)
    }
    
    
    

}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
