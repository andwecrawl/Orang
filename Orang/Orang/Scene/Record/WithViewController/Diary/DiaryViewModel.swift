//
//  DiaryViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation

class DiaryViewModel {
    
    var title: Observable<String?> = Observable("")
    var content: Observable<String?> = Observable("")
//    var images = Observable()
    var isValid = Observable(false)
    
    func checkValidation(completionHandler: @escaping () -> ()) {
        completionHandler()
    }
}
