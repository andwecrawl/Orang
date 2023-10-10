//
//  AbnormalSymptomsViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

class AbnormalSymptomsViewController: BaseViewController {
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "이상 증상 기록하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        

    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            tableView
        ]
            .forEach { view.addSubview($0) }
        
    }
    
    
    override func setConstraints() {
        
    }
    
    
    override func configureView() {
        
    }
}
