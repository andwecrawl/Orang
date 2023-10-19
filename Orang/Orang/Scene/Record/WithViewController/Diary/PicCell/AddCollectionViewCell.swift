//
//  AddCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/09.
//

import UIKit
import PhotosUI

final class AddCollectionViewCell: BaseCollectionViewCell {
    
    let addButton = UIButton.pictureButtonBuilder(image: "camera", imageSize: 16, radius: 16)
    
    var selectedAssetIdentifiers: [String]?
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(addButton)
    }
    
    var delegate: AddDelegate?
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        let menuElement: [UIMenuElement] = [
            UIAction(title: "photoAlbumButton".localized(), image: UIImage(systemName: "photo.on.rectangle"), handler: { _ in
                self.delegate?.openPhotoAlbum()
            }),
            UIAction(title: "takePictureButton".localized(), image: UIImage(systemName: "camera"), handler: { _ in
                self.delegate?.takePhoto()
            }),
            UIAction(title: "selectFileButton".localized(), image: UIImage(systemName: "folder"), handler: { _ in
                self.delegate?.selectFile()
            })
        ]
        addButton.menu = UIMenu(children: menuElement)
        addButton.showsMenuAsPrimaryAction = true
    }
    
    func configureAddButton(imagesCount: Int) {
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16)
        config.image = UIImage(systemName: "camera", withConfiguration: imageConfig)
        config.imagePlacement = .top
        config.imagePadding = 6
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 13, weight: .light)
        titleContainer.foregroundColor = .darkGray
        config.attributedTitle = AttributedString("\(imagesCount)/5", attributes: titleContainer)
        addButton.configuration = config
    }
}
