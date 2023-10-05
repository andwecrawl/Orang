//
//  ViewController+.swift
//  Orang
//
//  Created by yeoni on 2023/10/05.
//

import UIKit

extension UIViewController {
    func sendActionAlert(title: String, message: String, acceptHandler: @escaping (UIAlertAction) -> (), denyHandler: @escaping (UIAlertAction) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let accpet = UIAlertAction(title: "확인", style: .default, handler: acceptHandler)
        let deny = UIAlertAction(title: "취소", style: .cancel, handler: denyHandler)
        
        alert.addAction(accpet)
        alert.addAction(deny)
        
        present(alert, animated: true)
    }
    
    
    func sendOneSidedAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true)
    }
}


