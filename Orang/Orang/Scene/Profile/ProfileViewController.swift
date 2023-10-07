//
//  ViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit

class ProfileViewController: BaseViewController {

    private let tableView = {
        let view = UITableView(frame: .zero)
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.rowHeight = 230
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "Profile"
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingButtonClicked))
        navigationItem.rightBarButtonItems = [settingButton, addButton]
    }
    
    @objc private func addButtonClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func settingButtonClicked() {
        
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
        let modify = UIAction(title: "수정하기", image: UIImage(systemName: "pencil")) { _ in
            // 수정 ViewController
            print("수정하깅")
        }
        let delete = UIAction(title: "삭제하기", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            self.sendActionAlert(title: "해당 데이터를 삭제하시겠어요?", message: "삭제할 경우 일정 및 모든 아이 데이터가 사라지며 복구가 불가능합니다!") { _ in
                // 삭제하는 코드
                print("진짜진짜삭제")
            } denyHandler: { _ in }
        }
        
        let menuConfiguration = UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(title: "쩨에 대한", children: [modify, delete])
        })
        return menuConfiguration
    }
}
