//
//  LabelBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UILabel {
    
    static func labelBuilder(size: CGFloat, weight: UIFont.Weight, color: UIColor = .black, alignment: NSTextAlignment = .left) -> UILabel {
        let view = UILabel()
        view.textAlignment = alignment
        view.font = .systemFont(ofSize: size, weight: weight)
        view.textColor = color
        return view
    }
}
