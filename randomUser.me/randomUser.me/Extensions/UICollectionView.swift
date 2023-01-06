//
//  UICollectionView.swift
//  randomUser.me
//
//  Created by Maximilien Oteifeh--Pfennig on 25/09/2022.
//

import UIKit

extension UICollectionView {
    func registerCellFromClass(_ type: UICollectionViewCell.Type) {
        self.register(type, forCellWithReuseIdentifier: String(describing: type))
    }

    func dequeueReusable<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Couldn't instantiate cell with identifier \(T.self) because of a wrong type")
        }
        return cell
    }
}
