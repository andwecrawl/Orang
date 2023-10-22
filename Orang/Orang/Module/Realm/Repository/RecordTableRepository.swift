//
//  RecordTableRepository.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import Foundation
import RealmSwift

protocol RecordTableRepositoryType: AnyObject {
//    func fetchRecords<T: Object>(date: Date, type: myRecords, objectType: T.Type)
    func create(PetID: ObjectId, _ item: RecordTable)
    func delete(PetID: ObjectId, _ item: RecordTable)
    func update(PetID: ObjectId, _ item: RecordTable)
}

enum myRecords {
    case diary, daily, medical
}

class RecordTableRepository: RecordTableRepositoryType {
    
    private let realm = try! Realm()

    func create(PetID: ObjectId, _ item: RecordTable) {
        do {
            try realm.write {
                let pet = PetTable()
                pet._id = PetID
                pet.records.append(item)
                realm.add(pet)
            }
        } catch {
            print("save error: ", error)
        }
    }
    
    func fetchRecords<T: Object>(date: Date, type: myRecords, objectType: T.Type) -> Results<T> {
        let data: Results<T> = realm.objects(T.self)
        let today = Calendar.current.startOfDay(for: date)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        let filteredData: Results<T>
        
        if type == .diary {
            filteredData = data.filter("recordDate >= %@ AND recordDate < %@ AND recordType == %@", today, tomorrow, RecordType.diary.rawValue).sorted(byKeyPath: "createdDate", ascending: false)
        } else if type == .daily {
            filteredData = data.filter("recordDate >= %@ AND recordDate < %@ AND recordType != %@", today, tomorrow, RecordType.diary.rawValue).sorted(byKeyPath: "createdDate", ascending: false)
        } else { // medical
            filteredData = data.filter("treatmentDate >= %@ AND treatmentDate < %@", today, tomorrow)
        }
        
        return filteredData
    }
    
    func fetchMedicalRecord(date: Date, type: MedicalRecordType) -> Results<MedicalRecordTable> {
        let data = realm.objects(MedicalRecordTable.self)
        let today = Calendar.current.startOfDay(for: date)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        if type == .treatmentRecord {
            let product = data.filter("recordDate >= %@ AND recordDate < %@", today, tomorrow).where({ $0.recordType == .medicalHistory }).sorted(byKeyPath: "createdDate", ascending: false)
            return product
        } else {
            let product = data.filter("recordDate >= %@ AND recordDate < %@", today, tomorrow).where({ $0.recordType == .vaccine }).sorted(byKeyPath: "createdDate", ascending: false)
            return product
        }
    }
    
    func delete(PetID: ObjectId, _ item: RecordTable) {
        let task = realm.objects(RecordTable.self)
        guard let product = task.where({ $0.createdDate == item.createdDate }).first else { return }
        do {
            try realm.write {
                realm.delete(product)
            }
        } catch {

        }
    }
    
    func update(PetID id: RealmSwift.ObjectId, _ item: RecordTable) {
//        let updateValue: [String: Any] = [
//            "_id": id,
//            "species": item.species,
//            "detailSpecies": item.detailSpecies,
//            "name": item.name,
//            "birthday": item.birthday,
//            "belongDate": item.belongDate,
//            "weight": item.weight,
//            "weightUnit": item.weightUnit,
//            "registrationNum": item.registrationNum,
//            "profileImage": item.profileImage,
//        ]
//        do {
//            try realm.write {
//                realm.create(DiaryTable.self, value: updateValue, update: .modified)
//            }
//        } catch {
//            print("update Error: \(error)")
//        }
    }
    
    
    func loadFileURL() {
        print(realm.configuration.fileURL)
    }
}
