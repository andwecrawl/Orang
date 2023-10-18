//
//  TotalViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit

class TotalViewController: BaseViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configurePinterestLayout())
    
    

    var selectedDate: DateComponents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        title = "모아보기"
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.backgroundColor = Design.Color.background
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        
        
        [
        ]
            .forEach { contentView.addSubview($0) }
        
    }
    
    override func setConstraints() {
    }
    
    override func configureView() {
    }

}

extension TotalViewController: UICollectionViewDelegate {
    func configurePinterestLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        // 수직 스크롤에 대한 대응까지는 온 상태!!
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration = config
        
        return layout
        
    }
}
