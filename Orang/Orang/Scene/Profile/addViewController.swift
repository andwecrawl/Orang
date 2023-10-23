//
//  addViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

final class AddViewController: BaseViewController {
    
    let mainView = AddView()
    
    var pet: Pet?
    
    var species: Species? = nil
    var birth: Date? = nil
    var meetDate: Date? = nil
    var registrationNum: String? = nil
    let repository = PetTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        let image = mainView.profileImageView.image
        guard let name = mainView.nameTextField.text else { return }
        guard let meetDate else { return }
        if mainView.idkBirthButton.isSelected {
            birth = nil
        }
        guard let weightStr = mainView.weightTextField.text, let weight = Float(weightStr) else {
            let _ = hasError(species: .none, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: .none)
            return
        }
        guard let species else {
            let _ = hasError(species: .none, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: weight)
            return
        }
        guard let detailSpecies = mainView.detailSpeciesTextField.text else {
            let _ = hasError(species: species, detailSpecies: "", name: name, birth: birth, meetDate: meetDate, weight: weight)
            return
        }
        registrationNum = mainView.registrationTextField.text
        
        
        let hasError = hasError(species: species, detailSpecies: detailSpecies, name: name, birth: birth, meetDate: meetDate, weight: weight)
        if hasError { return }
        
        let weightUnitStr = mainView.weightUnitButton.titleLabel?.text ?? "g"
        let weightUnit = Unit(rawValue: weightUnitStr) ?? .g
        
        let newPet = PetTable(species: species, detailSpecies: detailSpecies, name: name, birthday: birth, belongDate: meetDate, weight: weight, weightUnit: weightUnit, RegistrationNum: registrationNum)
        
        if !ImageManager.shared.saveImageToDirectory(directoryName: .profile, identifier: newPet.createdDate.toString(), image: image) {
            sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
            return
        }
        
        if let pet {
            repository.updatePet(id: pet._id, newPet)
        } else {
            repository.create(newPet)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func hasError(species: Species?, detailSpecies: String, name: String, birth: Date?, meetDate: Date, weight: Float?) -> Bool {
        var foundError = false
        if ((species == .reptile || species == .etc) && detailSpecies.isEmpty) {
            mainView.detailSpeciesTextField.setError()
            foundError = true
        } else if species == .none {
            mainView.speciesTextField.setError()
            foundError = true
        }
        if name.isEmpty {
            mainView.nameTextField.setError()
            foundError = true
        }
        if let birth {
            if birth.compareNow() == .orderedDescending {
                mainView.birthTextField.setError()
                foundError = true
            } else if birth.compare(meetDate) == .orderedDescending {
                mainView.birthTextField.setError()
                foundError = true
            }
        }
        if meetDate.compareNow() == .orderedDescending {
            mainView.meetDateTextField.setError()
            foundError = true
        }
        guard let weight else {
            mainView.weightTextField.setError()
            return true
        }
        if weight < 0 {
            mainView.weightTextField.setError()
            foundError = true
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
            }
        
        mainView.profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        [mainView.idkBirthButton, mainView.idkRegistrationButton].forEach { $0.addTarget(self, action: #selector(idkButtonClicked), for: .touchUpInside) }
        
        configureRegistrationSection(canRegistrate: false)
        configureDetailSpeciesTextField(hasDetail: false)
        
        setEditVC()
    }
    
    func setEditVC() {
        guard let pet else { return }
        
        let image = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
        mainView.profileImageView.image = image
        let species = pet.species
        self.species = species
        if species == .reptile || species == .etc {
            guard let detailSpecies = pet.detailSpecies else { return }
            mainView.speciesTextField.text = species.toString
            mainView.detailSpeciesTextField.text = detailSpecies
        } else {
            mainView.speciesTextField.text = species.toString
        }
        mainView.nameTextField.text = pet.name
        if let birthday = pet.birthday {
            mainView.birthTextField.text = birthday.toFormattedString()
        } else {
            mainView.idkBirthButton.isSelected = true
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
    
    func configureRegistrationSection(canRegistrate: Bool) {
        if canRegistrate {
            mainView.registrationStackView.isHidden = false
            mainView.idkRegistrationButton.isHidden = false
        } else {
            mainView.registrationStackView.isHidden = true
            mainView.idkRegistrationButton.isHidden = true
        }
    }
    
    func configureDetailSpeciesTextField(hasDetail: Bool) {
        if hasDetail {
            mainView.detailStackView.isHidden = false
        } else {
            mainView.detailStackView.isHidden = true
        }
    }
    
    @objc func idkButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        let textField = sender == mainView.idkBirthButton ? mainView.birthTextField : mainView.registrationTextField
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
