//
//  SettingViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/20.
//

import UIKit

enum Setting: String, CaseIterable {
//    case alertSettings
    case backup = "기록 백업"
    case bugReport = "버그, 오류 제보"
    case emailToDeveloper = "개발자에게 문의"
    case information = "개인정보 처리방침"
}

class SettingViewController: BaseViewController {
    
    private lazy var tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    let settingList = Setting.allCases
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        title = "환경 설정"
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}


// tableview Setting
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = settingList[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        var vc: UIViewController
        let settingType = settingList[row]
        
        switch settingType {
            
        case .backup:
            vc = BackupViewController()
            
        default:
            vc = WVViewController()
            guard let vc = vc as? WVViewController else { return }
            vc.settingType = settingType
            
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        navigationController?.pushViewController(vc, animated: true)
    }
}
