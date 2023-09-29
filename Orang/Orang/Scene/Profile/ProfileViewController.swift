//
//  ViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class ProfileViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        title = "Profile"
        view.addSubview(tableView)
    }
    
    func setNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.rightBarButtonItems = [settingButton, addButton]
    }
    
    @objc func addButtonClicked() {
        
    }
    
    @objc func settingButtonClicked() {
        
    }

    override func setConstraints() {
    }
}

    
}
