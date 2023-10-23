//
//  Pet.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

struct Pet {
    var _id: ObjectId
    var createdDate: Date
    var species: Species
    var detailSpecies: String?
    var name: String
    var birthday: Date?
    var belongDate: Date
    var weight: Float
    var weightUnit: Unit
    var registrationNum: String?
    var profileImage: String
    
    var records: [Record]
    var medicalRecords: [MedicalRecord]
    
    init(_ pet: PetTable) {
        self._id = pet._id
        self.createdDate = pet.createdDate
        self.species = pet.species
        self.detailSpecies = pet.detailSpecies
        self.name = pet.name
        self.birthday = pet.birthday
        self.belongDate = pet.belongDate
        self.weight = pet.weight
        self.weightUnit = pet.weightUnit
        self.registrationNum = pet.registrationNum
        self.profileImage = pet.profileImage
        self.records = pet.records.map({ Record($0) })
        self.medicalRecords = pet.medicalRecords.map({ MedicalRecord($0) })
    }
}
