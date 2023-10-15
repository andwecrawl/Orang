//
//  Poo.swift
//  Orang
//
//  Created by yeoni on 2023/10/14.
//

import UIKit
import RealmSwift

enum PooColor: String, CheckProtocol, PersistableEnum {
    case brown
    case black
    case red
    case orange
    case gray
    case yellow
    case green
    case dotted
    case none
    
    var color: UIColor {
        switch self {
        case .brown:
            return .systemBrown
        case .black:
            return .black
        case .red:
            return .systemRed
        case .orange:
            return .systemOrange
        case .gray:
            return .systemGray
        case .yellow:
            return .systemYellow
        case .green:
            return .systemGreen
        case .dotted:
            return .white
        case .none:
            return .white
        }
    }
    
    var title: String {
        return "\(self.rawValue)TitlePoo".localized()
    }
    var subtitle: String {
        return "\(self.rawValue)Poo".localized()
    }
}


enum PooForm: String, CheckProtocol, PersistableEnum {
    case normal, hard, mud, water, mucus // 점액
    
    var title: String {
        return "\(self.rawValue)TitlePoo".localized()
    }
    var subtitle: String {
        return "\(self.rawValue)Poo".localized()
    }
}
