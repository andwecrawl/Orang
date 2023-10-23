//
//  AddView.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import UIKit

final class AddView: BaseView {
    
    lazy var profileImageView = UIImageView.imageViewBuilder(size: 130)
    lazy var profileImageButton = UIButton.profileButtonBuilder(size: 130)
    
    private lazy var speciesLabel = UILabel.labelBuilder(text: "speciesSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var speciesTextField = UnderLineTextField.textFieldBuilder(placeholder: "chooseSpecies".localized())
    private lazy var speciesStackView = UIStackView.stackViewBuilder()
    
    private lazy var detailSpeciesLabel = UILabel.labelBuilder(text: "  ", size: 16, weight: .bold, settingTitle: true)
    lazy var detailSpeciesTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDetailSpecies".localized())
    lazy var detailStackView = UIStackView.stackViewBuilder()
    private lazy var totalSpeciesStackView = UIStackView.stackViewBuilder(space: 2, axis: .vertical)
    
    private lazy var nameLabel = UILabel.labelBuilder(text: "nameSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var nameTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputName".localized())
    private lazy var nameStackView = UIStackView.stackViewBuilder()
    
    private lazy var birthLabel = UILabel.labelBuilder(text: "birthdaySetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var birthTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputBirthday".localized())
    lazy var birthStackView = UIStackView.stackViewBuilder()
    lazy var idkBirthButton = UIButton.idkButtonBuilder(title: "idkBirthdayButton".localized())
    
    private lazy var meetDateLabel = UILabel.labelBuilder(text: "meetDateSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var meetDateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputMeetDate".localized())
    private lazy var meetDateStackView = UIStackView.stackViewBuilder()
    
    private lazy var weightLabel = UILabel.labelBuilder(text: "weightSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputWeight".localized())
    lazy var weightStackView = UIStackView.stackViewBuilder()
    lazy var weightUnitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: "g", handler: { _ in }),
        UIAction(title: "kg", handler: { _ in }),
        UIAction(title: "lb", handler: { _ in })
    ])
    
    private lazy var registrationLabel = UILabel.labelBuilder(text: "registrationNumber".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var registrationTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputRegistrationNumber".localized())
    lazy var registrationStackView = UIStackView.stackViewBuilder()
    lazy var idkRegistrationButton = UIButton.idkButtonBuilder(title: "idkRegistrationNumber".localized())
    
    
    override func configureHierarchy() {
        [
            profileImageView,
            profileImageButton,
            totalSpeciesStackView,
            nameStackView,
            birthStackView,
            idkBirthButton,
            meetDateStackView,
            weightStackView,
            registrationStackView,
            idkRegistrationButton
        ]
            .forEach { self.addSubview($0) }
        
        speciesStackView.addArrangedSubviews([speciesLabel, speciesTextField])
        detailStackView.addArrangedSubviews([detailSpeciesLabel, detailSpeciesTextField])
        totalSpeciesStackView.addArrangedSubviews([speciesStackView, detailStackView])
        nameStackView.addArrangedSubviews([nameLabel, nameTextField])
        birthStackView.addArrangedSubviews([birthLabel, birthTextField])
        meetDateStackView.addArrangedSubviews([meetDateLabel, meetDateTextField])
        weightStackView.addArrangedSubviews([weightLabel, weightTextField, weightUnitButton])
        registrationStackView.addArrangedSubviews([registrationLabel, registrationTextField])
    }
    
    override func setConstraints() {
        profileImageView.backgroundColor = .gray
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.centerX.equalTo(profileImageView)
        }
        
        speciesStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(totalSpeciesStackView.snp.top)
            make.height.equalTo(50)
        }
        
        totalSpeciesStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(totalSpeciesStackView.snp.bottom).offset(7)
            make.height.equalTo(50)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nameStackView.snp.bottom).offset(7)
            make.height.equalTo(50)
        }
        
        idkBirthButton.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).inset(7)
            make.leading.equalTo(birthLabel.snp.trailing)
            make.trailing.equalTo(birthTextField.snp.trailing)
        }
        
        meetDateStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(idkBirthButton.snp.bottom).offset(6)
            make.height.equalTo(50)
        }
        
        weightStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(meetDateStackView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(weightStackView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        idkRegistrationButton.snp.makeConstraints { make in
            make.top.equalTo(registrationStackView.snp.bottom).inset(8)
            make.leading.equalTo(registrationLabel.snp.trailing)
            make.trailing.equalTo(registrationTextField.snp.trailing)
        }
    }
}
