//
//  reusableViewProtocol.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return self.description()
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return self.description()
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return self.description()
    }
}
