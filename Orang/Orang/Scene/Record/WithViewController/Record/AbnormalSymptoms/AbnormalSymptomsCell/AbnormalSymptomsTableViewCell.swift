//
//  AbnormalSymptomsTableViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/11.
//

import UIKit
import M13Checkbox

final class AbnormalSymptomsTableViewCell: BaseTableViewCell {
    
    private let titleLabel = UILabel.labelBuilder(text: "타이틀입니당", size: 15, weight: .bold)
    private let subtitleLabel = UILabel.labelBuilder(text: "서브타이틀입니당", size: 13, weight: .regular)
    
    private let checkbox = {
        let button = M13Checkbox(frame: .zero)
        button.stateChangeAnimation = .bounce(.fill) // orFlat
        button.markType = .checkmark
        button.checkState = .unchecked
        button.tintColor = Design.Color.tintColor
        return button
    }()
    
    private let labelStackView = UIStackView.stackViewBuilder(space: 2, axis: .vertical)
    var symptom: CheckRecord<AbnormalSymptomsType>?
    
    override func prepareForReuse() {
        checkbox.setCheckState(.unchecked, animated: false)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(labelStackView)
        self.addSubview(checkbox)
        
        labelStackView.addArrangedSubviews([titleLabel, subtitleLabel])
    }
    
    override func setConstraints() {
        labelStackView.distribution = .equalSpacing
        
        subtitleLabel.numberOfLines = 0
        labelStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(24)
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
        guard let symptom else { return }
        if symptom.ischecked {
            checkbox.setCheckState(.checked, animated: true)
        } else {
            checkbox.setCheckState(.unchecked, animated: true)
        }
        titleLabel.text = symptom.title
        subtitleLabel.text = symptom.subtitle
        if symptom.subtitle.isEmpty {
            subtitleLabel.isHidden = true
        } else {
            subtitleLabel.isHidden = false
        }
    }
}
