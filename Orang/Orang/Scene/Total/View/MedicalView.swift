//
//  MedicalView.swift
//  Orang
//
//  Created by yeoni on 2023/10/20.
//

import UIKit

final class MedicalView: BaseView {
    
    private let innerView = UIView()
    private lazy var outerView = {
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let medicalRecordLabel = UILabel.labelBuilder(text: "진료 기록", size: 18, weight: .bold, alignment: .left)
    
    
    override func configureHierarchy() {
        self.addSubview(outerView)
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
        
        [
            medicalRecordLabel
        ]
            .forEach { innerView.addSubview($0) }
        
    }
    
    override func setConstraints() {
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        medicalRecordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(30)
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
