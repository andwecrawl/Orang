//
//  String+.swift
//  Orang
//
//  Created by yeoni on 2023/10/21.
//

import Foundation

// Date
extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.date(from: self)
    }
    
    func toDateContainsTime() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        
        return formatter.date(from: self)
    }
}
