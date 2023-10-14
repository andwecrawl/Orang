//
//  Pee.swift
//  Orang
//
//  Created by yeoni on 2023/10/14.
//

import UIKit
import RealmSwift

enum PeeColor: String, CheckProtocol, PersistableEnum {
    case yellow, lightYellow, orange, brown, red, tooMuch, crystal, none
    
    var color: UIColor {
        switch self {
        case .orange:
            return .systemOrange
        case .yellow:
            return .systemYellow
        case .brown:
            return .systemBrown
        case .lightYellow:
            return .systemYellow.withAlphaComponent(0.3)
        case .red:
            return .systemRed
        case .tooMuch:
            return .white
        case .crystal:
            return .white
        case .none:
            return .white
        }
    }
    
    var title: String {
        return "\(self.rawValue)Title".localized()
    }
    var subtitle: String {
        return self.rawValue.localized()
    }
}
