//
//  FeedViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

final class FeedViewController: BaseViewController, MoveToFirstScene {
    
    private let typeLabel = UILabel.labelBuilder(text: "snackVariation".localized(), size: 16, weight: .bold, settingTitle: true)
    private let typeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputSnackType".localized())
    private let typeStackView = UIStackView.stackViewBuilder()
    
    private let numberLabel = UILabel.labelBuilder(text: "amount".localized(),size: 16, weight: .semibold, settingTitle: true)
    private let numberTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputNumber".localized())
    private let unitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: Unit.g.toString, handler: { _ in }),
        UIAction(title: Unit.kg.toString, handler: { _ in }),
        UIAction(title: Unit.lb.toString, handler: { _ in }),
        UIAction(title: Unit.count.toString, handler: { _ in })
    ])
    private let numberStackView = UIStackView.stackViewBuilder()
    
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
        
        title = "snackTitle".localized()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        
        
    }
    
    @objc func saveButtonClicked() {
        guard let pet = selectedPet?.first else { return }
        guard let snackType = typeTextField.text else { return }
        guard let number = Int(numberTextField.text ?? "0") else { return }
        if number == 0 || number < 0 {
            self.sendOneSidedAlert(title: "noSnackAmountError".localized())
        }
        guard let unitStr = unitButton.titleLabel?.text else { return }
        guard let date = dateTextField.text else { return }
        guard let time = timeTextField.text else { return }
        guard let recordDate = "\(date) \(time)".toDateContainsTime() else { return }
        
        if unitStr == "count".localized() {
            let unit = Unit.count
            
            let record = RecordTable(recordType: .snack, petID: pet._id, recordDate: recordDate, snackSpecies: snackType, snackAmount: number, unit: unit)
            
            repository.updateRecords(id: pet._id, record)
            moveToFirstScene()
        } else {
            guard let unit = Unit(rawValue: unitStr) else { return }
            
            let record = RecordTable(recordType: .snack, petID: pet._id, recordDate: recordDate, snackSpecies: snackType, snackAmount: number, unit: unit)
            
            repository.updateRecords(id: pet._id, record)
            
            moveToFirstScene()
        }
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            numberStackView,
            typeStackView,
            dateStackView
        ]
            .forEach { view.addSubview($0) }
        
        typeStackView.addArrangedSubviews([typeLabel, typeTextField])
        numberStackView.addArrangedSubviews([numberLabel, numberTextField, unitButton])
        dateStackView.addArrangedSubviews([dateLabel, dateTextField, timeTextField])
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
        configureTextField([dateTextField, timeTextField, typeTextField, numberTextField], date: dateTextField, time: timeTextField)
    }
}


// setup TextField
extension FeedViewController {
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
