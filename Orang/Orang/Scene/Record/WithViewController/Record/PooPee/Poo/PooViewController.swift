//
//  PooViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

final class PooViewController: BaseViewController {
    
    lazy var tableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(PooPeeTableViewCell.self, forCellReuseIdentifier: PooPeeTableViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var colorList: [CheckRecord<PooColor>] = []
    var formList: [CheckRecord<PooForm>] = []
    var selectedPet: [PetTable]?
    var selectedPoo: CheckRecord<PooColor>?
    var selectedForm: CheckRecord<PooForm>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        PooColor.allCases.forEach{ self.colorList.append(CheckRecord(type: $0)) }
        PooForm.allCases.forEach{ self.formList.append(CheckRecord(type: $0)) }
        print(formList)
    }
}

extension PooViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "대변 색깔"
        } else {
            return "대변 형태"
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedPoo?.type == PooColor.none {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return colorList.count
        } else {
            return formList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PooPeeTableViewCell.identifier, for: indexPath) as? PooPeeTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        if section == 0 {
            cell.pooColor = colorList[row]
            cell.pooForm = nil
        } else {
            cell.pooColor = nil
            cell.pooForm = formList[row]
        }
        cell.configureView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            if colorList[row].ischecked == true {
                colorList[row].ischecked.toggle()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                for index in colorList.indices {
                    colorList[index].ischecked = false
                }
                selectedPoo = colorList[row]
                colorList[row].ischecked.toggle()
                tableView.reloadData()
                if selectedPoo?.type != PooColor.none {
                    tableView.scrollToRow(at: [1, 0], at: .top, animated: true)
                }
            }
        } else {
            if formList[row].ischecked == true {
                formList[row].ischecked.toggle()
                selectedForm = formList[row]
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                for index in formList.indices {
                    formList[index].ischecked = false
                }
                formList[row].ischecked.toggle()
                selectedForm = formList[row]
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
