//
//  AddCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/09.
//

import UIKit

class AddCollectionViewCell: BaseCollectionViewCell {
    
    let addButton = UIButton.pictureButtonBuilder(image: UIImage(systemName: "plus"))
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(addButton)
    }
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func configureView() {
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpOutside)
        
        let menuElement: [UIMenuElement] = [
            UIAction(title: "사진 보관함", image: UIImage(systemName: "photo.on.rectangle"), handler: { _ in
                
            }),
            UIAction(title: "사진 찍기", image: UIImage(systemName: "camera"), handler: { _ in
                
            }),
            UIAction(title: "파일 선택", image: UIImage(systemName: "folder"), handler: { _ in
                
            })
        ]
        addButton.menu = UIMenu(children: menuElement)
    }
    
    @objc func addButtonClicked() {
        
    }
}
