//
//  RecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/03.
//

import UIKit

final class RecordViewController: BaseViewController {
    
    
    let mainView = RecordView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "recordNavigationTitle".localized()
    }
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
       
        view.addSubview(mainView)
    }
    
    
    override func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    override func configureView() {
        mainView.medicalStackView.distribution = .fillEqually
        
        mainView.diaryButton.addTarget(self, action: #selector(diaryButtonClicked), for: .touchUpInside)
        mainView.firstRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        mainView.firstRecordButton.tag = 1
        mainView.secondRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        mainView.secondRecordButton.tag = 2
        mainView.thirdRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        mainView.thirdRecordButton.tag = 3
        mainView.fourthRecordButton.addTarget(self, action: #selector(recordButtonClicked), for: .touchUpInside)
        mainView.fourthRecordButton.tag = 4
        mainView.medicalVaccineButton.addTarget(self, action: #selector(medicalButtonClicked), for: .touchUpInside)
        mainView.medicalVaccineButton.tag = 100
        mainView.medicalHistoryButton.addTarget(self, action: #selector(medicalButtonClicked), for: .touchUpInside)
        mainView.medicalHistoryButton.tag = 101
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
}
