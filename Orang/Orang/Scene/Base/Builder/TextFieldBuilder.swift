//
//  TextFieldBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit
import TextFieldEffects

class HSTextField: HoshiTextField {
    static func makeText(placeholder: String) -> HSTextField {
        let textField = HSTextField(frame: .zero)
        textField.placeholderColor = .darkGray
        textField.placeholderLabel.text = placeholder
        return textField
    }
}
