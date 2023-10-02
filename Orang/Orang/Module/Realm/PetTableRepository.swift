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
        let data = realm.objects(PetTable.self).sorted(byKeyPath: "date", ascending: false)
        return data
    }
    
    func delete(_ item: PetTable) {
        let task = realm.objects(PetTable.self)
//        guard let product = task.where { $0.productID == item.productID }.first else { return }
        do {
            try realm.write {
//                realm.delete(product)
            }
        } catch {
            
        }
    }
    
    func loadFileURL() {
        print(realm.configuration.fileURL)
    }
}
