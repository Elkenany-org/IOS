//
//  UITableView+Extensions.swift
//  Banoon
//
//  Created by bishoy on 26/11/2020.
//

import UIKit

extension UITableView {
    
    func registerNib<cell:UITableViewCell>(cell:cell.Type){
        let nibName = String(describing: cell)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
}


