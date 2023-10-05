//
//  BaseViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        configureHierarchy()
        setConstraints()
    }
    
    func configureHierarchy() {
        view.backgroundColor = Design.Color.background
    }
    
    func setNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .systemGray4
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func setConstraints() {
        
    }
}

