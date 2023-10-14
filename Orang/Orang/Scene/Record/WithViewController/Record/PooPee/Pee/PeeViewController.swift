//
//  PeeViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

final class PeeViewController: BaseViewController {
    
    lazy var tableView = {
        let view = UITableView(frame: .zero)
        view.register(PooPeeTableViewCell.self, forCellReuseIdentifier: PooPeeTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var list: [CheckRecord<PeeColor>] = []
    var selectedPet: [PetTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "pooPeeTitle".localized()
        
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
        

    }
    
    @objc func nextButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
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
        
        PeeColor.allCases.forEach{ self.list.append(CheckRecord(type: $0)) }
    }
}

extension PeeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PooPeeTableViewCell.identifier, for: indexPath) as? PooPeeTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        cell.peeColor = list[row]
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        list[row].ischecked.toggle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
