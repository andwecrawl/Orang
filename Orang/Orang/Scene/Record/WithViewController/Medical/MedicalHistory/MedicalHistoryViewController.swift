//
//  MedicalHistoryViewControlelr.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

final class MedicalHistoryViewController: BaseViewController {
    
    private let hospitalLabel = UILabel.labelBuilder(text: "hospitalName".localized(), size: 16, weight: .bold, settingTitle: true)
    private let hospitalTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputHospitalName".localized(), textAlignment: .center)
    private let hospitalStackView = UIStackView.stackViewBuilder()
    
    private let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    private let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    private let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    private let dateStackView = UIStackView.stackViewBuilder()
    
    private let whyLabel = UILabel.labelBuilder(text: "내원 사유".localized(), size: 16, weight: .bold, settingTitle: true)
    private let whyTextField = UnderLineTextField.textFieldBuilder(placeholder: "아이의 증상을 작성해 주세요!", textAlignment: .center)
    private let whyStackView = UIStackView.stackViewBuilder()
    
    private let additionalMemo = AdditionalMemoViewController()
    
    var selectedPet: [PetTable]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "진료 내역 기록하기"
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }

    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            hospitalStackView,
            dateStackView,
            whyStackView
        ]
            .forEach{ view.addSubview($0) }
        
        hospitalStackView.AddArrangedSubviews([hospitalLabel, hospitalTextField])
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
        whyStackView.AddArrangedSubviews([whyLabel, whyTextField])
        
        addMemo()
    }
    
    override func setConstraints() {
        
        hospitalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(hospitalStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(hospitalStackView)
        }
        
        whyStackView.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(hospitalStackView)
        }
        
        additionalMemo.view.snp.makeConstraints { make in
            make.top.equalTo(whyStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        configureTextField([dateTextField, timeTextField], date: dateTextField, time: timeTextField)
    }
    
    
    private func addMemo() {
        additionalMemo.willMove(toParent: self)
        self.addChild(additionalMemo)
        view.addSubview(additionalMemo.view)
        additionalMemo.didMove(toParent: self)
    }
    
    private func removeMemo() {
        additionalMemo.willMove(toParent: nil)
        additionalMemo.removeFromParent()
        additionalMemo.view.removeFromSuperview()
    }

}




// setup TextField
extension MedicalHistoryViewController {
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
extension MedicalHistoryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField || textField == timeTextField {
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
