//
//  MedicalRecord.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

struct MedicalRecord {
    var createdDate: Date
    var petId: ObjectId
    var hospital: String
    var treatmentDate: Date
    var recordType: RecordType
    var treatment: String?
    var vaccineType: [String]
    var content: String?
    var imageList: [String]?
    
    init(_ medicalRecord: MedicalRecordTable) {
        self.createdDate = medicalRecord.createdDate
        self.petId = medicalRecord.petId
        self.hospital = medicalRecord.hospital
        self.treatmentDate = medicalRecord.treatmentDate
        self.recordType = medicalRecord.recordType
        self.treatment = medicalRecord.treatment
        self.vaccineType = medicalRecord.vaccineTypeArray
        self.content = medicalRecord.content
        self.imageList = medicalRecord.imageArray
    }
}
