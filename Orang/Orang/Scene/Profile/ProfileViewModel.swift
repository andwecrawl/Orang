//
//  ProfileViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

class ProfileViewModel {
    
    var petList: Observable<[Pet]> = Observable([])
    let repository = PetTableRepository()
    
    func fetchPet() {
        petList.value = repository.fetch().map({ Pet($0) })
    }
    
    var numberOfItems: Int {
        return petList.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Pet {
        return petList.value[indexPath.row]
    }
    
    func deletePet(at indexPath: IndexPath) {
        let item = indexPath.item
        let pet = petList.value[item]
        ImageManager.shared.removeImageFromDirectory(directoryName: .profile, identifier: pet.profileImage)
        repository.delete(pet)
        petList.value.remove(at: item)
    }
}
