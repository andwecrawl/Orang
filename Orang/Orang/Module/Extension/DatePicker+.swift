//
//  DatePicker+.swift
//  Orang
//
//  Created by yeoni on 2023/10/03.
//

import UIKit

extension UIDatePicker {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: self.date)
    }
}

