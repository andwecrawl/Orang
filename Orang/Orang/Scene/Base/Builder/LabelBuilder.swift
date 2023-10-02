//
//  LabelBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UILabel {
    static func labelBuilder(text: String = "", size: CGFloat, weight: UIFont.Weight, color: UIColor? = Design.Color.content, alignment: NSTextAlignment = .left) -> UILabel {
        let view = UILabel()
        view.textAlignment = alignment
        view.font = .systemFont(ofSize: size, weight: weight)
        view.textColor = color
        view.text = text
        return view
    }
}

