//
//  AddViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

class AddViewModel {
    
    let repository = PetTableRepository()
    
    var species: Observable<Species?> = Observable(nil)
    var detailSpecies: Observable<String?> = Observable("")
    var name: Observable<String> = Observable("")
    var birthday: Observable<Date?> = Observable(nil)
    var belongDate: Observable<Date> = Observable(Date())
    var weight: Observable<String> = Observable("")
    var weightUnit: Observable<Unit> = Observable(.g)
    var registrationNum: Observable<String?> = Observable(nil)
    
    private var haveSpecies = false
    private var hasName = false
    private var hasValidBirthday = false
    private var hasValidBelongDate = false
    private var hasWeight = false
    private var validUnit = false
    private var canRegistrate = false
    private var canSave = false
    
    func checkValidations() {
    func savePetData() {
        
    }
    
    var registrationStackisHidden: Bool {
        if species.value == .cat || species.value == .dog {
            return false
        } else {
            return true
        }
    }
    
    var detailSectionIsHidden: Bool {
        if species.value == .reptile || species.value == .etc {
            return false
        } else {
            return true
        }
    }
}
