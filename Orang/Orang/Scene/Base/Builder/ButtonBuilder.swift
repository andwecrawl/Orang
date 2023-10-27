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
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.1
        
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .leading
        if isBig {
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 26, bottom: 20, trailing: 20)
        } else {
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 16, bottom: 36, trailing: 20)
            button.layer.shadowRadius = 4
        }
        
        configuration.titlePadding = 4
        
        var titleContainer = AttributeContainer()
        var subtitleContainer = AttributeContainer()
        titleContainer.foregroundColor = Design.Color.buttonContent
        subtitleContainer.foregroundColor = Design.Color.border
        
        if isBig {
            titleContainer.font = Design.Font.scdreamMedium.getFonts(size: 17)
            subtitleContainer.font = Design.Font.scdreamRegular.smallFont
        } else {
            titleContainer.font = Design.Font.scdreamMedium.midFont
            subtitleContainer.font = Design.Font.scdreamRegular.smallFont
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
            container.font = Design.Font.scdreamMedium.midFont
            var configuration = UIButton.Configuration.plain()
            configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 13)
            configuration.imagePadding = 8
            configuration.titleAlignment = .leading
            configuration.baseBackgroundColor = .clear
            
            switch button.state {
                
            case .selected:
                container.foregroundColor = Design.Color.buttonContent
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
        button.titleLabel?.font = Design.Font.scdreamMedium.largeFont
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
    
    static func recordButtonBuilder(image: UIImage?, title: String) -> UIButton {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = image
        var titleContainer = AttributeContainer()
        titleContainer.font = Design.Font.scdreamRegular.getFonts(size: 12)
        titleContainer.foregroundColor = Design.Color.border
        config.titleAlignment = .center
        config.attributedTitle = AttributedString(title, attributes: titleContainer)
        config.imagePlacement = .top
        config.imagePadding = 6
        button.configuration = config
        return button
    }
    
    static func pictureButtonBuilder(image: String, imageSize: CGFloat, radius: CGFloat) -> UIButton {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: imageSize)
        let image = UIImage(systemName: image, withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.backgroundColor = Design.Color.halfGray
        button.layer.cornerRadius = radius
        button.snp.makeConstraints { make in
            make.height.equalTo(button.snp.width)
        }
        return button
    }
}
