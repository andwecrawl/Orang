//
//  ColorSet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class Design {
    enum image {
        // 자잘한 이미지들
        static let poo = "poo"
        
        static let diary = "lizard.fill"
        static let weight = "lizard.fill"
        static let snack = "lizard.fill"
        static let peePoo = "lizard.fill"
        static let abnormalSymptoms = "lizard.fill"
        static let vaccine = "lizard.fill"
        static let medicalHistory = "lizard.fill"
        
        static let totalVC = ""
        static let alertVC = ""
        static let recordVC = ""
        static let profileVC = ""
    }
    
    enum Color {
        static let background = UIColor(named: "background")
        static let border = UIColor.systemGray
        static let halfGray = UIColor.systemGray4.withAlphaComponent(0.8)
        static let todaysColor = UIColor.systemGray.withAlphaComponent(0.4)
        static let content = UIColor(named: "contentColor")
        static let tintColor = UIColor(named: "tintColor")
        static let buttonBackground = UIColor(named: "buttonBackground")
    }
}
