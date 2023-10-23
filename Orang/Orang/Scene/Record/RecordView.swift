//
//  RecordView.swift
//  Orang
//
//  Created by yeoni on 2023/10/23.
//

import UIKit

final class RecordView: BaseView {
    
    let introduceLabel = UILabel.labelBuilder(text: "recordTitle".localized(),size: 19, weight: .bold, settingTitle: false)
    
    let diaryButton = UIButton.shadowButtonBuilder(title: "diaryRecordTitle".localized(), subtitle: "diaryRecordDetail".localized(), isBig: true)
    
    let recordView = {
        let innerView = UIView()
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let recordTitleLabel = UILabel.labelBuilder(text: "recordRecordTitle".localized(), size: 17, weight: .bold, settingTitle: false)
    let firstRecordButton = UIButton.recordButtonBuilder(image: RecordType.weight.image, title: "weightButton".localized())
    let secondRecordButton = UIButton.recordButtonBuilder(image: RecordType.snack.image, title: "snackButton".localized())
    let thirdRecordButton = UIButton.recordButtonBuilder(image: RecordType.pooPee.image, title: "fecesAndUrine".localized())
    let fourthRecordButton = UIButton.recordButtonBuilder(image: RecordType.abnormalSymptoms.image, title: "abnormalSymptoms".localized())
    let recordStackView = UIStackView.stackViewBuilder()
    
    let medicalView = {
        let innerView = UIView()
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    let medicalTitleLabel = UILabel.labelBuilder(text: "MedicalRecordTitle".localized(), size: 17, weight: .bold, settingTitle: false)
    let medicalVaccineButton = UIButton.shadowButtonBuilder(title: "VaccineRecordButton".localized(), subtitle: "VaccineRecordDetail".localized(), isBig: false)
    let medicalHistoryButton = UIButton.shadowButtonBuilder(title: "MedicalHistoryButton".localized(), subtitle: "MedicalHistoryDetail".localized(), isBig: false)
    let medicalStackView = UIStackView.stackViewBuilder(space: 12)
    
    
    override func configureHierarchy() {
        [
            introduceLabel,
            diaryButton,
            recordView,
            recordTitleLabel,
            recordStackView,
            medicalView,
            medicalTitleLabel,
            medicalStackView
        ]
            .forEach { self.addSubview($0) }
        
        recordStackView.addArrangedSubviews([firstRecordButton, secondRecordButton, thirdRecordButton, fourthRecordButton])
        medicalStackView.addArrangedSubviews([medicalVaccineButton, medicalHistoryButton])
    }
    
    override func setConstraints() {
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        diaryButton.backgroundColor = .white.withAlphaComponent(0.8)
        diaryButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.equalTo(introduceLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        recordView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(diaryButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        recordTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(recordView).inset(16)
            make.horizontalEdges.equalTo(recordView).inset(26)
        }
        
        recordStackView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.top.equalTo(recordTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(recordView).inset(20)
        }
        
        medicalView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(recordView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
        medicalTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(medicalView).inset(16)
            make.horizontalEdges.equalTo(medicalView).inset(26)
        }
        
        medicalStackView.snp.makeConstraints { make in
            make.top.equalTo(medicalTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(medicalView).inset(20)
            make.bottom.equalTo(medicalView).inset(26)
        }
    }
    
    
    
    
}
