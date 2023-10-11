//
//  FeedViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class FeedViewController: BaseViewController {
    
    let typeLabel = UILabel.labelBuilder(text: "snackVariation".localized(), size: 16, weight: .bold, settingTitle: true)
    let typeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputSnackType".localized())
    let typeStackView = UIStackView.stackViewBuilder()
    
    let numberLabel = UILabel.labelBuilder(text: "amount".localized(),size: 16, weight: .semibold, settingTitle: true)
    let numberTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputNumber".localized())
    let unitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: Unit.g.rawValue, handler: { _ in }),
        UIAction(title: Unit.kg.rawValue, handler: { _ in }),
        UIAction(title: Unit.lb.rawValue, handler: { _ in }),
        UIAction(title: "count".localized(), handler: { _ in })
    ])
    let numberStackView = UIStackView.stackViewBuilder()
    
    let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    let dateStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "snackTitle".localized()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        
        
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            numberStackView,
            typeStackView,
            dateStackView
        ]
            .forEach { view.addSubview($0) }
        
        typeStackView.AddArrangedSubviews([typeLabel, typeTextField])
        numberStackView.AddArrangedSubviews([numberLabel, numberTextField, unitButton])
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
    }
    
    override func setConstraints() {
        
        typeStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        numberStackView.snp.makeConstraints { make in
            make.top.equalTo(typeTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(numberStackView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        [dateTextField, timeTextField, typeTextField, numberTextField].forEach { element in
            element.textAlignment = .center
            element.delegate = self
        }
        dateTextField.tag = 1
        timeTextField.tag = 2
        setupDatePicker(textField: dateTextField)
        setupDatePicker(textField: timeTextField)
    }
    
    
}

extension FeedViewController {
    func setupDatePicker(textField: UITextField) {
        // 여기서 datePicker를 weak로 써줘야 하나?
        let datePicker = UIDatePicker()
        datePicker.tag = textField.tag
        
        // 원하는 언어로 지역 설정
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        textField.inputView = datePicker
        if textField == dateTextField {
            datePicker.preferredDatePickerStyle = .inline
            datePicker.datePickerMode = .date
            dateTextField.text = datePicker.date.toFormattedString()
        } else {
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels
            timeTextField.text = datePicker.date.toFormattedStringTime()
        }
    }
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        if sender.tag == 1 {
            //            birth = sender.date
            dateTextField.text = sender.date.toFormattedString()
            
        } else {
            //            meetDate = sender.date
            timeTextField.text = sender.date.toFormattedStringTime()
        }
    }
}


extension FeedViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField || textField == timeTextField {
            return false
        } else if textField == numberTextField {
            let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
            let withDecimal = (
                string == NumberFormatter().decimalSeparator &&
                textField.text?.contains(string) == false
            )
            return isNumber || withDecimal
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
