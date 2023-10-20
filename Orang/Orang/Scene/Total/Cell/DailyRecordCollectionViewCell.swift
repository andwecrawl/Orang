//
//  DiaryCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/19.
//

import UIKit

class DailyRecordCollectionViewCell: BaseCollectionViewCell {
    
    var cornerRadius: CGFloat = 16
    
    let outerView = UIView()
    
    let profileImageView = UIImageView.imageViewBuilder(tintColor: Design.Color.tintColor, size: 60)
    let nameLabel = UILabel.labelBuilder(text: "쩨라드 웨이", size: 14, weight: .semibold, alignment: .left)
    
    let buttonStackView = UIStackView.stackViewBuilder(space: 4, axis: .horizontal)
    
    
    override func configureHierarchy() {
        self.addSubview(outerView)
        
        [
            profileImageView,
            nameLabel
        ]
            .forEach{ self.addSubview($0) }
        
    }
    
    override func setConstraints() {
//        outerView.backgroundColor = .gray
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
        
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.7
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(profileImageView.snp.bottom)
//            make.leading.equalTo(profileImageView)
//            make.trailing.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(4)
//        }
//
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(outerView.snp.top).offset(20)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        
//        profileImageView.layer.borderWidth = 1
//        profileImageView.layer.borderColor = Design.Color.halfGray.cgColor
        profileImageView.backgroundColor = .gray
        
        makeShadowAndRadius()

    }
    
    func makeShadowAndRadius() {
        outerView.layer.cornerRadius = cornerRadius
        outerView.layer.masksToBounds = true

        // Apply a shadow
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16
        ).cgPath
    }
    
}
