//
//  Unit.swift
//  Orang
//
//  Created by yeoni on 2023/10/08.
//

import Foundation
import RealmSwift

enum Unit: String, PersistableEnum {
    case g, kg, lb, count
    
    var toString: String {
        switch self {
        case .g:
            return "g"
        case .kg:
            return "kg"
        case .lb:
            return "lb"
        case .count:
            return "count".localized()
        }
    }
}
