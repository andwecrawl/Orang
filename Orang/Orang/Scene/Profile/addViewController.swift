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
    private lazy var nameTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputName".localized())
    private lazy var nameStackView = UIStackView.stackViewBuilder()
    
    private lazy var birthLabel = UILabel.labelBuilder(text: "birthdaySetting".localized(), size: 16, weight: .bold)
    private lazy var birthTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputBirthday".localized())
    private lazy var birthStackView = UIStackView.stackViewBuilder()
    
    private lazy var meetDateLabel = UILabel.labelBuilder(text: "meetDateSetting".localized(), size: 16, weight: .bold)
    private lazy var meetDateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputMeetDate".localized())
    private lazy var meetDateStackView = UIStackView.stackViewBuilder()
    
    private lazy var weightLabel = UILabel.labelBuilder(text: "weightSetting".localized(), size: 16, weight: .bold)
    private lazy var weightTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputWeight".localized())
    private lazy var weightStackView = UIStackView.stackViewBuilder()
    
    private lazy var registrationLabel = UILabel.labelBuilder(text: "registrationNumber".localized(), size: 16, weight: .bold)
    private lazy var registrationTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputWeight".localized())
    private lazy var registrationStackView = UIStackView.stackViewBuilder()
    
    private lazy var listStackView = UIStackView.stackViewBuilder(axis: .vertical)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    
    func setNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(profileImageView)
        view.addSubview(profileImageButton)
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
        
        [nameStackView, birthStackView, meetDateStackView, weightStackView, registrationStackView].forEach {
            view.addSubview($0)
        }
        nameStackView.AddArrangedSubviews([nameLabel, nameTextField])
        birthStackView.AddArrangedSubviews([birthLabel, birthTextField])
        meetDateStackView.AddArrangedSubviews([meetDateLabel, meetDateTextField])
        weightStackView.AddArrangedSubviews([weightLabel, weightTextField])
        registrationStackView.AddArrangedSubviews([registrationLabel, registrationTextField])
        
//        view.addSubview(listStackView)
//        listStackView.AddArrangedSubviews([nameStackView, birthStackView, meetDateStackView, weightStackView, registrationStackView])
    }
    
    @objc func profileImageButtonClicked() {
    
        // picker 기본 설정!!
        var configuration = PHPickerConfiguration()
        
        // 최대 몇 개까지 고르게 할지!!
        configuration.selectionLimit = 1
        
        // 어떤 거만 허용할지!
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
}


extension addViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        // itemProvider == 선택한 asset을 보여주는 역할을 함!!
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            let type: NSItemProviderReading.Type = UIImage.self
            itemProvider.loadObject(ofClass: type) { image, error in
                if let image = image as? UIImage {
                    // View를 다시 그려주는 거기 땜에 main에 넣어주깅...
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                        
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}
