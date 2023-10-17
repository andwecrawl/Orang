//
//  RecordTable.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import Foundation
import RealmSwift

class RecordTable: Object {
    @Persisted var createdDate: Date
    @Persisted var petId: ObjectId
    @Persisted var recordDate: Date
    @Persisted var recordType: RecordType
    @Persisted var weight: Float?
    @Persisted var weightUnit: Unit?
    @Persisted var snackSpecies: String?
    @Persisted var snackAmount: Int?
    @Persisted var pooColor: PooColor?
    @Persisted var pooForm: PooForm?
    @Persisted var peeColor: PeeColor?
    @Persisted var abnormalSymptoms: List<AbnormalSymptomsType> = List<AbnormalSymptomsType>()
    @Persisted var pukeColor: pukeColor?
    @Persisted var title: String?
    @Persisted var content: String?
    @Persisted var imageList: List<String> = List<String>()
    
    var imageArray: [String] {
        get {
            return imageList.map{$0}
        }
        set {
            imageList.removeAll()
            imageList.append(objectsIn: newValue)
        }
    }
    
    var abnormalSymptomsArray: [AbnormalSymptomsType] {
        get {
            return abnormalSymptoms.map{$0}
        }
        set {
            abnormalSymptoms.removeAll()
            abnormalSymptoms.append(objectsIn: newValue)
        }
    }
    
    @Persisted(originProperty: "records") var owner: LinkingObjects<PetTable>
    
    convenience init(createdDate: Date, petID: ObjectId, recordDate: Date, recordType: RecordType, weight: Float? = nil, weightUnit: Unit? = nil, snackSpecies: String? = nil, snackAmount: Int? = nil, pooColor: PooColor? = nil, pooForm: PooForm? = nil, peeColor: PeeColor? = nil, abnormalSymptoms: [AbnormalSymptomsType] = [], pukeColor: pukeColor? = nil, title: String? = nil, content: String? = nil, imageList: [String] = []) {
        self.init()
        self.createdDate = Date()
        self.petId = petID
        self.recordDate = recordDate
        self.recordType = recordType
        self.weight = weight
        self.weightUnit = weightUnit
        self.snackSpecies = snackSpecies
        self.snackAmount = snackAmount
        self.pooColor = pooColor
        self.pooForm = pooForm
        self.peeColor = peeColor
        self.abnormalSymptomsArray = abnormalSymptoms
        self.pukeColor = pukeColor
        self.title = title
        self.content = content
        self.imageArray = imageList
    }
    
    
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, title: String, content: String?, images: [String]) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.title = title
        self.content = content
        self.imageArray = images
    }
    
    // weight
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, weight: Float, weightUnit: Unit) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.weight = weight
        self.weightUnit = weightUnit
    }
    
    // snack
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, snackSpecies: String, snackAmount: Int) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.snackSpecies = snackSpecies
        self.snackAmount = snackAmount
    }
    
    
    // pee
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, peeColor: PeeColor, content: String?, images: [String]) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.peeColor = peeColor
        self.content = content
        self.imageArray = images
    }
    
    // poo
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, pooColor: PooColor, pooForm: PooForm?, content: String?, images: [String]) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.pooColor = pooColor
        self.pooForm = pooForm
        self.content = content
        self.imageArray = images
    }
    
    // abnormalSymptoms
    convenience init(recordType: RecordType, petID: ObjectId, recordDate: Date, abnormalSymptoms: [AbnormalSymptomsType], content: String?, images: [String]) {
        self.init()
        
        self.recordType = recordType
        self.petId = petID
        self.recordDate = recordDate
        self.abnormalSymptomsArray = abnormalSymptoms
        self.content = content
        self.imageArray = images
    }
}

