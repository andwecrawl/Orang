//
//  DailyView.swift
//  Orang
//
//  Created by yeoni on 2023/10/20.
//

import UIKit

final class DailyView: BaseView {
    
    private let innerView = UIView()
    private lazy var outerView = {
        let view = UIView.shadowViewBuilder(innerView: innerView)
        return view
    }()
    
    let dailyRecordLabel = UILabel.labelBuilder(text: "생활 기록", size: 18, weight: .bold, alignment: .left)
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(DailyRecordCollectionViewCell.self, forCellWithReuseIdentifier: DailyRecordCollectionViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        
        self.addSubview(outerView)
        
        [
            dailyRecordLabel,
            collectionView
        ]
            .forEach { innerView.addSubview($0) }
        
    }
    
    override func setConstraints() {
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dailyRecordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dailyRecordLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
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
    
    
    func setCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
