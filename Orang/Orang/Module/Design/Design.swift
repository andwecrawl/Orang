//
//  ColorSet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class Design {
    enum image {
        static let poo = "poo"
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
