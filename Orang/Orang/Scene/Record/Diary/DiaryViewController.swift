//
//  DiaryViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit

class DiaryViewController: BaseViewController {
    
    let titleTextField = UnderLineTextField.textFieldBuilder(placeholder: "제목을 입력해 주세요!")
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "일상 기록 추가하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
    }
    
    override func configureView() {
        titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(titleTextField)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
    
    override func setConstraints() {
    }
}
