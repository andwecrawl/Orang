//
//  WeightRecordViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

final class WeightRecordViewController: BaseViewController, MoveToFirstScene {
    
    private let weightLabel = UILabel.labelBuilder(text: "weightSetting".localized(),size: 16, weight: .semibold, settingTitle: true)
    private let weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputNumber".localized())
    private let weightUnitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: Unit.g.rawValue, handler: { _ in }),
        UIAction(title: Unit.kg.rawValue, handler: { _ in }),
        UIAction(title: Unit.lb.rawValue, handler: { _ in }),
    ])
    private let weightStackView = UIStackView.stackViewBuilder()
    
    private let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    private let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    private let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    private let dateStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    
    var selectedPet: [PetTable]?
    let repository = PetTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "weightTitle".localized()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let pet = selectedPet?.first else { return }
        guard let weight = Float(weightTextField.text ?? "0") else { return }
        if weight == 0 || weight < 0 {
            self.sendOneSidedAlert(title: "몸무게를 입력해 주세요!")
        }
        guard let unitStr = weightUnitButton.titleLabel?.text else { return }
        guard let unit = Unit(rawValue: unitStr) else { return }
        guard let date = dateTextField.text else { return }
        guard let time = timeTextField.text else { return }
        guard let recordDate = "\(date) \(time)".toDateContainsTime() else { return }
        
        let record = RecordTable(recordType: .weight, petID: pet._id, recordDate: recordDate, weight: weight , weightUnit: unit)
        
        repository.updateRecords(id: pet._id, record)
        print("saved!!")
        moveToFirstScene()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            weightStackView,
            dateStackView
        ]
            .forEach { view.addSubview($0) }
        
        weightStackView.AddArrangedSubviews([weightLabel, weightTextField, weightUnitButton])
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
    }
    
    override func setConstraints() {
        
        weightStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(weightStackView.snp.bottom).offset(16)
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
            dateTextField.text = sender.date.toFormattedString()
            
        } else {
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
