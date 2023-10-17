//
//  VaccineAddCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/16.
//

import UIKit

class VaccineAddCollectionViewCell: BaseCollectionViewCell {
    
    private let addButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15)
        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.setTitle(" 접종 항목 추가하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.titleLabel?.textColor = .darkGray
        button.tintColor = .darkGray
        button.backgroundColor = Design.Color.halfGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    var delegate: VaccineProtocol?
    
    override func configureHierarchy() {
        self.addSubview(addButton)
    }
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    
    override func configureView() {
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    
    @objc func addButtonClicked() {
        delegate?.addButtonHandler()
    }
}
