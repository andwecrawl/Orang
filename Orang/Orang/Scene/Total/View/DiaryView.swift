//
//  DailyRecordView.swift
//  Orang
//
//  Created by yeoni on 2023/10/19.
//

import UIKit

final class DiaryView: BaseView {
    
    private let innerView = UIView()
    private lazy var outerView = {
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    var recordLabel = UILabel.labelBuilder(text: "일상 기록", size: 18, weight: .bold, color: Design.Color.buttonContent, alignment: .left)
    
    let tableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = .clear
        view.register(DailyTempTableViewCell.self, forCellReuseIdentifier: DailyTempTableViewCell.identifier)
        view.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        view.rowHeight = 80
        return view
    }()
    
    
    override func configureHierarchy() {
        self.addSubview(outerView)
        UIView.addOuterShadowAndRadius(outerView: outerView, innerView: innerView)
        
        [
            recordLabel,
            tableView
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recordLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(80)
            make.bottom.equalToSuperview().inset(20)
        }
        
        
        
    }
    
}
