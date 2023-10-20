//
//  EmptyView.swift
//  Orang
//
//  Created by yeoni on 2023/10/20.
//

import UIKit

final class EmptyView: BaseView {
    
    private let innerView = UIView()
    private lazy var outerView = {
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let recordLabel = UILabel.labelBuilder(text: "오늘의 기록", size: 18, weight: .bold, alignment: .left)
    
    let informationLabel = UILabel.labelBuilder(text: "기록하기 탭에서\n아이의 기록을 새롭게 추가해 보세요!", size: 16, weight: .light, alignment: .center)
    
    override func configureHierarchy() {
        self.addSubview(outerView)
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
        
        [
            recordLabel,
            informationLabel
        ]
            .forEach { innerView.addSubview($0) }
        
    }
    
    override func setConstraints() {
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        recordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        informationLabel.numberOfLines = 0
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recordLabel.snp.bottom).offset(40)
        }
        
        /*
         tableView.snp.makeConstraints { make in
             make.top.equalTo(diaryRecordLabel.snp.bottom).offset(12)
             make.horizontalEdges.equalToSuperview().inset(16)
             make.height.greaterThanOrEqualTo(90)
             make.bottom.equalToSuperview().inset(20)
         }
         */
    }
    
    
}
