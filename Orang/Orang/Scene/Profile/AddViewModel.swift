//
//  AddViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//


/*
 var components = DateComponents()
 components.calendar = calendar

 // datePicker max 날짜 세팅 -> 오늘 날짜 에서
 //
 components.year = -1
 components.month = 12
 let maxDate = calendar.date(byAdding: components, to: currentDate)!

 // datePicker min 날짜 세팅 -> 30년 전 까지
 //
 components.year = -31
 let minDate = calendar.date(byAdding: components, to: currentDate)!

 datePicker.minimumDate = minDate
 datePicker.maximumDate = maxDate
 */


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
    
    private var haveSpecies = false
    private var hasName = false
    private var hasValidBirthday = false
    private var hasValidBelongDate = false
    private var hasWeight = false
    private var validUnit = false
    private var canRegistrate = false
    
    func checkValidations() {
        
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
