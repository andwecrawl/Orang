//
//  choosePetCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

class ChoosePetCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView.imageViewBuilder(size: 100)
    
    let nameLabel = UILabel.labelBuilder(size: 13, weight: .medium, settingTitle: false)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(imageView)
        self.addSubview(nameLabel)
    }
    
    override func setConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        imageView.layer.borderColor = Design.Color.border.cgColor
        imageView.layer.borderWidth = 5
        nameLabel.textAlignment = .center
    }
    
}
