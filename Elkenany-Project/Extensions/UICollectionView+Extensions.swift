//
//  UICollectionView+Extensions.swift
//  Banoon
//
//  Created by bishoy on 26/11/2020.
//

import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        //MARK: Generic Register cells
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderFooter<Cell: UICollectionReusableView>(cellClass: Cell.Type, kind: String){
        //MARK: Generic Register Header (Header/Footer)
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: Cell.self))
    }
    
    //    UICollectionView.elementKindSectionHeader
    
    func dequeueHeaderFooter<Cell: UICollectionReusableView>(kind: String, indexPath:IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }

}

extension UICollectionView {
    
    func registerNib<cell:UICollectionViewCell>(cell:cell.Type){
        let nibName = String(describing: cell)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func registerHeader<header:UICollectionReusableView>(header:header.Type){
        let nibName = String(describing: header)
        self.register(UINib(nibName: nibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: nibName)
    }
    
}

extension UICollectionViewFlowLayout{
    
//    open override var flipsHorizontallyInOppositeLayoutDirection: Bool{
//        return LocalizationManager.shared.getLanguage() == .Arabic ? true : false
//    }
    
}
