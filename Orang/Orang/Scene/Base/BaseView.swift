//
//  BaseView.swift
//  Orang
//
//  Created by yeoni on 2023/10/19.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func configureHierarchy() {
    }
    
    func setConstraints() {
    }
}
