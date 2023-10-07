//
//  addViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class AddViewController: BaseViewController {
    
    lazy var profileImageView = UIImageView.imageViewBuilder(size: 130)
    private lazy var profileImageButton = UIButton.profileButtonBuilder(size: 130)
    
    private lazy var speciesLabel = UILabel.labelBuilder(text: "speciesSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var speciesTextField = UnderLineTextField.textFieldBuilder(placeholder: "chooseSpecies".localized())
    private lazy var speciesStackView = UIStackView.stackViewBuilder()
    
    private lazy var detailSpeciesLabel = UILabel.labelBuilder(text: "  ", size: 16, weight: .bold, settingTitle: true)
    private lazy var detailSpeciesTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDetailSpecies".localized())
    private lazy var detailStackView = UIStackView.stackViewBuilder()
    private lazy var totalSpeciesStackView = UIStackView.stackViewBuilder(space: 2, axis: .vertical)
    
    private lazy var nameLabel = UILabel.labelBuilder(text: "nameSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var nameTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputName".localized())
    private lazy var nameStackView = UIStackView.stackViewBuilder()
    
    private lazy var birthLabel = UILabel.labelBuilder(text: "birthdaySetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var birthTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputBirthday".localized())
    private lazy var birthStackView = UIStackView.stackViewBuilder()
    private lazy var idkBirthButton = UIButton.idkButtonBuilder(title: "생일이 기억나지 않아요.")
    
    private lazy var meetDateLabel = UILabel.labelBuilder(text: "meetDateSetting".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var meetDateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputMeetDate".localized())
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
    
    var species: Species? = nil
    var birth: Date? = nil
    var meetDate: Date? = nil
    var registrationNum: String? = nil
    
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
        let image = profileImageView.image
        guard let name = nameTextField.text else { return }
        guard let meetDate else { return }
        if idkBirthButton.isSelected {
            birth = nil
        }
        guard let weightStr = weightTextField.text, let weight = Float(weightStr) else {
            let _ = hasError(species: .none, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: .none)
            return
        }
        guard let species else {
            let _ = hasError(species: .none, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: weight)
            return
        }
        guard let detailSpecies = detailSpeciesTextField.text else {
            let _ = hasError(species: species, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: weight)
            return
        }
        registrationNum = registrationTextField.text
        
        
        let hasError = hasError(species: species, detailSpecies: detailSpecies, name: name, birth: birth, meetDate: meetDate, weight: weight)
        if hasError { return }
        
        
        let pet = PetTable(species: species, detailSpecies: detailSpecies, name: name, birthday: birth, belongDate: meetDate, weight: weight, RegistrationNum: registrationNum)
        ImageManager.shared.makeDirectory(directoryName: .profile)
        if !ImageManager.shared.saveImageToDirectory(directoryName: .profile, identifier: pet.createdDate.toString(), image: image) {
            sendOneSidedAlert(title: "이미지 저장에 실패했습니다.", message: "다시 시도해 주세요!")
            return
        }
        
    }
    
    func hasError(species: Species?, detailSpecies: String, name: String, birth: Date?, meetDate: Date, weight: Float?) -> Bool {
        var foundError = false
        if species == .none || ((species == .reptile || species == .etc) && detailSpecies.isEmpty) {
            speciesTextField.setError()
            foundError = true
        }
        if name.isEmpty {
            nameTextField.setError()
            foundError = true
        }
        if let birth {
            if birth.compareNow() == .orderedDescending {
                birthTextField.setError()
                foundError = true
            } else if birth.compare(meetDate) == .orderedDescending {
                birthTextField.setError()
                foundError = true
            }
        }
        if meetDate.compareNow() == .orderedDescending {
            meetDateTextField.setError()
            foundError = true
        }
        guard let weight else {
            weightTextField.setError()
            return true
        }
        if weight < 0 {
            weightTextField.setError()
            foundError = true
        }
        return foundError
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(profileImageView)
        view.addSubview(profileImageButton)
        
        [totalSpeciesStackView, nameStackView, birthStackView, meetDateStackView, weightStackView, registrationStackView].forEach {
            view.addSubview($0)
        }
        
        speciesStackView.AddArrangedSubviews([speciesLabel, speciesTextField])
        detailStackView.AddArrangedSubviews([detailSpeciesLabel, detailSpeciesTextField])
        totalSpeciesStackView.AddArrangedSubviews([speciesStackView, detailStackView])
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.centerX.equalTo(profileImageView)
        }
        
        speciesStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(totalSpeciesStackView.snp.top)
            make.height.equalTo(50)
        }
        
        totalSpeciesStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(totalSpeciesStackView.snp.bottom).offset(7)
            make.height.equalTo(50)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nameStackView.snp.bottom).offset(7)
            make.height.equalTo(50)
        }
        
        idkBirthButton.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).inset(7)
            make.leading.equalTo(birthLabel.snp.trailing)
            make.trailing.equalTo(birthTextField.snp.trailing)
        }
        
        meetDateStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(idkBirthButton.snp.bottom).offset(6)
            make.height.equalTo(50)
        }
        
        weightStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(meetDateStackView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(weightStackView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        idkRegistrationButton.snp.makeConstraints { make in
            make.top.equalTo(registrationStackView.snp.bottom).inset(8)
            make.leading.equalTo(registrationLabel.snp.trailing)
            make.trailing.equalTo(registrationTextField.snp.trailing)
        }
    }
    
    override func configureView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        speciesTextField.inputView = pickerView
        birthTextField.tag = 1
        meetDateTextField.tag = 2
        
        [detailSpeciesTextField, nameTextField, birthTextField, meetDateTextField, weightTextField, speciesTextField, registrationTextField].forEach {
            if $0 == birthTextField || $0 == meetDateTextField {
                setupDatePicker(textField: $0)
            } else if $0 == weightTextField || $0 == registrationTextField {
                $0.keyboardType = .decimalPad
            }
            $0.delegate = self
            
        }
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        [idkBirthButton, idkRegistrationButton].forEach { $0.addTarget(self, action: #selector(idkButtonClicked), for: .touchUpInside) }
        
        configureRegistrationSection(canRegistrate: false)
        configureDetailSpeciesTextField(hasDetail: false)
    }
    
    func configureRegistrationSection(canRegistrate: Bool) {
        if canRegistrate {
            registrationStackView.isHidden = false
            idkRegistrationButton.isHidden = false
        } else {
            registrationStackView.isHidden = true
            idkRegistrationButton.isHidden = true
        }
    }
    
    func configureDetailSpeciesTextField(hasDetail: Bool) {
        if hasDetail {
            detailStackView.isHidden = false
        } else {
            detailStackView.isHidden = true
        }
    }
    
    @objc func idkButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        let textField = sender == idkBirthButton ? birthTextField : registrationTextField
        if sender.isSelected {
            textField.text = sender.titleLabel?.text ?? ""
            textField.isUserInteractionEnabled = false
        } else {
            let date = Date()
            textField.text = date.toFormattedString()
            textField.isUserInteractionEnabled = true
        }
    }
}


// textField
extension AddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == birthTextField || textField == meetDateTextField || textField == speciesTextField {
            return false
        } else if textField == registrationTextField || textField == weightTextField {
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
