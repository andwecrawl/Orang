//
//  VaccineViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

final class VaccineViewController: BaseViewController {
    
    let hospitalLabel = UILabel.labelBuilder(text: "hospitalName".localized(), size: 16, weight: .bold, settingTitle: true)
    let hospitalTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputHospitalName".localized(), textAlignment: .center)
    let hospitalStackView = UIStackView.stackViewBuilder()
    
    let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    let dateStackView = UIStackView.stackViewBuilder()

    let vaccineTypeLabel = UILabel.labelBuilder(text: "접종 항목".localized(), size: 16, weight: .bold, settingTitle: true)
    let vaccineTypeTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종 항목을".localized(), textAlignment: .center)
    let vaccineTypeStackView = UIStackView.stackViewBuilder()
    let vaccineDetailTextField = UnderLineTextField.textFieldBuilder(placeholder: "선택해 주세요.".localized(), isTimeTextfield: true, textAlignment: .center)
    let vaccineButton = UIButton()
    
    let inputVaccineTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종한 백신을 입력해 주세요!", textAlignment: .center)
    let noVaccineButton = UIButton.idkButtonBuilder(title: "접종한 백신이 표에 없어요.")
    
    let priceLabel = UILabel.labelBuilder(text: "비용(원)", size: 16, weight: .bold, settingTitle: true)
    let priceTextField = UnderLineTextField.textFieldBuilder(placeholder: "비용을 입력해 주세요.".localized(), textAlignment: .center)
    let priceStackView = UIStackView.stackViewBuilder()
    
    var selectedPet: [PetTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "예방 접종 내역 기록하기"
    }
    
    override func setNavigationBar() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            hospitalStackView,
            dateStackView,
            vaccineTypeLabel,
            vaccineTypeStackView,
            vaccineButton,
            inputVaccineTextField,
            noVaccineButton,
            priceStackView
        ]
            .forEach{ view.addSubview($0) }
        
        hospitalStackView.AddArrangedSubviews([hospitalLabel, hospitalTextField])
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
        vaccineTypeStackView.AddArrangedSubviews([vaccineTypeTextField, vaccineDetailTextField])
        priceStackView.AddArrangedSubviews([priceLabel, priceTextField])
        
        vaccineButton.addTarget(self, action: #selector(vaccineButtonClicked), for: .touchUpInside)
        noVaccineButton.addTarget(self, action: #selector(noVaccineButtonClicked), for: .touchUpInside)
    }
    
    @objc func noVaccineButtonClicked(_ sender: UIButton) {
        print("clicked!!")
        sender.isSelected.toggle()
        if sender.isSelected {
            [vaccineTypeTextField, vaccineDetailTextField, vaccineButton].forEach { element in
                element.isHidden = true
            }
            inputVaccineTextField.isHidden = false
            inputVaccineTextField.isEnabled = true
        } else {
            [vaccineTypeTextField, vaccineDetailTextField, vaccineButton].forEach { element in
                element.isHidden = false
            }
            inputVaccineTextField.isHidden = true
            inputVaccineTextField.isEnabled = false
        }
    }
    
    @objc func vaccineButtonClicked() {
        guard let selectedPet else { return }
        let vc = VaccineTypeViewController()
        vc.selectedPet = selectedPet.first!
        vc.modalPresentationStyle = .formSheet
        vc.completionHandler = { (title, variation) in
            self.vaccineTypeTextField.text = variation
            self.vaccineDetailTextField.text = title
            
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    override func setConstraints() {
        
        hospitalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(hospitalStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        vaccineTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        vaccineTypeStackView.snp.makeConstraints { make in
            make.top.equalTo(vaccineTypeLabel)
            make.leading.equalTo(vaccineTypeLabel.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        vaccineButton.snp.makeConstraints { make in
            make.edges.equalTo(vaccineTypeStackView)
        }
        
        inputVaccineTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(vaccineTypeStackView)
            make.leading.equalTo(hospitalLabel.snp.trailing).offset(10)
            make.trailing.equalTo(hospitalStackView.snp.trailing)
        }
        
        noVaccineButton.snp.makeConstraints { make in
            make.top.equalTo(vaccineTypeStackView.snp.bottom)
            make.leading.equalTo(hospitalLabel.snp.trailing)
            make.trailing.equalTo(vaccineButton.snp.trailing)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(noVaccineButton.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        configureTextField([dateTextField, timeTextField], date: dateTextField, time: timeTextField)
        [vaccineTypeTextField, vaccineDetailTextField].forEach { $0.isUserInteractionEnabled = false }
        
        inputVaccineTextField.isHidden = true
    }
    

}


// setup TextField
extension VaccineViewController {
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
extension VaccineViewController: UITextFieldDelegate {
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
