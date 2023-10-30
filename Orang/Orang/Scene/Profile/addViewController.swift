//
//  addViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit
import Toast

final class AddViewController: BaseViewController {
    
    let mainView = AddView()
    let viewModel = AddViewModel()
    
    var pet: Pet?
    
    var registrationNum: String? = nil
    let repository = PetTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        navigationItem.largeTitleDisplayMode = .never
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let image = mainView.profileImageView.image else {
            self.sendOneSidedAlert(title: "이미지를 선택해 주세요!")
            return
        }
        let meetDate = mainView.meetDateTextField.text?.toDate() ?? Date()
        
        var birth: Date?
        if mainView.idkBirthButton.isSelected {
            birth = nil
        } else if let tempDate = mainView.birthTextField.text?.toDate() {
            birth = tempDate
        }
        
        guard let species = viewModel.species.value else {
            let _ = hasError(species: .none, detailSpecies: "", name: mainView.nameTextField.text ?? "", birth: birth, meetDate: meetDate, weight: Float(mainView.weightTextField.text ?? "") ?? 0 )
            return
        }
        
        guard let name = mainView.nameTextField.text else {
            let _ = hasError(species: .none, detailSpecies: "", name: "", birth: nil, meetDate: meetDate, weight: .none)
            return
        }
        
        guard let weightStr = mainView.weightTextField.text, let weight = Float(weightStr) else {
            let _ = hasError(species: .none, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: .none)
            return
        }
        
        guard let detailSpecies = mainView.detailSpeciesTextField.text else {
            let _ = hasError(species: species, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: weight)
            return
        }
        if mainView.idkRegistrationButton.isSelected {
            registrationNum = nil
        } else {
            registrationNum = mainView.registrationTextField.text ?? ""
            if species == .cat || species == .dog {
                if registrationNum!.isEmpty {
                    mainView.registrationTextField.setError()
                    return
                }
            }
        }
        
        let hasError = hasError(species: species, detailSpecies: detailSpecies, name: name, birth: birth, meetDate: meetDate, weight: weight)
        if hasError { return }
        
        let weightUnitStr = mainView.weightUnitButton.titleLabel?.text ?? "g"
        let weightUnit = Unit(rawValue: weightUnitStr) ?? .g
        
        let newPet = PetTable(species: species, detailSpecies: detailSpecies, name: name, birthday: birth, belongDate: meetDate ?? Date(), weight: weight, weightUnit: weightUnit, RegistrationNum: registrationNum)
        
        ImageManager.shared.makeImageString(directoryName: .profile, createDate: newPet.createdDate, images: [image]) { imageIdentifier in
            newPet.profileImage = imageIdentifier.first!
        } errorHandler: {
            self.sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
            return
        }
        
        if let pet {
            repository.updatePet(id: pet._id, newPet)
        } else {
            repository.create(newPet)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func hasError(species: Species?, detailSpecies: String, name: String, birth: Date?, meetDate: Date?, weight: Float?) -> Bool {
        var foundError = false
        
        if ((species == .reptile || species == .etc) && detailSpecies.isEmpty) {
            mainView.detailSpeciesTextField.setError()
            foundError = true
        } else if species == .none {
            mainView.speciesTextField.setError()
            foundError = true
        } else if (species == .dog || species == .cat) && !mainView.idkRegistrationButton.isSelected {
            if let regText = mainView.registrationTextField.text {
                if regText.isEmpty {
                    mainView.registrationTextField.setError()
                    foundError = true
                }
            }
        }
        
        if name.isEmpty {
            mainView.nameTextField.setError()
            foundError = true
        }
        
        if let meetDate {
            if meetDate.compareNow() == .orderedDescending {
                mainView.meetDateTextField.setError()
                foundError = true
            }
        } else {
            mainView.meetDateTextField.setError()
            foundError = true
        }
        
        if let birth {
            if birth.compareNow() == .orderedDescending {
                print(birth.compareNow())
                mainView.birthTextField.setError()
                foundError = true
            } else if birth.startOfTheDate.compare(meetDate ?? Date().startOfTheDate) == .orderedDescending {
                mainView.birthTextField.setError()
                foundError = true
            }
        } else {
            if !mainView.idkBirthButton.isSelected {
                mainView.birthTextField.setError()
                foundError = true
            }
        }
        
        
        if let weight {
            if weight <= 0 {
                mainView.weightTextField.setError()
                foundError = true
            }
        } else {
            mainView.weightTextField.setError()
            foundError = true
        }
        
        if foundError {
            self.view .makeToast("fillEachSections".localized())
        }
        return foundError
    }
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(mainView)
    }
    
    
    override func setConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        mainView.speciesTextField.inputView = pickerView
        mainView.birthTextField.tag = 1
        mainView.meetDateTextField.tag = 2
        
        [
            mainView.detailSpeciesTextField,
            mainView.nameTextField,
            mainView.birthTextField,
            mainView.meetDateTextField,
            mainView.weightTextField,
            mainView.speciesTextField,
            mainView.registrationTextField
        ]
            .forEach {
                if $0 == mainView.birthTextField || $0 == mainView.meetDateTextField {
                    setupDatePicker(textField: $0)
                } else if $0 == mainView.weightTextField || $0 == mainView.registrationTextField {
                    $0.keyboardType = .decimalPad
                }
                $0.delegate = self
                $0.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            }
        
        mainView.profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        [mainView.idkBirthButton, mainView.idkRegistrationButton].forEach { $0.addTarget(self, action: #selector(idkButtonClicked), for: .touchUpInside) }
        
        bindViewModel()
        setEditVC()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case mainView.detailSpeciesTextField:
            viewModel.detailSpecies.value = mainView.detailSpeciesTextField.text
        case mainView.nameTextField:
            viewModel.name.value = mainView.nameTextField.text ?? ""
        case mainView.birthTextField:
            viewModel.birthday.value = mainView.birthTextField.text?.toDate()
            print(mainView.birthTextField.text?.toDate())
        case mainView.meetDateTextField:
            viewModel.belongDate.value = mainView.meetDateTextField.text?.toDate() ?? Date()
        case mainView.weightTextField:
            viewModel.weight.value = mainView.weightTextField.text ?? ""
        default: break
        }
    }
    
    func bindViewModel() {
        
        viewModel.species.bind { species in
            self.mainView.speciesTextField.text = species?.toString
            self.mainView.idkRegistrationButton.isHidden = self.viewModel.registrationStackisHidden
            self.mainView.detailStackView.isHidden = self.viewModel.detailSectionIsHidden
        }
        
        viewModel.detailSpecies.bind { detailSpecies in
            self.mainView.detailSpeciesTextField.text = detailSpecies
        }
        
        viewModel.name.bind { name in
            self.mainView.nameTextField.text = name
        }
        
        viewModel.birthday.bind { birthday in
            self.mainView.birthTextField.text = birthday?.toFormattedString()
        }
        
        viewModel.belongDate.bind { meetDate in
            self.mainView.meetDateTextField.text = meetDate.toFormattedString()
        }
        
        viewModel.weight.bind { weight in
            self.mainView.weightTextField.text = "\(weight)"
        }
        
        
        viewModel.weightUnit.bind { unit in
            self.mainView.weightUnitButton.setTitle(Unit.g.toString, for: .normal)
        }
        
        viewModel.registrationNum.bind { number in
            self.mainView.registrationTextField.text = number
        }
    }
    
    
    func setEditVC() {
        guard let pet else { return }
        
        let image = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
        mainView.profileImageView.image = image
        let species = pet.species
        self.viewModel.species.value = species
        if species == .reptile || species == .etc {
            guard let detailSpecies = pet.detailSpecies else { return }
            mainView.speciesTextField.text = species.toString
            mainView.detailSpeciesTextField.text = detailSpecies
        } else {
            if species == .dog || species == .cat {
                if let num = pet.registrationNum {
                    mainView.registrationTextField.text = num
                    if num.isEmpty {
                        mainView.idkRegistrationButton.isSelected = true
                        idkButtonClicked(mainView.idkRegistrationButton)
                    }
                } else {
                    idkButtonClicked(mainView.idkRegistrationButton)
                }
            }
            mainView.speciesTextField.text = species.toString
        }
        mainView.nameTextField.text = pet.name
        if let birthday = pet.birthday {
            mainView.birthTextField.text = birthday.toFormattedString()
        } else {
            mainView.idkBirthButton.isSelected = true
            mainView.birthTextField.text = mainView.idkBirthButton.titleLabel?.text
        }
        mainView.weightTextField.text = "\(pet.weight)"
        
        
        if let menu = mainView.weightUnitButton.menu?.children {
            menu.forEach { action in
                if action.title == pet.weightUnit.rawValue {
                    let element = action as? UIAction
                    element?.state = .on
                }
            }
        }
    }
    
    
    @objc func idkButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        let textField = sender == mainView.idkBirthButton ? mainView.birthTextField : mainView.registrationTextField
        if sender.isSelected {
            textField.text = sender.titleLabel?.text ?? ""
            textField.isUserInteractionEnabled = false
        } else {
            if sender == mainView.idkBirthButton {
                let date = Date()
                textField.text = date.toFormattedString()
            } else {
                textField.text = ""
            }
            textField.isUserInteractionEnabled = true
        }
    }
}


// textField
extension AddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.count ?? 0 > 12 {
            return false
        }
        
        if textField == mainView.birthTextField || textField == mainView.meetDateTextField || textField == mainView.speciesTextField {
            return false
        } else if textField == mainView.registrationTextField || textField == mainView.weightTextField {
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
