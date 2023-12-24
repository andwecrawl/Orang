//
//  BaseTableViewCell.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        isAccessibilityElement = false
        configureHierarchy()
        setConstraints()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configureHierarchy() {
        self.backgroundColor = Design.Color.background
    }
    
    func setConstraints() {
        
    }
    
    func configureView() {
        
    }
    
    func setAccessibility() {
        
    }
}
