//
//  MedicalRecordTable.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import Foundation
import RealmSwift

class MedicalRecordTable: Object {
    
    @Persisted var createdDate: Date
    @Persisted var petId: ObjectId
    @Persisted var hospital: String
    @Persisted var treatmentDate: Date
    @Persisted var recordType: MedicalRecordType
    @Persisted var treatment: String?
    @Persisted var vaccineType: VaccineType
    @Persisted var vaccineName: String?
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
    
    @Persisted(originProperty: "medicalRecords") var owner: LinkingObjects<PetTable>
    
    convenience init(hospital: String, petId: ObjectId, treatmentDate: Date, recordType: MedicalRecordType, treatment: String? = nil, vaccineType: VaccineType, vaccineName: String?, content: String?, imageArray: [String]) {
        self.init()
        
        self.petId = petId
        self.createdDate = Date()
        self.hospital = hospital
        self.treatmentDate = treatmentDate
        self.recordType = recordType
        self.treatment = treatment
        self.vaccineType = vaccineType
        self.vaccineName = vaccineName
        self.content = content
        self.imageArray = imageArray
    }
    
    convenience init(hospital: String, petId: ObjectId, treatmentDate: Date, recordType: MedicalRecordType, treatment: String?, content: String?, imageArray: [String]) {
        self.init()
        
        self.petId = petId
        self.createdDate = Date()
        self.hospital = hospital
        self.treatmentDate = treatmentDate
        self.recordType = recordType
        self.treatment = treatment
        self.content = content
        self.imageArray = imageArray
    }
}