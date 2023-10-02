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
    @Persisted var species: Species
    @Persisted var name: String
    @Persisted var birthday: String?
    @Persisted var belongDate: String
    @Persisted var weight: Float
    @Persisted var RegistrationNum: Int?
//    @Persisted var notes: 추후 만들 특이 사항 table!!
    
    convenience init(species: Species, name: String, birthday: String?, belongDate: String, weight: Float, RegistrationNum: Int?) {
        self.init()
        
        self.species = species
        self.name = name
        self.birthday = birthday
        self.belongDate = belongDate
        self.weight = weight
        self.RegistrationNum = RegistrationNum
    }
}
