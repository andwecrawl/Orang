//
//  PooViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class PooViewController: BaseViewController {
    
    let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    let dateStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    
    var selectedPet: [PetTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "pooPeeTitle".localized()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        

    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            dateStackView
        ]
            .forEach { view.addSubview($0) }
        
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
    }
    
    override func configureView() {
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func setConstraints() {
    }
}
