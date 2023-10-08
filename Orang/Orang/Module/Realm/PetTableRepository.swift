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
    func update(id: ObjectId, _ item: PetTable)
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
        let task = realm.objects(PetTable.self)
        guard let product = task.where({ $0._id == item._id }).first else { return }
        do {
            try realm.write {
                realm.delete(product)
            }
        } catch {
            
        }
    }
    
    func update(id: RealmSwift.ObjectId, _ item: PetTable) {
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
    
    
    func loadFileURL() {
        print(realm.configuration.fileURL)
    }
}
