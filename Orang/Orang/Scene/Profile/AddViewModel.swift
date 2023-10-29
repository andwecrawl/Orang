//
//  AddViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

class AddViewModel {
    
    var species: Observable<Species?> = Observable(nil)
    var detailSpecies: Observable<String?> = Observable("")
    var name: Observable<String> = Observable("")
    var birthday: Observable<Date?> = Observable(nil)
    var belongDate: Observable<Date> = Observable(Date())
    var weight: Observable<String> = Observable("")
    var weightUnit: Observable<Unit> = Observable(.g)
    var registrationNum: Observable<String?> = Observable(nil)
