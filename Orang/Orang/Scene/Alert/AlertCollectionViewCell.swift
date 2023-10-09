//
//  AlertCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

class AlertCollectionViewCell: BaseCollectionViewCell {
    
    private let shadowButton = UIButton.shadowButtonBuilder(title: "", subtitle: "", isBig: false)
    
    
    override func configureHierarchy() {
        self.addSubview(shadowButton)
    }
    
    override func setConstraints() {
        shadowButton.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}
