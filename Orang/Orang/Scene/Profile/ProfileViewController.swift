//
//  ViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit
import RealmSwift

final class ProfileViewController: BaseViewController {

    let collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        view.keyboardDismissMode = .onDrag
        view.backgroundColor = Design.Color.background
        return view
    }()
    
    let repository = PetTableRepository()
    var list: Results<PetTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = repository.fetch()
        repository.loadFileURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        
        let row = indexPath.row
        cell.pet = list[row]
        cell.configureView()
        
        return cell
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 20
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - space * 2, height: 200)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("here")
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        let pet = list[indexPath.item]
        
        let modify = UIAction(title: "modifiy".localized(), image: UIImage(systemName: "pencil")) { _ in
            let vc = AddViewController()
            vc.pet = pet
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let delete = UIAction(title: "delete".localized(), image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
            self.sendActionAlert(title: "deleteTitle %@".localized(with: pet.name), message: "deleteSubscript %@".localized(with: pet.name)) { _ in
                ImageManager.shared.removeImageFromDirectory(directoryName: .profile, identifier: pet.profileImage)
                self.repository.delete(pet)
                collectionView.reloadData()
            } denyHandler: { _ in }
        }

        let menuConfiguration = UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(children: [modify, delete])
        })
        return menuConfiguration
    }
}
