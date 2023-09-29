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
    var RegistrationNum: Int
}

enum Species: Int, PersistableEnum {
    case dog
    case cat
    case hamster
    case smallAnimal
    case reptile // 파충류
}
