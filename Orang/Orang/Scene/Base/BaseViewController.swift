//
//  BaseViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        setConstraints()
    }
    
    func configureHierarchy() {
        
    }
    
    func setConstraints() {
        
    }
}

extension BaseViewController {
    func giveAlert(title: String, message: String, acceptHandler: @escaping (UIAlertAction) -> (), denyHandler: @escaping (UIAlertAction) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accpet = UIAlertAction(title: "확인", style: .default, handler: acceptHandler)
        let deny = UIAlertAction(title: "취소", style: .cancel, handler: denyHandler)
        
        alert.addAction(accpet)
        alert.addAction(deny)
        
        present(alert, animated: true)
    }
}
