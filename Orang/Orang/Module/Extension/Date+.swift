//
//  Date+.swift
//  Orang
//
//  Created by yeoni on 2023/10/07.
//

import Foundation

extension Date {
    
    var startDateOfMonth: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) else {
            fatalError("Unable to get start date from date")
        }
        return date
    }

    var endDateOfMonth: Date {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDateOfMonth) else {
            fatalError("Unable to get end date from date")
        }
        return date
    }

    var startOfTheDate: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var nextDayOfTheDate: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfTheDate)!
    }
    
    func toCalendarTitle() -> String {
        let formatter = DateFormatter()
        if Locale.current == Locale(identifier: "ko_KR") {
            formatter.dateFormat = "yyyy년 MM월"
            return formatter.string(from: self)
        } else {
            formatter.dateFormat = "MMMM d, yyyy"
            return formatter.string(from: self)
        }
    }
    
    func toFormattedString() -> String {
        let formatter = DateFormatter()
        if Locale.current == Locale(identifier: "ko_KR") {
            formatter.dateFormat = "yyyy년 MM월 dd일"
            return formatter.string(from: self)
        } else {
            formatter.dateFormat = "MMMM d, yyyy"
            return formatter.string(from: self)
        }
    }
    
    func toFormattedStringTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시 mm분"
        
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
