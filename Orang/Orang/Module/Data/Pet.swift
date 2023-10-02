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

enum Species: String, PersistableEnum {
    case dog = "강아지"
    case cat = "고양이"
    case hamster = "햄스터"
    case hedgehog = "고슴도치"
    case rabbit = "토끼"
    case reptile = "파충류"
    case etc = "기타"
}
