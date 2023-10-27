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
    var imageCount: Observable<Int> = Observable(0)
    var isValid = Observable(false)
    
    var numberOfItems: Int {
        let add = imageCount.value >= 5 ? 0 : 1
        let images = imageCount.value < 6 ? imageCount.value : 5
        return add + images
    }
    
    func checkValidation(completionHandler: @escaping () -> ()) {
        completionHandler()
    }
}
