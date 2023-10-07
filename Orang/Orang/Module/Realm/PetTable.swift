//
//  PetTable.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import Foundation
import RealmSwift

// https://www.mongodb.com/docs/realm/sdk/swift/model-data/object-models/
class PetTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var createdDate: Date
    @Persisted var species: Species
    @Persisted var detailSpecies: String?
    @Persisted var name: String
    @Persisted var birthday: Date?
    @Persisted var belongDate: Date
    @Persisted var weight: Float
    @Persisted var registrationNum: String?
    @Persisted var profileImage: String
//    @Persisted var notes: 추후 만들 특이 사항 table!!
    
    convenience init(species: Species, detailSpecies: String?, name: String, birthday: Date?, belongDate: Date, weight: Float, RegistrationNum: String?) {
        self.init()
        
        self.createdDate = Date()
        self.species = species
        self.detailSpecies = detailSpecies
        self.name = name
        self.birthday = birthday
        self.belongDate = belongDate
        self.weight = weight
        self.registrationNum = RegistrationNum
        self.profileImage = "\(createdDate.toString())"
    }
    
    convenience init(pet: Pet) {
        self.init(species: pet.species, detailSpecies: pet.detailSpecies, name: pet.name, birthday: pet.birthday, belongDate: pet.belongDate, weight: pet.weight, RegistrationNum: pet.RegistrationNum)
    }
}
