//
//  RadiusButtonCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

final class RadiusButtonCollectionViewCell: BaseCollectionViewCell {
    
    lazy var button = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderColor = Design.Color.border.cgColor
        button.layer.borderWidth = 1
        button.isSelected = false
        button.setImage(UIImage(systemName: "checkmark"), for: .selected)
        return button
    }()
    
    override func configureHierarchy() {
        self.addSubview(button)
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

