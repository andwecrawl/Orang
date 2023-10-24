//
//  TextViewBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/10/11.
//

import UIKit

extension UITextView {
    static func TextViewBuilder() -> UITextView {
        let view = UITextView()
        view.layer.cornerRadius = 16
        view.layer.borderColor = Design.Color.border.cgColor
        view.font = Design.Font.scdreamMedium.midFont
        view.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        view.layer.borderWidth = 1
        view.backgroundColor = Design.Color.background
        view.tintColor = Design.Color.tintColor
        return view
    }
}
