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
    
    static func shadowButtonBuilder(title: String, subtitle: String, isBig: Bool) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Design.Color.buttonBackground
        button.contentHorizontalAlignment = .leading
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.2
        
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .leading
        if isBig {
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 26, bottom: 20, trailing: 20)
        } else {
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 16, bottom: 40, trailing: 20)
            button.layer.shadowRadius = 4
        }
        
        configuration.titlePadding = 4
        
        var titleContainer = AttributeContainer()
        var subtitleContainer = AttributeContainer()
        titleContainer.foregroundColor = Design.Color.content
        subtitleContainer.foregroundColor = Design.Color.border
        
        if isBig {
            titleContainer.font = .systemFont(ofSize: 17, weight: .bold)
            subtitleContainer.font = .systemFont(ofSize: 13, weight: .light)
        } else {
            titleContainer.font = .systemFont(ofSize: 15, weight: .bold)
            subtitleContainer.font = .systemFont(ofSize: 12, weight: .light)
        }
        
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        configuration.attributedSubtitle = AttributedString(subtitle, attributes: subtitleContainer)
        
        button.configuration = configuration
        
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
    
    static func idkButtonBuilder(title: String) -> UIButton {
        let button = UIButton()
        
        button.contentHorizontalAlignment = .leading
        button.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        button.configurationUpdateHandler = { button in

            var container = AttributeContainer()
            container.font = .systemFont(ofSize: 14, weight: .semibold)
            
            var configuration = UIButton.Configuration.plain()
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 13)
            configuration.imagePadding = 8
            configuration.titleAlignment = .leading
            configuration.baseBackgroundColor = .clear
            
            switch button.state {
                
            case .selected:
                container.foregroundColor = Design.Color.content
                configuration.attributedTitle = AttributedString(title, attributes: container)
                configuration.image = UIImage(systemName: "checkmark.square.fill")
            case .highlighted:
                break
            default:
                container.foregroundColor = .darkGray.withAlphaComponent(0.7)
                configuration.attributedTitle = AttributedString(title, attributes: container)
                configuration.image = UIImage(systemName: "checkmark.square")
                
            }
            
            button.configuration = configuration
        }
        
        return button
    }
    
    static func unitPopUpButtonBuilder(menuElement: [UIMenuElement]) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 8
        button.layer.borderColor = Design.Color.border.cgColor
        button.layer.borderWidth = 1
        button.menu = UIMenu(children: menuElement)
        button.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(40)
        }
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        return button
    }
    
    static func recordButtonBuilder(image: String, title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        config.image = UIImage(systemName: image, withConfiguration: imageConfig)
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 13, weight: .light)
        titleContainer.foregroundColor = .darkGray
        config.attributedTitle = AttributedString(title, attributes: titleContainer)
        config.imagePlacement = .top
        config.imagePadding = 10
        button.configuration = config
        return button
    }
    
    static func pictureButtonBuilder(image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.backgroundColor = Design.Color.halfGray
        button.layer.cornerRadius = 16
        button.snp.makeConstraints { make in
            make.height.equalTo(button.snp.width)
        }
        return button
    }
}
