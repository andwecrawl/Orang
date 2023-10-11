//
//  WithViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit
import RealmSwift

class WithViewController: BaseViewController {
    
    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(ChoosePetCollectionViewCell.self, forCellWithReuseIdentifier: ChoosePetCollectionViewCell.identifier)
        return view
    }()
    
    var selectedPet: [PetTable] = []
    
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
        
        title = "어떤 아이와의 기록인가요?"
        
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func nextButtonClicked() {
        let vc = DiaryViewController()
        if selectedPet.isEmpty {
            sendOneSidedAlert(title: "함께한 아이를 선택해 주세요!")
        }
        vc.selectedPet = selectedPet
        navigationController?.pushViewController(vc, animated: true)
        
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
        cell.nameLabel.text = pet.name
        let image = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
        cell.imageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? ChoosePetCollectionViewCell else { return }
        let pet = list[indexPath.item]
        if selectedPet.contains(pet) {
            if let index = selectedPet.firstIndex(of: pet) {
                selectedPet.remove(at: index)
            }
            item.imageView.layer.borderColor = Design.Color.tintColor?.cgColor
        } else {
            selectedPet.append(pet)
            item.imageView.layer.borderColor = Design.Color.border.cgColor
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
