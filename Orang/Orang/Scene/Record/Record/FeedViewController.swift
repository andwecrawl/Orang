//
//  FeedViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class FeedViewController: BaseViewController {
    
    let segmentControl = {
        
    }
    let numberTextField = UnderLineTextField.textFieldBuilder(placeholder: "숫자만 적어 주세요!")
    let unitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: "g", handler: { _ in }),
        UIAction(title: "kg", handler: { _ in }),
        UIAction(title: "lb", handler: { _ in }),
        UIAction(title: "count".localized(), handler: { _ in })
    ])
    let numberStackView = UIStackView.stackViewBuilder()
    
    
    
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
            numberStackView
        ].forEach { view.addSubview($0) }
        
        numberStackView.AddArrangedSubviews([numberTextField, unitButton])
    }
    
    override func configureView() {
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func setConstraints() {
    }
}
