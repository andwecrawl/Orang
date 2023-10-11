//
//  DiaryViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit
import PhotosUI

class DiaryViewController: BaseViewController {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: PicCollectionViewCell.identifier)
        view.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: AddCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let titleTextField = UnderLineTextField.textFieldBuilder(placeholder: "제목을 입력해 주세요!")
    let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "일상 기록 추가하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            collectionView,
            titleTextField,
            contentTextView
        ]
            .forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(96)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(titleTextField)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
    
    override func configureView() {
    }
    
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        if section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCollectionViewCell.identifier, for: indexPath) as? AddCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
            
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.identifier, for: indexPath) as? PicCollectionViewCell else { return UICollectionViewCell() }
            cell.imageView.backgroundColor = .black
            cell.completionHandler = {
                // 해당 imageView 삭제하는 코드 작성
            }
            return cell
        }
    }
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        
        layout.itemSize = CGSize(width: 80, height: 80)
        
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .horizontal
        return layout
    }
}


extension DiaryViewController: PHPickerViewControllerDelegate {
    @objc func profileImageButtonClicked() {
        // picker 기본 설정!!
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                let type: NSItemProviderReading.Type = UIImage.self
                result.itemProvider.loadObject(ofClass: type) { [weak self](image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.images?.append(image)
                        }
                    } else {
                        // 다시 시도 Alert
                        print(error)
                        self?.sendOneSidedAlert(title: "이미지를 저장할 수 없습니다!", message: "한 번 더 시도해 주세요!")
                    }
                }
            }
        }
    }
}
