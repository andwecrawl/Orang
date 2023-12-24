//
//  CalendarView.swift
//  Orang
//
//  Created by yeoni on 2023/10/19.
//

import UIKit
import FSCalendar

final class CalendarView: BaseView {
    
    let innerView = UIView()
    lazy var outerView = {
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let calendarLabel = UILabel.labelBuilder(text: "YYYY년 MM월", size: 18, weight: .bold, color: Design.Color.buttonContent, alignment: .left)
    
    lazy var previousButton : UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.accessibilityLabel = "accessibilityHint_previousButton".localized()
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.accessibilityLabel = "accessibilityHint_nextButton".localized()
        button.setImage(image, for: .normal)
        return button
    }()
    
    let monthlyStackView = UIStackView.stackViewBuilder(space: 8, axis: .horizontal)
    
    lazy var calendar = FSCalendar()
    
    
    override func configureHierarchy() {
        
        self.addSubview(outerView)
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
        
        [
            monthlyStackView,
            calendar
        ]
            .forEach { innerView.addSubview($0) }
        
        monthlyStackView.addArrangedSubviews([calendarLabel, previousButton, nextButton])
    }
    
    
    override func setConstraints() {
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        monthlyStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        [previousButton, nextButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height).multipliedBy(0.8)
                make.centerY.equalToSuperview()
            }
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(monthlyStackView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    
    
}
