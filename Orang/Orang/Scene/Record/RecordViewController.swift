//
//  RecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/03.
//

import UIKit

class RecordViewController: BaseViewController {
    
    let introduceLabel = UILabel.labelBuilder(text: "매일 기록하고 변화를 관찰해 보세요!",size: 19, weight: .bold, settingTitle: false)
    
    let diaryButton = UIButton.shadowButtonBuilder(title: "일상 기록 추가하기", subtitle: " 아이와 함께한 기록을 추가해 보세요!", isBig: true)
    
    let recordView = UIView.shadowViewBuilder()
    let recordTitleLabel = UILabel.labelBuilder(text: "생활 기록 추가하기", size: 17, weight: .bold, settingTitle: false)
    let firstRecordButton = UIButton.recordButtonBuilder(image:  "lizard.fill", title: "몸무게")
    let secondRecordButton = UIButton.recordButtonBuilder(image: "lizard.fill", title: "사료/간식")
    let thirdRecordButton = UIButton.recordButtonBuilder(image:  "lizard.fill", title: "대소변")
    let fourthRecordButton = UIButton.recordButtonBuilder(image: "lizard.fill", title: "이상 증상")
    let recordStackView = UIStackView.stackViewBuilder()
    
    let medicalView = UIView.shadowViewBuilder()
    let medicalTitleLabel = UILabel.labelBuilder(text: "진료 기록 추가하기", size: 17, weight: .bold, settingTitle: false)
    let medicalVaccineButton = UIButton.shadowButtonBuilder(title: "예방 접종 내역", subtitle: "예방 접종 내역을 기록할 수 있어요!", isBig: false)
    let medicalHistoryButton = UIButton.shadowButtonBuilder(title: "진료 내역", subtitle: "아이의 진료 내역을 기록할 수 있어요!", isBig: false)
    let medicalStackView = UIStackView.stackViewBuilder(space: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "기록하기"
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
        
        recordStackView.AddArrangedSubviews([firstRecordButton, secondRecordButton, thirdRecordButton, fourthRecordButton])
        medicalStackView.AddArrangedSubviews([medicalVaccineButton, medicalHistoryButton])
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
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func recordButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let vc = WeightRecordViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = FeedViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PooViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = AbnormalSymptomsViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    @objc func medicalButtonClicked(_ sender: UIButton) {
        if sender.tag == 100 { // medicalVaccineButton
            print("\(sender.titleLabel?.text)")
        } else if sender.tag == 101 { // medicalHistoryButton
            print("\(sender.titleLabel?.text)")
        }
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
