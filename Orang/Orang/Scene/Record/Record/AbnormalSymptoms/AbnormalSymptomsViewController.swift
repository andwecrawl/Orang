//
//  AbnormalSymptomsViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

class AbnormalSymptomsViewController: BaseViewController {
    
    lazy var tableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AbnormalSymptomsTableViewCell.self, forCellReuseIdentifier: AbnormalSymptomsTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var list: [AbnormalSymptoms] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "이상 증상 기록하기"
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
        

    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        AbnormalSymptomsType.allCases.forEach{ self.list.append(AbnormalSymptoms(type: $0)) }
        
        [
            tableView
        ]
            .forEach { view.addSubview($0) }
        
    }
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        
    }
}

extension AbnormalSymptomsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AbnormalSymptomsTableViewCell.identifier, for: indexPath) as? AbnormalSymptomsTableViewCell else { return UITableViewCell() }
        let symptom = list[indexPath.row]
        cell.symptom = symptom
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AbnormalSymptomsTableViewCell.identifier, for: indexPath) as? AbnormalSymptomsTableViewCell else { return }
        cell.symptom?.ischecked.toggle()
        list[indexPath.row].ischecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
