//
//  Extensions.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 17/02/2024.
//

import UIKit

//MARK: - Nib

protocol NibProvidable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibProvidable {
    static var nibName: String {
        return "\(self)"
    }
    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }
}

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

//MARK: - Cell

extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(cellClass `class`: T.Type) where T: ReusableView {
        register(`class`, forCellWithReuseIdentifier: `class`.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(cellClass `class`: T.Type) where T: NibProvidable & ReusableView {
        register(`class`.nib, forCellWithReuseIdentifier: `class`.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass `class`: T.Type, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: `class`.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Error: cell with identifier: \(`class`.reuseIdentifier) for index path: \(indexPath) is not \(T.self)")
        }
        return cell
    }
}
