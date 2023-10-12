//
//  AbnormalSymptomsTableViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/11.
//

import UIKit
import M13Checkbox

final class AbnormalSymptomsTableViewCell: BaseTableViewCell {
    
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
    
    let labelStackView = UIStackView.stackViewBuilder(space: 4, axis: .vertical)
    let horizontalStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    var symptom: AbnormalSymptoms?
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(horizontalStackView)
        
        labelStackView.AddArrangedSubviews([titleLabel, subtitleLabel])
        horizontalStackView.AddArrangedSubviews([labelStackView, checkbox])
    }
    
    override func setConstraints() {
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        checkbox.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(checkbox.snp.width)
            make.width.equalTo(30)
        }
        
        horizontalStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(30)
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
    }
}
