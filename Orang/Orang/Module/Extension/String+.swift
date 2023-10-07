//
//  String+.swift
//  Orang
//
//  Created by yeoni on 2023/10/07.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.date(from: self)
    }
}

