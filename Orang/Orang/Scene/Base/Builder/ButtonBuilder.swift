//
//  ButtonBuilder.swift
//  Orang
//
//  Created by yeoni on 2023/10/01.
//

import UIKit

extension UIButton {
    static func buttonBuilder(image: UIImage?, title: String, font: UIFont) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = font
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        return button
    }
    
    static func profileButtonBuilder(size: CGFloat) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.equalTo(size)
            make.width.equalTo(size)
        }
        button.layer.cornerRadius = size / 2
        return button
    }
    
    static func idkButtonBuilder() -> UIButton {
        let button = UIButton()
        
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(70)
        }
        
        button.configurationUpdateHandler = { button in
            var container = AttributeContainer()
            container.font = .systemFont(ofSize: 14, weight: .semibold)
            
            var configuration = UIButton.Configuration.plain()
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 13)
            configuration.imagePadding = 8
            configuration.titleAlignment = .leading
            
            switch button.state {
                
            case .selected:
                container.foregroundColor = Design.Color.content
                configuration.attributedTitle = AttributedString("모르겠어요", attributes: container)
                configuration.image = UIImage(systemName: "checkmark.square.fill")
                configuration.baseBackgroundColor = .clear
            case .highlighted:
                break
            default:
                container.foregroundColor = .darkGray
                configuration.attributedTitle = AttributedString("모르겠어요", attributes: container)
                configuration.image = UIImage(systemName: "checkmark.square")

            }
            
            button.configuration = configuration
        }
        
        return button
    }
    
    static func unitPopUpButtonBuilder(unitClosure: @escaping (UIAction) -> ()) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderColor = Design.Color.content?.cgColor
        button.layer.borderWidth = 1
        
        button.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        button.menu = UIMenu(children: [
            UIAction(title: "g", handler: unitClosure),
            UIAction(title: "kg", handler: unitClosure),
            UIAction(title: "lb", handler: unitClosure)
        ])
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        return button
    }
}

