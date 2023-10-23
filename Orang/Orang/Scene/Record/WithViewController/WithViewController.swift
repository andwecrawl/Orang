//
//  WithViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit
import RealmSwift

final class WithViewController: BaseViewController {
    
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(ChoosePetCollectionViewCell.self, forCellWithReuseIdentifier: ChoosePetCollectionViewCell.identifier)
        return view
    }()
    
    var selectedPet: [PetTable] = []
    
    var recordType: RecordType?
    let repository = PetTableRepository()
    var list: Results<PetTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = repository.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "withNavigationTitle".localized()
        
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func nextButtonClicked() {
        guard let recordType else { return }
        if selectedPet.isEmpty {
            sendOneSidedAlert(title: "noSelectedPet".localized())
        }
        switch recordType {
        case .diary:
            let vc = DiaryViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .weight:
            let vc = WeightRecordViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .snack:
            let vc = FeedViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .pooPee:
            let vc = PooPeeViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .abnormalSymptoms:
            let vc = AbnormalSymptomsViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .vaccine:
            let vc = VaccineViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        case .medicalHistory:
            let vc = MedicalHistoryViewController()
            vc.selectedPet = selectedPet
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension WithViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoosePetCollectionViewCell.identifier, for: indexPath) as? ChoosePetCollectionViewCell else { return UICollectionViewCell() }
        let pet = list[indexPath.item]
        cell.recordType = recordType
        cell.pet = pet
        if selectedPet.contains(pet) {
            cell.isSelectedPet = true
        } else {
            cell.isSelectedPet = false
        }
        cell.configureView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? ChoosePetCollectionViewCell else { return }
        let pet = list[indexPath.item]
        if recordType == .diary {
            if selectedPet.contains(pet) {
                if let index = selectedPet.firstIndex(of: pet) {
                    selectedPet.remove(at: index)
                }
                item.imageView.layer.borderColor = Design.Color.border.cgColor
            } else {
                selectedPet.append(pet)
                item.imageView.layer.borderColor = Design.Color.tintColor.cgColor
            }
        } else {
            if selectedPet.isEmpty {
                selectedPet.append(pet)
                collectionView.reloadItems(at: [indexPath])
            } else {
                if selectedPet.contains(pet) {
                    selectedPet.removeAll()
                    collectionView.reloadItems(at: [indexPath])
                } else {
                    selectedPet.removeAll()
                    selectedPet.append(pet)
                    collectionView.reloadData()
                }
            }
        }
    }
    
    
    static func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        
        let width = (UIScreen.main.bounds.width - (space * 4)) / 3
        layout.itemSize = CGSize(width: width, height: width + 10)
        layout.sectionInset = UIEdgeInsets(top: space, left: 8, bottom: space, right: space)
        
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .vertical
        return layout
    }
}
