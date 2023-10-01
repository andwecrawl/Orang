//
//  ViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class ProfileViewController: BaseViewController {

    let tableView = {
        let view = UITableView(frame: .zero)
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.rowHeight = 230
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        title = "Profile"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.rightBarButtonItems = [settingButton, addButton]
    }
    
    @objc func addButtonClicked() {
        let vc = addViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func settingButtonClicked() {
        
    }

    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked!")
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let modify = UIAction(title: "수정하기") { _ in
            // 수정 ViewController
            print("수정하깅")
        }
        let delete = UIAction(title: "삭제하기") { _ in
            // 삭제 Alert 띄움
            print("삭제하깅")
        }
        
        let menuConfiguration = UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(title: "", children: [modify, delete])
        })
        return menuConfiguration
    }
}
