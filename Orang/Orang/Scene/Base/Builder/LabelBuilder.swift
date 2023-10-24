//
//  LabelBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UILabel {
    static func labelBuilder(text: String = "", size: CGFloat, weight: UIFont.Weight, color: UIColor? = Design.Color.content, alignment: NSTextAlignment = .left, settingTitle: Bool = false) -> UILabel {
        let view = UILabel()
        if settingTitle {
            view.snp.makeConstraints { make in
                make.width.equalTo(60)
                make.height.equalTo(50)
            }
        }
        view.textAlignment = alignment
        switch weight {
        case .light:
            view.font = Design.Font.scdreamLight.getFonts(size: size)
        case .regular:
            view.font = Design.Font.scdreamRegular.getFonts(size: size)
        case .medium, .regular:
            view.font = Design.Font.scdreamMedium.getFonts(size: size)
        case .semibold, .bold:
            view.font = Design.Font.scdreamBold.getFonts(size: size)
        default: break
        }
        view.textColor = color
        view.text = text
        return view
    }
}

