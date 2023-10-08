//
//  String+.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import Foundation

// Date
extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.date(from: self)
    }
}


// Localization
extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    // 이거모지?
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), argument)
    }
}

/*
 ~ 사용 예시 ~
 myLabel.text = "Hello".localized()
 myLabel.text = "My Age %d".localized(with: 26, comment: "age")
 */
