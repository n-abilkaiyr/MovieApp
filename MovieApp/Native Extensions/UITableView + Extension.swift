//
//  UITableView + Extension.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 16.02.2022.
//
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withType: T.Type, for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
