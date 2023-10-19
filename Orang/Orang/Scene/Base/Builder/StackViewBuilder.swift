//
//  StackViewBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UIStackView {
    static func stackViewBuilder(space: CGFloat = 10, axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        let view = UIStackView()
        view.axis = axis
        view.spacing = space
        view.distribution = .fillProportionally
        view.alignment = .leading
        return view
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
