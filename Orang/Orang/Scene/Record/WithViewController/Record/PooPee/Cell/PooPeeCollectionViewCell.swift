//
//  PooPeeCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit
import M13Checkbox

final class PooPeeTableViewCell: BaseTableViewCell {
    private let outerView = UIView()
    private let dropImageView = {
        let view = UIImageView(image: UIImage(systemName: "drop.fill")?.withTintColor(.gray, renderingMode: .alwaysTemplate))
        view.contentMode = .scaleAspectFit
        return view
    }()
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
    
    private let labelStackView = UIStackView.stackViewBuilder(space: 4, axis: .vertical)
    
    var peeColor: CheckRecord<PeeColor>?
    var pooColor: CheckRecord<PooColor>?
    var pooForm: CheckRecord<PooForm>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dropImageView.tintColor = .gray
        checkbox.setCheckState(.unchecked, animated: false)
        subtitleLabel.isHidden = true
        subtitleLabel.text = ""
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(outerView)
        
        [
            dropImageView,
            labelStackView,
            checkbox
        ]
            .forEach { outerView.addSubview($0) }
        
        labelStackView.addArrangedSubviews([titleLabel, subtitleLabel])
        subtitleLabel.numberOfLines = 0
    }
    
    override func setConstraints() {
        labelStackView.distribution = .fillProportionally
        
        outerView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        dropImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.height.equalTo(20)
            make.width.equalTo(22)
            make.leading.equalTo(outerView).inset(20)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(outerView).inset(20)
            make.leading.equalTo(dropImageView.snp.trailing).offset(20)
            make.trailing.equalTo(outerView).inset(70)
        }
        
        checkbox.snp.makeConstraints { make in
            make.centerY.equalTo(outerView)
            make.height.equalTo(checkbox.snp.width)
            make.width.equalTo(25)
            make.trailing.equalTo(outerView).inset(30)
        }
    }
    
    override func configureView() {
        if let peeColor {
            dropImageView.tintColor = peeColor.type.color
            if peeColor.ischecked {
                checkbox.setCheckState(.checked, animated: true)
                subtitleLabel.isHidden = false
                subtitleLabel.text = peeColor.subtitle
            } else {
                checkbox.setCheckState(.unchecked, animated: true)
                subtitleLabel.isHidden = true
                subtitleLabel.text = peeColor.subtitle
            }
            titleLabel.text = peeColor.title
        } else if let pooColor = pooColor {
            let image = UIImage(named: Design.image.poo)?.withRenderingMode(.alwaysTemplate)
            dropImageView.image = image?.withTintColor(pooColor.type.color)
            dropImageView.contentMode = .scaleAspectFill
            dropImageView.tintColor = pooColor.type.color
            titleLabel.text = pooColor.title
            subtitleLabel.text = pooColor.subtitle
            if pooColor.ischecked {
                checkbox.setCheckState(.checked, animated: true)
                subtitleLabel.isHidden = false
            } else {
                checkbox.setCheckState(.unchecked, animated: true)
                subtitleLabel.isHidden = true
            }
        } else if let pooForm = pooForm {
            let image = UIImage(named: Design.image.poo)?.withRenderingMode(.alwaysTemplate)
            dropImageView.image = image?.withTintColor(pooForm.type.color)
            dropImageView.contentMode = .scaleAspectFill
            dropImageView.tintColor = pooForm.type.color
            titleLabel.text = pooForm.title
            subtitleLabel.text = pooForm.subtitle
            if pooForm.ischecked {
                checkbox.setCheckState(.checked, animated: true)
                subtitleLabel.isHidden = false
            } else {
                checkbox.setCheckState(.unchecked, animated: true)
                subtitleLabel.isHidden = true
            }
        }
    }
}
