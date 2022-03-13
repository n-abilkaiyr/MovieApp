//
//  UICollectionView + Extension.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 16.02.2022.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
       guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
        fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
       }
        return cell
    }
}
