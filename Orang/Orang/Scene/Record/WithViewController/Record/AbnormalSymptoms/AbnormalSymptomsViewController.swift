//
//  AbnormalSymptomsViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

final class AbnormalSymptomsViewController: BaseViewController {
    
    private lazy var tableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AbnormalSymptomsTableViewCell.self, forCellReuseIdentifier: AbnormalSymptomsTableViewCell.identifier)
        view.rowHeight = 60
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var selectedPet: [PetTable]?
    
    var viewModel = SymptomsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "AbnormalSymptomsNavigationTitle".localized()
        
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
        

    }
    
    @objc func nextButtonClicked() {
        let vc = AdditionalInfoViewController()
        vc.title = "moreSymptomsTitle".localized()
        vc.recordType = .abnormalSymptoms
        vc.selectedPet = selectedPet
        
        viewModel.checkValidations { symptoms in
            if let symptoms {
                vc.selectedSymptoms = symptoms
            } else {
                sendOneSidedAlert(title: "plzSelectAbnormalSymptoms".localized())
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(tableView)
        
    }
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        
        viewModel.fetchSymptoms()
        
        viewModel.list.bind { _ in
            self.tableView.reloadData()
        }
        
    }
}

extension AbnormalSymptomsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AbnormalSymptomsTableViewCell.identifier, for: indexPath) as? AbnormalSymptomsTableViewCell else { return UITableViewCell() }
        
        cell.symptom = viewModel.cellForRowAt(at: indexPath)
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath)
    }
}
