//
//  choosePetCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

final class ChoosePetCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView.imageViewBuilder(size: 100)
        view.layer.borderWidth = 5
        return view
    }()
    
    let nameLabel = UILabel.labelBuilder(size: 13, weight: .medium, alignment: .center, settingTitle: false)
    
    var pet: PetTable?
    var isSelectedPet: Bool?
    var recordType: RecordType?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            imageView,
            nameLabel
        ]
            .forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        guard let recordType else { return }
        guard let pet else { return }
        guard let isSelectedPet else { return }
        
        nameLabel.text = pet.name
        
        let image = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
        imageView.image = image
        
        if isSelectedPet {
            imageView.layer.borderColor = Design.Color.tintColor.cgColor
        } else {
            imageView.layer.borderColor = Design.Color.border.cgColor
        }
    }
    
}
