//
//  Species.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import Foundation
import RealmSwift

enum Species: Int, PersistableEnum, CaseIterable {
    case dog
    case cat
    case hamster
    case rat
    case hedgehog
    case rabbit
    case reptile
    case etc
    
    var toString: String {
        return String(describing: self).localized()
    }
}


