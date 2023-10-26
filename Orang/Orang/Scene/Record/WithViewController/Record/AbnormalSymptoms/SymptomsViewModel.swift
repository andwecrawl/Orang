//
//  SymptomsViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/26.
//

import Foundation

class SymptomsViewModel {
    
    var list: Observable<[CheckRecord<AbnormalSymptomsType>]> = Observable([])
    
    func fetchSymptoms() {
        AbnormalSymptomsType.allCases.forEach{ self.list.value.append(CheckRecord(type: $0)) }
    }
    
    func checkValidations(completionHandler: (([AbnormalSymptomsType]?) -> ())) {
        var selectedSymptoms: [AbnormalSymptomsType] = []
        list.value.forEach {
            if $0.ischecked {
                selectedSymptoms.append($0.type)
            }
        }
        
        completionHandler(selectedSymptoms)
    }
    
    var numberOfRows: Int {
        return list.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> CheckRecord<AbnormalSymptomsType> {
        return list.value[indexPath.row]
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        list.value[indexPath.row].ischecked.toggle()
    }
    
}
