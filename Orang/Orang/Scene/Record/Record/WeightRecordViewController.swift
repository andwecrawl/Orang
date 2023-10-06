//
//  WeightRecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class WeightRecordViewController: BaseViewController {
    
    let weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "숫자만 적어 주세요!")
    let weightUnitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: "g", handler: { _ in }),
        UIAction(title: "kg", handler: { _ in }),
        UIAction(title: "lb", handler: { _ in }),
    ])
    let weightStackView = UIStackView.stackViewBuilder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "몸무게 기록 추가하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        

    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            weightStackView
        ].forEach { view.addSubview($0) }
        
        weightStackView.AddArrangedSubviews([weightTextField, weightUnitButton])
    }
    
    override func configureView() {
        weightStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func setConstraints() {
    }
}
