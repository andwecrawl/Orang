//
//  PooPeeCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit
import M13Checkbox

final class PooPeeCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView.imageViewBuilder(size: 20)
    let titleLabel = UILabel.labelBuilder(text: "타이틀입니당", size: 16, weight: .bold)
    let subtitleLabel = UILabel.labelBuilder(text: "서브타이틀입니당", size: 14, weight: .regular)
    
    let checkbox = {
        let button = M13Checkbox(frame: .zero)
        button.stateChangeAnimation = .bounce(.fill) // orFlat
        button.markType = .checkmark
        button.checkState = .unchecked
        button.tintColor = Design.Color.tintColor
        return button
    }()
    
    let labelStackView = UIStackView.stackViewBuilder(space: 2, axis: .vertical)
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            imageView,
            labelStackView,
            checkbox
        ]
            .forEach { self.addSubview($0) }
        
        labelStackView.AddArrangedSubviews([titleLabel, subtitleLabel])
    }
    
    override func setConstraints() {
        labelStackView.distribution = .fillProportionally
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(10)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(imageView.snp.trailing).inset(20)
            make.trailing.equalTo(checkbox.snp.leading).offset(10)
        }
        
        checkbox.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(checkbox.snp.width)
            make.width.equalTo(25)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(30)
        }
    }
    
    override func configureView() {
        imageView.image = UIImage(systemName: "drop.fill")?.withTintColor(.red)
//        guard let symptom else { return }
//        if symptom.ischecked {
//            checkbox.setCheckState(.checked, animated: true)
//        } else {
//            checkbox.setCheckState(.unchecked, animated: true)
//        }
//        titleLabel.text = symptom.title
//        subtitleLabel.text = symptom.subtitle
    }
}
