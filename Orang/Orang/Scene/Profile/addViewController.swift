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
        
        nameStackView.AddArrangedSubviews([nameLabel, nameTextField])
        birthStackView.AddArrangedSubviews([birthLabel, birthTextField])
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
    
}
