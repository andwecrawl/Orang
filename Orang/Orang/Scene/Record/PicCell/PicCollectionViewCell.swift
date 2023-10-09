//
//  PicCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/09.
//

import UIKit

class PicCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = Design.Color.halfGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let deleteButton = UIButton.pictureButtonBuilder(image: UIImage(systemName: "xmark"))
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            imageView,
            deleteButton
        ]
            .forEach { self.addSubview($0) }
        
        imageView.layer.cornerRadius = 16
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).inset(4)
            make.trailing.equalTo(imageView.snp.trailing).inset(4)
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        
    }
}
