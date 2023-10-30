//
//  DiaryViewModel.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import Foundation
import RealmSwift

class DiaryViewModel {
    
    let repository = PetTableRepository()
    
    var title: Observable<String?> = Observable("")
    var content: Observable<String?> = Observable("")
    var imageCount: Observable<Int> = Observable(0)
    var record: RecordTable?
    
    var add: Int {
        return imageCount.value >= 5 ? 0 : 1
    }
    
    var images: Int {
        return imageCount.value < 6 ? imageCount.value : 5
    }
    
    var numberOfItems: Int {
        let add = imageCount.value >= 5 ? 0 : 1
        let images = imageCount.value < 6 ? imageCount.value : 5
        return add + images
    }
    
    func checkValidation(petID: ObjectId, titleHandler: @escaping (String) -> (), imageHandler: @escaping (String) -> ()) -> Date? {
        guard let title = title.value else {
            titleHandler("noTitleError".localized())
            return nil
        }
        
        if title.isEmpty {
            titleHandler("noTitleError".localized())
            return nil
        }
        
        if imageCount.value <= 0 {
            imageHandler("noImageError".localized())
        }
        
        let content = content.value
        let date = Date()
        
        let record = RecordTable(recordType: .diary, petID: petID, recordDate: date, title: title, content: content, images: [])
        self.record = record
        return record.createdDate
    }
    
    func saveData(images: [String]) {
        if let record {
            record.imageArray = images
            repository.updateRecords(id: record.petId, record)
        }
    }
}
