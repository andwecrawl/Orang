//
//  ProfileCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class ProfileCollectionViewCell: BaseCollectionViewCell {
    
    private let innerView = UIView()
    private let outerView = UIView()
    
    private let profileImageView = UIImageView.imageViewBuilder(size: 120)
    
    private let dateLabel = UILabel.labelBuilder(size: 13, weight: .light, color: .lightGray, alignment: .right, settingTitle: false)
    private let belongLabel = UILabel.labelBuilder(size: 16, weight: .medium, color: .black, alignment: .right, settingTitle: false)
    
    private let speciesSettingLabel = UILabel.labelBuilder(text: "speciesSetting".localized(),size: 15, weight: .medium, color: .black, alignment: .left, settingTitle: false)
    private let nameSettingLabel = UILabel.labelBuilder(text: "nameSetting".localized(), size: 15, weight: .medium, color: .black, alignment: .left, settingTitle: false)
    private let birthSettingLabel = UILabel.labelBuilder(text: "birthdaySetting".localized(), size: 15, weight: .medium, color: .black, alignment: .left, settingTitle: false)
    private let weightSettingLabel = UILabel.labelBuilder(text: "weightSetting".localized(), size: 15, weight: .medium, color: .black, alignment: .left, settingTitle: false)
    
    private let speciesLabel = UILabel.labelBuilder(size: 14, weight: .light, color: .black, settingTitle: false)
    private let nameLabel = UILabel.labelBuilder(size: 14, weight: .light, color: .black, settingTitle: false)
    private let birthLabel = UILabel.labelBuilder(size: 14, weight: .light, color: .black, settingTitle: false)
    private let weightLabel = UILabel.labelBuilder(size: 14, weight: .light, color: .black, settingTitle: false)
    
    private let speciesStackView = UIStackView.stackViewBuilder()
    private let nameStackView = UIStackView.stackViewBuilder()
    private let birthStackView = UIStackView.stackViewBuilder()
    private let weightStackView = UIStackView.stackViewBuilder()
    
    private let profileStackView = UIStackView.stackViewBuilder(space: 8)
    
    var pet: Pet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.text = "~에 만났어요!"
        belongLabel.text = "만난 지 120일"

        speciesSettingLabel.text = "종"
        nameSettingLabel.text = "이름"
        birthSettingLabel.text = "생일"
        weightSettingLabel.text = "몸무게"
    }
    
    
    override func configureHierarchy() {
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
                make.width.equalTo(65)
            }
        }
        [nameLabel, birthLabel, weightLabel, speciesLabel].forEach { $0.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .horizontal) }
        
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
    }
    
    override func setConstraints() {
        outerView.backgroundColor = .white
        outerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(outerView)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(innerView)
            make.leading.equalTo(innerView).inset(14)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(innerView).inset(22)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalTo(innerView).inset(16)
        }
        
        belongLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(dateLabel)
        }
        
        speciesStackView.snp.makeConstraints { make in
            make.top.equalTo(belongLabel.snp.bottom).offset(18)
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
        belongLabel.text = "만난 지 0000일"

        speciesLabel.text = "햄스터"
        nameLabel.text = "쩨라드 웨이"
        birthLabel.text = "2020.04.23"
        weightLabel.text = "88g"
    }
    
    override func configureView() {
        guard let pet else { return }
        dateLabel.text = "meetDate %@".localized(with: pet.belongDate.toFormattedString())
        belongLabel.text = "belongDate %d".localized(with: pet.belongDate.compareToNow())

        let image = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
        profileImageView.image = image
        let species = pet.species
        if species == .reptile || species == .etc {
            guard let detailSpecies = pet.detailSpecies else { return }
            speciesLabel.text = detailSpecies
        } else {
            speciesLabel.text = species.toString
        }
        nameLabel.text = pet.name
        if let birthday = pet.birthday {
            birthLabel.text = birthday.toDisplayString()
        } else {
            birthLabel.text = "idkBirthdayButton".localized()
        }
        weightLabel.text = "\(pet.weight)\(pet.weightUnit.rawValue)"
    }
}
