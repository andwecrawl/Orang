//
//  ViewAppearance.swift
//  Orang
//
//  Created by yeoni on 2023/09/29.
//

import UIKit

extension UIView {
    
    static func shadowViewBuilder(innerView: UIView) -> UIView {
        let outerView = UIView()
        outerView.addSubview(innerView)
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(outerView)
        }
        outerView.backgroundColor = Design.Color.buttonBackground
        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 8
        outerView.layer.shadowOpacity = 0.1
        return outerView
    }
    
    static func addOuterShadowAndRadius(outerView: UIView, innerView: UIView) {
        // 그림자랑 cornerRadius 수정
        innerView.layer.cornerRadius = 15
        innerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOffset = .zero
        outerView.layer.shadowRadius = 8
        outerView.layer.shadowOpacity = 0.1
    }
    
    func addAboveTheBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
}
