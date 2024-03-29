//
//  ImageViewBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UIImageView {
    static func imageViewBuilder(tintColor: UIColor? = .gray, size: CGFloat) -> UIImageView {
        let view = UIImageView()
        view.tintColor = tintColor
        view.contentMode = .scaleAspectFill
        view.snp.makeConstraints { make in
            make.height.equalTo(size)
            make.width.equalTo(size)
        }
        view.clipsToBounds = true
        view.layer.cornerRadius = size / 2
        return view
    }
}
