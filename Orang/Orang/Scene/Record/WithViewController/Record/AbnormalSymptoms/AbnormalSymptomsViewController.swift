//
//  AbnormalSymptomsViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

final class AbnormalSymptomsViewController: BaseViewController {
    
    lazy var tableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AbnormalSymptomsTableViewCell.self, forCellReuseIdentifier: AbnormalSymptomsTableViewCell.identifier)
        view.rowHeight = UITableView.automaticDimension
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var selectedPet: [PetTable]?
    var list: [CheckRecord<AbnormalSymptomsType>] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "이상 증상 기록하기"
        
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
        

    }
    
    @objc func nextButtonClicked() {
        let vc = AdditionalInfoViewController()
        vc.title = "추가적인 증상이 있나요?"
        var selectedSymptoms: [AbnormalSymptomsType] = []
        list.forEach{
            if $0.ischecked {
                selectedSymptoms.append($0.type)
            }
        }
        if selectedSymptoms.isEmpty { sendOneSidedAlert(title: "이상 증상을 선택해 주세요!") }
        vc.recordType = .abnormalSymptoms
        vc.selectedSymptoms = selectedSymptoms
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        AbnormalSymptomsType.allCases.forEach{ self.list.append(CheckRecord(type: $0)) }
        
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
