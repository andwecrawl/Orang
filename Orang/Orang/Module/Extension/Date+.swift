//
//  Date+.swift
//  Orang
//
//  Created by yeoni on 2023/10/07.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: self)
    }
    
    func compareDate(date: Date = Date()) -> ComparisonResult {
        // Ascending: 이전
        // Descending: 이후
        return self.compare(date)
    }
}
