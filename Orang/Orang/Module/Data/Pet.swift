//
//  Pet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import Foundation

struct Pet {
    var species: Species
    var detailSpecies: String?
    var name: String
    var birthday: Date?
    var belongDate: Date
    var weight: Float
    var RegistrationNum: Int?
    var imageIdentifier: String {
        return "\(species.toString)_\(name)_\(belongDate)"
    }
}
