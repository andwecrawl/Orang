//
//  ColorSet.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class Design {
    enum Color {
        static let background = UIColor(named: "background")
        static let border = UIColor.systemGray6
        static let button = UIColor.systemGray
        static let content = UIColor(named: "contentColor") ?? .black
        static let placeholder = UIColor.systemGray
        static let point = UIColor.systemRed
    }
}
