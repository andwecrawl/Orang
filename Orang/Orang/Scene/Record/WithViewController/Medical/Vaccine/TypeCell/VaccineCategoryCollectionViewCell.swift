//
//  VaccineCategoryCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/16.
//

import UIKit

class VaccineCategoryCollectionViewCell: BaseCollectionViewCell {
    
    let deleteButton = UIButton.pictureButtonBuilder(image: "xmark", imageSize: 10, radius: 10)
    
    let vaccineTypeTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종 항목을 선택해 주세요.".localized(), textAlignment: .center)
    let vaccineButton = UIButton()
    
    let inputVaccineTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종한 백신을 입력해 주세요!", textAlignment: .center)
    let noVaccineButton = UIButton.idkButtonBuilder(title: "접종한 백신이 표에 없어요.")
    
    
    var delegate: VaccineProtocol?
    
    
    override func configureHierarchy() {
        [
            vaccineTypeTextField,
            vaccineButton,
            inputVaccineTextField,
            noVaccineButton,
            deleteButton
        ]
            .forEach{ self.addSubview($0) }
        
        vaccineButton.addTarget(self, action: #selector(vaccineButtonClicked), for: .touchUpInside)
        noVaccineButton.addTarget(self, action: #selector(noVaccineButtonClicked), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        inputVaccineTextField.isHidden = true
    }
    
    @objc func deleteButtonClicked() {
        delegate?.deleteButtonHandler()
    }
    
    @objc func noVaccineButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            [vaccineTypeTextField, vaccineButton].forEach { element in
                element.isHidden = true
            }
            inputVaccineTextField.isHidden = false
            inputVaccineTextField.isEnabled = true
        } else {
            [vaccineTypeTextField, vaccineButton].forEach { element in
                element.isHidden = false
            }
            inputVaccineTextField.isHidden = true
            inputVaccineTextField.isEnabled = false
        }
    }
    
    @objc func vaccineButtonClicked() {
        let vc = VaccineTypeViewController()
        vc.modalPresentationStyle = .formSheet
        vc.completionHandler = { (title, variation) in
            self.vaccineTypeTextField.text = "\(variation) - \(title)"
        }
        delegate?.presentVaccineVC(vc: vc)
    }
    
    override func setConstraints() {
        
        
        vaccineTypeTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
        }
        
        vaccineButton.snp.makeConstraints { make in
            make.edges.equalTo(vaccineTypeTextField).inset(4)
        }
        
        inputVaccineTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
        }
        
        noVaccineButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(4)
            make.width.equalTo(20)
        }
    }
    
    
    override func configureView() {
    }
    
}
