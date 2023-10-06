//
//  addViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit
import PhotosUI

class addViewController: BaseViewController {
    
    private lazy var profileImageView = UIImageView.imageViewBuilder(size: 130)
    private lazy var profileImageButton = UIButton.profileButtonBuilder(size: 130)
    
    private lazy var speciesLabel = UILabel.labelBuilder(text: "speciesSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var speciesTextField = UnderLineTextField.textFieldBuilder(placeholder: "chooseSpecies".localized())
    private lazy var speciesStackView = UIStackView.stackViewBuilder()
    
    private lazy var nameLabel = UILabel.labelBuilder(text: "nameSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var nameTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputName".localized())
    private lazy var nameStackView = UIStackView.stackViewBuilder()
    
    private lazy var birthLabel = UILabel.labelBuilder(text: "birthdaySetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var birthTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputBirthday".localized())
    private lazy var birthStackView = UIStackView.stackViewBuilder()
    private lazy var idkBirthButton = UIButton.idkButtonBuilder(title: "생일이 기억나지 않아요.")
    
    private lazy var meetDateLabel = UILabel.labelBuilder(text: "meetDateSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var meetDateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputMeetDate".localized())
    private lazy var meetDateStackView = UIStackView.stackViewBuilder()
    
    private lazy var weightLabel = UILabel.labelBuilder(text: "weightSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputWeight".localized())
    private lazy var weightStackView = UIStackView.stackViewBuilder()
    private lazy var weightUnitButton = UIButton.unitPopUpButtonBuilder(menuElement: [
        UIAction(title: "g", handler: { _ in }),
        UIAction(title: "kg", handler: { _ in }),
        UIAction(title: "lb", handler: { _ in })
    ])
    
    private lazy var registrationLabel = UILabel.labelBuilder(text: "registrationNumber".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var registrationTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputRegistrationNumber".localized())
    private lazy var registrationStackView = UIStackView.stackViewBuilder()
    private lazy var idkRegistrationButton = UIButton.idkButtonBuilder(title: "등록번호가 없어요.")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func setNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let name = nameTextField.text else { return }
        guard let weight = weightTextField.text else { return }
        
        if name.isEmpty && weight.isEmpty {
            nameTextField.setError()
            weightTextField.setError()
        } else if weight.isEmpty {
            weightTextField.setError()
        } else if name.isEmpty {
            nameTextField.setError()
        }
         
         if meetDateTextField.text?.isEmpty ?? true {
             meetDateTextField.setError()
             sendOneSidedAlert(title: "처음 만난 날을 입력해 주세요!")
         }
        
         
        
    }
    
    func isValid() -> Bool {
        return true
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(profileImageView)
        view.addSubview(profileImageButton)
        
        [speciesStackView, nameStackView, birthStackView, meetDateStackView, weightStackView, registrationStackView].forEach {
            view.addSubview($0)
        }
        
        speciesStackView.AddArrangedSubviews([speciesLabel, speciesTextField])
        nameStackView.AddArrangedSubviews([nameLabel, nameTextField])
        birthStackView.AddArrangedSubviews([birthLabel, birthTextField])
        view.addSubview(idkBirthButton)
        meetDateStackView.AddArrangedSubviews([meetDateLabel, meetDateTextField])
        weightStackView.AddArrangedSubviews([weightLabel, weightTextField, weightUnitButton])
        registrationStackView.AddArrangedSubviews([registrationLabel, registrationTextField])
        view.addSubview(idkRegistrationButton)
    }
    
    
    override func setConstraints() {
        profileImageView.backgroundColor = .gray
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.centerX.equalTo(profileImageView)
        }
        
        speciesStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(speciesStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nameStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        idkBirthButton.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).inset(8)
            make.horizontalEdges.equalTo(birthTextField)
        }
        
        meetDateStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(birthStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        weightStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(meetDateStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(weightStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        idkRegistrationButton.snp.makeConstraints { make in
            make.top.equalTo(registrationStackView.snp.bottom).inset(8)
            make.horizontalEdges.equalTo(registrationTextField)
        }
    }
    
    override func configureView() {
        birthTextField.tag = 1
        meetDateTextField.tag = 2
        
        [birthTextField, meetDateTextField].forEach {
            setupDatePicker(textField: $0)
        }
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        [idkBirthButton, idkRegistrationButton].forEach { $0.addTarget(self, action: #selector(idkButtonClicked), for: .touchUpInside) }
    }
    
    @objc func idkButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        let textField = sender == idkBirthButton ? birthTextField : registrationTextField
        if sender.isSelected {
            textField.text = sender.titleLabel?.text ?? ""
            textField.isUserInteractionEnabled = false
        } else {
            textField.text = ""
            textField.isUserInteractionEnabled = true
        }
    }
}


// speciesPicker
extension addViewController: UIPickerViewDelegate {
    
}
