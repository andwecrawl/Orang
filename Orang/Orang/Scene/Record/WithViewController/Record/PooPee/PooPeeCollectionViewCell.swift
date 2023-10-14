//
//  PooPeeCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit
import M13Checkbox

final class PooPeeTableViewCell: BaseTableViewCell {
    let dropImageView = {
        let view = UIImageView(image: UIImage(systemName: "drop.fill")?.withTintColor(.gray, renderingMode: .alwaysTemplate))
        return view
    }()
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
    
    var peeColor: CheckRecord<PeeColor>?
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            dropImageView,
            labelStackView,
            checkbox
        ]
            .forEach { self.addSubview($0) }
        
        labelStackView.AddArrangedSubviews([titleLabel, subtitleLabel])
        subtitleLabel.numberOfLines = 0
    }
    
    override func setConstraints() {
        labelStackView.distribution = .fillProportionally
        
        dropImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(25)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(20)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.leading.equalTo(dropImageView.snp.trailing).offset(20)
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
        guard let peeColor else { return }
        dropImageView.tintColor = peeColor.type.color
        titleLabel.text = peeColor.title
        subtitleLabel.text = peeColor.subtitle
        if peeColor.ischecked {
            checkbox.setCheckState(.checked, animated: true)
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
        }
    }
}
