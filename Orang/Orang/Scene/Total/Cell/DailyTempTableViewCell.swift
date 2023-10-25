//
//  DailyTempTableViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/20.
//

import UIKit

class DailyTempTableViewCell: BaseTableViewCell {
    
    let diaryImageView = UIImageView.imageViewBuilder(size: 60)
    let tempView = UIImageView.imageViewBuilder(size: 24)
    let typeImageView = UIImageView.imageViewBuilder(size: 20)

    let titleLabel = UILabel.labelBuilder(text: "제목입니당", size: 15, weight: .semibold, alignment: .left)
    let subtitleLabel = UILabel.labelBuilder(text: "서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당서브타이틀입니당", size: 14, weight: .regular, alignment: .justified)
    
    let textStackView = UIStackView.stackViewBuilder(space: 2, axis: .vertical)
    
    let arrowImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "greaterthan")
        view.tintColor = Design.Color.tintColor
        return view
    }()
    
    override func configureHierarchy() {
        self.backgroundColor = .clear
        
        [
            diaryImageView,
            tempView,
            typeImageView,
            textStackView,
            arrowImageView
        ]
            .forEach { self.addSubview($0) }
        
        textStackView.addArrangedSubviews([titleLabel, subtitleLabel])
    }
    
    override func setConstraints() {
        diaryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
        }
        
        tempView.snp.makeConstraints { make in
            make.bottom.equalTo(diaryImageView.snp.bottom).offset(2)
            make.trailing.equalTo(diaryImageView.snp.trailing).offset(2)
        }
        
        typeImageView.snp.makeConstraints { make in
            make.center.equalTo(tempView)
        }
        
        textStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(diaryImageView.snp.trailing).offset(14)
            make.trailing.equalToSuperview().inset(36)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.equalTo(10)
            make.height.equalTo(20)
        }
    }

    override func configureView() {
        textStackView.distribution = .equalSpacing
        
        typeImageView.contentMode = .scaleAspectFit
        tempView.backgroundColor = .white
        diaryImageView.backgroundColor = .gray
        titleLabel.numberOfLines = 1
        subtitleLabel.numberOfLines = 2
    }
    
}
