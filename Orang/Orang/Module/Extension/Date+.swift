//
//  Date+.swift
//  Orang
//
//  Created by yeoni on 2023/10/07.
//

import Foundation

extension Date {
    func toFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: self)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: self)
    }
    
    func compareNow() -> ComparisonResult {
        let date = Date()
        return self.compare(date)
    }
}
