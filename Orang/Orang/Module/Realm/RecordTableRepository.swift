//
//  RecordTableRepository.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import Foundation
import RealmSwift

protocol RecordTableRepositoryType: AnyObject {
    func fetch() -> Results<RecordTable>
    func create(PetID: ObjectId, _ item: RecordTable)
    func delete(PetID: ObjectId, _ item: RecordTable)
    func update(PetID: ObjectId, _ item: RecordTable)
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
    
    func fetch() -> Results<RecordTable> {
        // 추후 종류별로 바꾸도록!!
        let data = realm.objects(RecordTable.self).sorted(byKeyPath: "createdDate", ascending: false)
        return data
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
