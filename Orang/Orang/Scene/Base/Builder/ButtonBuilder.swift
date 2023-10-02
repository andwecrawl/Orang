//
//  ButtonBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/10/01.
//

import UIKit

extension UIButton {
    static func buttonBuilder(image: UIImage?, title: String, font: UIFont) -> UIButton {
        let view = UIButton()
        view.titleLabel?.font = font
        view.setTitle(title, for: .normal)
        view.setImage(image, for: .normal)
        return view
    }
    
    static func profileButtonBuilder(size: CGFloat) -> UIButton {
        let view = UIButton()
        view.snp.makeConstraints { make in
            make.height.equalTo(size)
            make.width.equalTo(size)
        }
        view.layer.cornerRadius = size / 2
        return view
    }
}

