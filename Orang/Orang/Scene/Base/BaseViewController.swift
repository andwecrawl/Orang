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
        configureView()
    }
    
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func configureHierarchy() {
        view.backgroundColor = Design.Color.background
    }
    
    func configureView() {
        
    }
    
    func setConstraints() {
        
    }
}

