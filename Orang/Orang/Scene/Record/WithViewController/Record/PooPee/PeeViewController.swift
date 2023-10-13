//
//  PeeViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

final class PeeViewController: BaseViewController {
    
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
        
        let saveButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
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
    
    override func setConstraints() {
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        configureTextField([dateTextField, timeTextField], date: dateTextField, time: timeTextField)
    }
}

// setup TextField
extension PeeViewController {
    func configureTextField(_ textFields: [UITextField], date: UITextField, time: UITextField) {
        textFields.forEach { element in
            element.textAlignment = .center
            element.delegate = self
        }
        date.tag = 1
        time.tag = 2
        setupDatePicker(textField: date)
        setupDatePicker(textField: time)
    }
    
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
            dateTextField.text = sender.date.toFormattedString()
        } else {
            timeTextField.text = sender.date.toFormattedStringTime()
        }
    }
}


// textField Delegate
extension PeeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField || textField == timeTextField {
            return false
        }
//        else if textField == numberTextField {
//            let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
//            let withDecimal = (
//                string == NumberFormatter().decimalSeparator &&
//                textField.text?.contains(string) == false
//            )
//            return isNumber || withDecimal
//        }
        else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
