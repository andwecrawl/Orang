//
//  Record.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

struct Record {
    var createdDate: Date
    var petId: ObjectId
    var recordDate: Date
    var recordType: RecordType
    var weight: Float?
    var weightUnit: Unit?
    var snackSpecies: String?
    var snackAmount: Int?
    var pooColor: PooColor?
    var pooForm: PooForm?
    var peeColor: PeeColor?
    var abnormalSymptoms: [AbnormalSymptomsType]?
    var pukeColor: pukeColor?
    var title: String?
    var content: String?
    var imageList: [String]?
    
    init(_ record: RecordTable) {
        self.createdDate = record.createdDate
        self.petId = record.petId
        self.recordDate = record.recordDate
        self.recordType = record.recordType
        self.weight = record.weight
        self.weightUnit = record.weightUnit
        self.snackSpecies = record.snackSpecies
        self.snackAmount = record.snackAmount
        self.pooColor = record.pooColor
        self.pooForm = record.pooForm
        self.peeColor = record.peeColor
        self.abnormalSymptoms = record.abnormalSymptomsArray
        self.pukeColor = record.pukeColor
        self.title = record.title
        self.content = record.content
        self.imageList = record.imageArray
    }
}
