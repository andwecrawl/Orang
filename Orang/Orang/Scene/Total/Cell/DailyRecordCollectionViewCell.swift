//
//  DiaryCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/19.
//

import UIKit

class DailyRecordCollectionViewCell: BaseCollectionViewCell {
    
    let profileImageView = UIImageView.imageViewBuilder(tintColor: Design.Color.tintColor, size: 50)
    let nameLabel = UILabel.labelBuilder(text: "이름이들어가용", size: 16, weight: .semibold, alignment: .left)
    
    
    
    override func configureHierarchy() {
        [
            profileImageView,
            nameLabel
        ]
            .forEach{ self.addSubview($0) }
        
    }
    
    override func setConstraints() {
        
    }
    
    override func configureView() {
        profileImageView.layer.borderWidth = 3
    }
    
}
