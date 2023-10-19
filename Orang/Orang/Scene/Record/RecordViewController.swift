//
//  RecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/03.
//

import UIKit

final class RecordViewController: BaseViewController {
    
    let introduceLabel = UILabel.labelBuilder(text: "recordTitle".localized(),size: 19, weight: .bold, settingTitle: false)
    
    let diaryButton = UIButton.shadowButtonBuilder(title: "diaryRecordTitle".localized(), subtitle: "diaryRecordDetail".localized(), isBig: true)
    
    let recordView = {
        let innerView = UIView()
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let recordTitleLabel = UILabel.labelBuilder(text: "recordRecordTitle".localized(), size: 17, weight: .bold, settingTitle: false)
    let firstRecordButton = UIButton.recordButtonBuilder(image:  "lizard.fill", title: "weightButton".localized())
    let secondRecordButton = UIButton.recordButtonBuilder(image: "lizard.fill", title: "snackButton".localized())
    let thirdRecordButton = UIButton.recordButtonBuilder(image:  "lizard.fill", title: "fecesAndUrine".localized())
    let fourthRecordButton = UIButton.recordButtonBuilder(image: "lizard.fill", title: "abnormalSymptoms".localized())
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "recordNavigationTitle".localized()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
       
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
            .forEach { view.addSubview($0) }
        
        recordStackView.addArrangedSubviews([firstRecordButton, secondRecordButton, thirdRecordButton, fourthRecordButton])
        medicalStackView.addArrangedSubviews([medicalVaccineButton, medicalHistoryButton])
    }
    
    override func configureView() {
        medicalStackView.distribution = .fillEqually
        
        diaryButton.addTarget(self, action: #selector(diaryButtonClicked), for: .touchUpInside)
        firstRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        firstRecordButton.tag = 1
        secondRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        secondRecordButton.tag = 2
        thirdRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        thirdRecordButton.tag = 3
        fourthRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        fourthRecordButton.tag = 4
        medicalVaccineButton.addTarget(self, action: #selector(medicalButtonClicked), for: .touchUpInside)
        medicalVaccineButton.tag = 100
        medicalHistoryButton.addTarget(self, action: #selector(medicalButtonClicked), for: .touchUpInside)
        medicalHistoryButton.tag = 101
    }
    
    @objc func diaryButtonClicked() {
        let vc = WithViewController()
        vc.recordType = .diary
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func recordButtonClicked(_ sender: UIButton) {
        let vc = WithViewController()
        switch sender.tag {
        case 1:
            vc.recordType = .weight
        case 2:
            vc.recordType = .snack
        case 3:
            vc.recordType = .pooPee
        case 4:
            vc.recordType = .abnormalSymptoms
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func medicalButtonClicked(_ sender: UIButton) {
        let vc = WithViewController()
        if sender.tag == 100 { // medicalVaccineButton
            vc.recordType = .vaccine
        } else if sender.tag == 101 { // medicalHistoryButton
            vc.recordType = .medicalHistory
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func setConstraints() {
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        diaryButton.backgroundColor = .white.withAlphaComponent(0.8)
        diaryButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.equalTo(introduceLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        recordView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(diaryButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
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
