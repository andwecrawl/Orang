//
//  addViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/30.
//

import UIKit

class addViewController: BaseViewController {
    
    let profileImageView = UIImageView.imageViewBuilder(size: 130)
    let profileImageButton = UIButton.profileButtonBuilder(size: 130)
    
    let nameLabel = UILabel.labelBuilder(text: "name".localized(), size: 16, weight: .bold)
    let nameTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputName".localized())
    let nameStackView = UIStackView.stackViewBuilder()
    
    let birthLabel = UILabel.labelBuilder(text: "birthday".localized(), size: 16, weight: .bold)
    let birthTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputBirthday".localized())
    let birthStackView = UIStackView.stackViewBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setNavigationBar() {
        // scrollEdgeAppearance를 적용하고 싶음... ... 추후 적용!!
        navigationController?.navigationBar.prefersLargeTitles = true
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
        setStackViewConstrations(stackView: birthStackView, label: birthLabel, topElement: nameStackView)
    func setStackViewConstrations(stackView: UIStackView, label: UILabel, topElement: UIView) {
        label.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(topElement.snp.bottom).offset(16)
            make.height.equalTo(50)
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
