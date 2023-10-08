//
//  ViewController.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit
import RealmSwift

class ProfileViewController: BaseViewController {

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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        
        let row = indexPath.row
//        cell.backgroundColor = .blue
        cell.nameLabel.text = "안녕하세요?"
        
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
