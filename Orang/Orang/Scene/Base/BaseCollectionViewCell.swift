//
//  BaseCollectionViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/10/05.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isAccessibilityElement = false
        configureHierarchy()
        setConstraints()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {
        
    }
    
    func setConstraints() {
        
    }
    
    func configureView() {
        
    }
    
    func setAccessability() {
        
    }
}
