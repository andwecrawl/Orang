//
//  Species.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import Foundation
import RealmSwift
import UIKit

enum Species: Int, PersistableEnum, CaseIterable {
    case dog
    case cat
    case hamster
    case rat
    case hedgehog
    case rabbit
    case reptile
    case etc
    
    var rawString: String {
        return String(describing: self)
    }
    
    var toString: String {
        return String(describing: self).localized()
    }
    
    var image: UIImage {
        if let image = UIImage(named: self.rawString) {
            return image.withTintColor(Design.Color.background, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 80, height: 80))
        } else {
            return UIImage(systemName: "pawprint")!.withTintColor(Design.Color.background, renderingMode: .alwaysTemplate).resized(to: CGSize(width: 80, height: 80))
        }
    }
}


