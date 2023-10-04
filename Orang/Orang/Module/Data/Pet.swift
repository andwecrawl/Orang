//
//  Pet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import Foundation
import RealmSwift

struct Pet {
    var species: Species
    var name: String
    var birthday: String
    var belongDate: String
    var weight: Float
    var RegistrationNum: Int?
    var imageIdentifier: String
}

enum Species: Int, PersistableEnum, CaseIterable {
    case dog
    case cat
    case hamster
    case hedgehog
    case rabbit
    case reptile
    case etc
    
    var toString: String {
        return String(describing: self).localized()
    }
}
