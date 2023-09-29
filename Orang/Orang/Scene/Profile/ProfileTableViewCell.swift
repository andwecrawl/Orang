//
//  ProfileTableViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let innerView = UIView()
    let outerView = UIView()
    
    let profileImageView = UIImageView.imageViewBuilder(size: 130)
    
    let dateLabel = UILabel.labelBuilder(size: 13, weight: .light, color: .lightGray, alignment: .right)
    let belongLabel = UILabel.labelBuilder(size: 16, weight: .bold, alignment: .right)
    
    let speciesSettingLabel = UILabel.labelBuilder(size: 15, weight: .semibold, alignment: .left)
    let nameSettingLabel = UILabel.labelBuilder(size: 15, weight: .semibold, alignment: .left)
    let birthSettingLabel = UILabel.labelBuilder(size: 15, weight: .semibold, alignment: .left)
    let weightSettingLabel = UILabel.labelBuilder(size: 15, weight: .semibold, alignment: .left)
    
    let speciesLabel = UILabel.labelBuilder(size: 15, weight: .light)
    let nameLabel = UILabel.labelBuilder(size: 15, weight: .light)
    let birthLabel = UILabel.labelBuilder(size: 15, weight: .light)
    let weightLabel = UILabel.labelBuilder(size: 15, weight: .light)
    
    let speciesStackView = UIStackView.stackViewBuilder()
    let nameStackView = UIStackView.stackViewBuilder()
    let birthStackView = UIStackView.stackViewBuilder()
    let weightStackView = UIStackView.stackViewBuilder()
    
    let profileStackView = UIStackView.stackViewBuilder(space: 8)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = "~에 만났어요!"
        belongLabel.text = "만난 지 120일"

        speciesSettingLabel.text = "종"
        nameSettingLabel.text = "이름"
        birthSettingLabel.text = "생일"
        weightSettingLabel.text = "몸무게"
    }
    
    
    override func configureView() {
        self.addSubview(outerView)
        outerView.addSubview(innerView)
        innerView.addSubview(profileImageView)
        profileImageView.backgroundColor = .gray
        
        [dateLabel, belongLabel].forEach { innerView.addSubview($0) }
        
        [speciesSettingLabel, speciesLabel].forEach { speciesStackView.addArrangedSubview($0) }
        [nameSettingLabel, nameLabel].forEach { nameStackView.addArrangedSubview($0) }
        [birthSettingLabel, birthLabel].forEach { birthStackView.addArrangedSubview($0) }
        [weightSettingLabel, weightLabel].forEach { weightStackView.addArrangedSubview($0) }

        [speciesStackView, nameStackView, birthStackView, weightStackView].forEach {
            innerView.addSubview($0)
        }
        
        // hugging, compression Setting
        [nameSettingLabel, birthSettingLabel, weightSettingLabel, speciesSettingLabel].forEach {
            $0.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
            $0.snp.makeConstraints { make in
                make.width.equalTo(50)
            }
        }
        [nameLabel, birthLabel, weightLabel, speciesLabel].forEach { $0.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .horizontal) }
        
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
    }
    
    override func setConstraints() {
        outerView.backgroundColor = .white
        outerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(outerView)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(innerView)
            make.leading.equalTo(innerView).inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(innerView).inset(22)
            make.trailing.equalTo(innerView).inset(16)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        belongLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.horizontalEdges.equalTo(dateLabel)
        }
        
        speciesStackView.snp.makeConstraints { make in
            make.top.equalTo(belongLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(belongLabel)
        }

        nameStackView.snp.makeConstraints { make in
            make.top.equalTo(speciesStackView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(belongLabel)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.top.equalTo(nameStackView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(belongLabel)
        }
        weightStackView.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(belongLabel)
        }
        
        dateLabel.text = "~에 만났어요!"
        belongLabel.text = "만난 지 120일"

        speciesSettingLabel.text = "종"
        speciesLabel.text = "햄스터ㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ"
        nameSettingLabel.text = "이름"
        nameLabel.text = "쩨라드 웨이"
        birthSettingLabel.text = "생일"
        birthLabel.text = "2020.04.23"
        weightSettingLabel.text = "몸무게"
        weightLabel.text = "88g"
    }
    
}
