//
//  PetTableRepository.swift
//  Orang
//
//  Created by yeoni on 2023/10/02.
//

import Foundation
import RealmSwift

protocol PetTableRepositoryType: AnyObject {
    func fetch() -> Results<PetTable>
    func create(_ item: PetTable)
    func delete(_ item: PetTable)
    func updatePet(id: ObjectId, _ item: PetTable)
}

class PetTableRepository: PetTableRepositoryType {
    
    private let realm = try! Realm()
    
    func create(_ item: PetTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("save error: ", error)
        }
    }
    
    func fetch() -> Results<PetTable> {
        let data = realm.objects(PetTable.self).sorted(byKeyPath: "createdDate", ascending: false)
        return data
    }
    
    func delete(_ item: PetTable) {
        let pet = realm.objects(PetTable.self)
        let records = realm.objects(RecordTable.self).where({ $0.petId == item._id })
        let medicalRecords = realm.objects(MedicalRecordTable.self).where({ $0.petId == item._id })
        
        guard let product = pet.where({ $0._id == item._id }).first else { return }
        do {
            try realm.write {
                realm.delete(records)
                realm.delete(medicalRecords)
                realm.delete(product)
            }
        } catch {
            
        }
    }
    
    func updatePet(id: RealmSwift.ObjectId, _ item: PetTable) {
        let updateValue: [String: Any] = [
            "_id": id,
            "species": item.species,
            "detailSpecies": item.detailSpecies,
            "name": item.name,
            "birthday": item.birthday,
            "belongDate": item.belongDate,
            "weight": item.weight,
            "weightUnit": item.weightUnit,
            "registrationNum": item.registrationNum,
            "profileImage": item.profileImage,
        ]
        do {
            try realm.write {
                realm.create(PetTable.self, value: updateValue, update: .modified)
            }
        } catch {
            print("update Error: \(error)")
        }
    }
    
    func updateRecords(id: RealmSwift.ObjectId, _ item: RecordTable) {
        guard let pet = realm.object(ofType: PetTable.self, forPrimaryKey: id) else {
            print("Pet \(id) not found")
            return
        }
        try! realm.write {
            pet.records.append(item)
            print("Updated: \(pet)")
        }
    }
    
    func updateMedicalRecords(id: RealmSwift.ObjectId, _ item: MedicalRecordTable) {
        guard let pet = realm.object(ofType: PetTable.self, forPrimaryKey: id) else {
            print("Pet \(id) not found")
            return
        }
        try! realm.write {
            pet.medicalRecords.append(item)
            print("Updated: \(pet)")
        }
    }
    
    
    func loadFileURL() {
        print(realm.configuration.fileURL)
    }
}
