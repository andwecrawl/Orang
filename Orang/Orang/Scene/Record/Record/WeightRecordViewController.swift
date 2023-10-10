//
//  WeightRecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class WeightRecordViewController: BaseViewController {
    
    let weightLabel = UILabel.labelBuilder(size: 14, weight: .semibold, settingTitle: true)
    let weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "숫자만 적어 주세요!")
    let weightUnitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: Unit.g.rawValue, handler: { _ in }),
        UIAction(title: Unit.kg.rawValue, handler: { _ in }),
        UIAction(title: Unit.lb.rawValue, handler: { _ in }),
    ])
    let weightStackView = UIStackView.stackViewBuilder()
    
    let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "날짜를 입력해 주세요!")
    let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "시간을 입력해 주세요!")
    let dateStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    
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
            weightStackView,
            dateStackView
        ]
            .forEach { view.addSubview($0) }
        
        weightStackView.AddArrangedSubviews([weightLabel, weightTextField, weightUnitButton])
        dateStackView.AddArrangedSubviews([dateTextField, timeTextField])
    }
    
    override func setConstraints() {
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
        weightStackView.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        [dateTextField, timeTextField, weightTextField].forEach { element in
            element.textAlignment = .center
            element.delegate = self
        }
        dateTextField.tag = 1
        timeTextField.tag = 2
        setupDatePicker(textField: dateTextField)
        setupDatePicker(textField: timeTextField)
    }
    
    
}

extension WeightRecordViewController {
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


extension WeightRecordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField || textField == timeTextField {
            return false
        } else if textField == weightTextField {
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
