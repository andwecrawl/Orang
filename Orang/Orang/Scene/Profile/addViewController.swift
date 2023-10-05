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
    
    private lazy var nameLabel = UILabel.labelBuilder(text: "nameSetting".localized(), size: 16, weight: .bold)
    let speciesLabel = UILabel.labelBuilder(text: "종", size: 16, weight: .bold, settingTitle: true)
    var speciesUnitButton = UIButton()
    let speciesStackView = UIStackView.stackViewBuilder()
    
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
    private lazy var weightUnitButton = UIButton.unitPopUpButtonBuilder { action in
        print("changed to \(action.title)")
    }
    
    private lazy var registrationLabel = UILabel.labelBuilder(text: "registrationNumber".localized(), size: 16, weight: .bold)
    private lazy var registrationLabel = UILabel.labelBuilder(text: "registrationNumber".localized(), size: 16, weight: .bold, settingTitle: true)
    private lazy var registrationTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputRegistrationNumber".localized())
    private lazy var registrationStackView = UIStackView.stackViewBuilder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(profileImageView)
        view.addSubview(profileImageButton)
        
        [nameStackView, birthStackView, meetDateStackView, weightStackView, registrationStackView].forEach {
            view.addSubview($0)
        }
        nameStackView.AddArrangedSubviews([nameLabel, nameTextField])
        birthStackView.AddArrangedSubviews([birthLabel, birthTextField])
        view.addSubview(idkBirthButton)
        meetDateStackView.AddArrangedSubviews([meetDateLabel, meetDateTextField])
        weightStackView.AddArrangedSubviews([weightLabel, weightTextField, weightUnitButton])
        registrationStackView.AddArrangedSubviews([registrationLabel, registrationTextField])
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
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        nameStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        birthStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nameStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        idkBirthButton.snp.makeConstraints { make in
            make.top.equalTo(birthStackView.snp.bottom).inset(8)
            make.horizontalEdges.equalTo(birthStackView)
        }
        
        meetDateLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        meetDateStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(birthStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        weightLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        weightStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(meetDateStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(weightStackView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
    
    func configureView() {
        birthTextField.tag = 1
        meetDateTextField.tag = 2
        
        [birthTextField, meetDateTextField].forEach {
            setupDatePicker(textField: $0)
        }
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        idkBirthButton.addTarget(self, action: #selector(idkBirthButtonClicked), for: .touchUpInside)
    }
    
    @objc func idkBirthButtonClicked() {
        idkBirthButton.isSelected.toggle()
    }
}


// datePicker
extension addViewController {
    private func setupDatePicker(textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.tag = textField.tag
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
        // 원하는 언어로 지역 설정
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        textField.inputView = datePicker
        textField.text = datePicker.dateFormat()
    }

    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        if sender.tag == 1 {
            birthTextField.text = sender.dateFormat()
        } else {
            meetDateTextField.text = sender.dateFormat()
        }
    }
}


// profile Image
extension addViewController: PHPickerViewControllerDelegate {
    @objc func profileImageButtonClicked() {
        // picker 기본 설정!!
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        // itemProvider == 선택한 asset을 보여주는 역할을 함!!
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            let type: NSItemProviderReading.Type = UIImage.self
            itemProvider.loadObject(ofClass: type) { image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                } else {
                    // 다시 시도 Alert
                    print(error)
                }
            }
        }
    }
}
