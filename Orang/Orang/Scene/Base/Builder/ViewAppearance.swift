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
        outerView.backgroundColor = .white.withAlphaComponent(0.8)
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
    
    func addInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = self.layer.cornerRadius
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy:2), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 0.5
        innerShadow.shadowRadius = 2
        innerShadow.cornerRadius = self.layer.cornerRadius
        layer.addSublayer(innerShadow)
        
    }
}
