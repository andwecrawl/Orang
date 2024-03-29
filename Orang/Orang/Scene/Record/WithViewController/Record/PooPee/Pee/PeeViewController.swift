//
//  PeeViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

final class PeeViewController: BaseViewController {
    
    private lazy var tableView = {
        let view = UITableView(frame: .zero)
        view.register(PooPeeTableViewCell.self, forCellReuseIdentifier: PooPeeTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var list: [CheckRecord<PeeColor>] = []
    var selectedPet: [PetTable]?
    var selectedPeeColor: CheckRecord<PeeColor>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PooPeeTableViewCell.identifier, for: indexPath) as? PooPeeTableViewCell else { return }
        let row = indexPath.row
        if list.filter({ $0.ischecked == true }).isEmpty { // 하나도 체크 X
            cell.peeColor?.ischecked.toggle()
            list[row].ischecked.toggle()
            selectedPeeColor = list[row]
            tableView.reloadData()
        } else { // 체크된 게 있을 때
            if list[row].ischecked == true { // 같은 걸 다시 선택했을 때 => 취소
                cell.peeColor?.ischecked.toggle()
                list[row].ischecked.toggle()
                selectedPeeColor = nil
                tableView.reloadData()
            } else {
                for index in list.indices {
                    list[index].ischecked = false
                }
                cell.peeColor?.ischecked = true
                list[row].ischecked = true
                selectedPeeColor = list[row]
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
