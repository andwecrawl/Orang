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
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
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
    
    func compareToNow() -> Int {
        
        let target = self.toFormattedString().toDate()
        let today = Date().toFormattedString().toDate()
        
        //interval 계산
        let calendar = Calendar.current
        
        if let target, let today {
            let dateGap = calendar.dateComponents([.day], from: target, to: today).day!
            
            return dateGap + 1
        } else {
            return 0 // TODO: d-day 계산 실패 -> alert 필요?
        }
    }
    
    func forLoadImage() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH/mm/ss"
        return formatter.string(from: self)
    }
}
