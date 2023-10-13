//
//  AdditionalInfoViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit
import PhotosUI


final class AdditionalInfoViewController: BaseViewController {
    
    let selectedLabel = UILabel.labelBuilder(text: "선택한 증상은 다음과 같아요!", size: 16, weight: .semibold)
    
    let upperView = {
        let view = UIView()
        view.backgroundColor = Design.Color.background
        return view
    }()
    
    let upperLine = UIView()
    let lowerLine = UIView()
    
    let descriptionLabel = UILabel.labelBuilder(text: "증상을 설명해 주는 라벨이에용",size: 15, weight: .light)
    let informationLabel = UILabel.labelBuilder(text: "추가로 기록할 내용을 적어 주세요!", size: 16, weight: .semibold)
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: PicCollectionViewCell.identifier)
        view.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: AddCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let contentTextView = UITextView.TextViewBuilder()
    
    var selectedPet: [PetTable]?
    var selectedSymptoms: [Any]?
    
    var picCount: Int = 0
    
    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        let content = contentTextView.text
        
    
        // 아무튼 저장
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            selectedLabel,
            upperView,
            descriptionLabel,
            informationLabel,
            collectionView,
            contentTextView
        ]
            .forEach { view.addSubview($0) }
        
        [upperLine, lowerLine].forEach{
            upperView.addSubview($0)
            $0.backgroundColor = Design.Color.border
        }
    }
    
    override func setConstraints() {
        selectedLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
        upperView.snp.makeConstraints { make in
            make.top.equalTo(selectedLabel.snp.bottom).inset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        upperLine.snp.makeConstraints { make in
            make.top.equalTo(upperView).inset(8)
            make.horizontalEdges.equalTo(upperView).inset(20)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(upperLine.snp.bottom).offset(8)
            make.bottom.equalTo(lowerLine).inset(8)
            make.height.greaterThanOrEqualTo(40)
            make.horizontalEdges.equalTo(upperLine).inset(8)
        }
        
        lowerLine.snp.makeConstraints { make in
            make.bottom.equalTo(upperView).inset(8)
            make.horizontalEdges.equalTo(upperView).inset(20)
            make.height.equalTo(1)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(informationLabel)
            make.height.equalTo(200)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(86)
        }
    }
    
    override func configureView() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = Design.Color.border.withAlphaComponent(0.9)
    }
    
}

extension AdditionalInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let add = images.count >= 5 ? 0 : 1
        let images = images.count < 6 ? images.count : 5
        return add + images
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let add = images.count >= 5 ? 0 : 1
        let images = images.count < 6 ? images.count : 5
        if add == 1 && indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCollectionViewCell.identifier, for: indexPath) as? AddCollectionViewCell else { return UICollectionViewCell() }
            cell.configureAddButton(imagesCount: images)
            cell.delegate = self
            cell.camera.delegate = self
            return cell
        } else {
            guard images != 0 else { return UICollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.identifier, for: indexPath) as? PicCollectionViewCell else { return UICollectionViewCell() }
            
            let row = indexPath.item - add
            cell.imageView.image = self.images[row]
            cell.delegate = self
            cell.configureView()
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 4
        
        let width = (UIScreen.main.bounds.width - (space * 20)) / 5
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: space * 4 , bottom: 0, right: space * 4)
        
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension AdditionalInfoViewController: PHPickerViewControllerDelegate, AddDelegate {
    func openPhotoAlbum() {
        
        if 5 - picCount < 1 {
            self.sendOneSidedAlert(title: "사진은 5장까지 추가할 수 있습니다!")
        }
        var config = PHPickerConfiguration()
        
        config.filter = .images
        config.selectionLimit = 5 - picCount
        config.selection = .ordered
        
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let dispatchGroup = DispatchGroup()
        
        var images = [UIImage]()
        
        for result in results {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                let type: NSItemProviderReading.Type = UIImage.self
                itemProvider.loadObject(ofClass: type) { [weak self](image, error) in
                    guard let self = self else { return }
                    if let image = image as? UIImage {
                        images.append(image)
                        dispatchGroup.leave()
                    } else {
                        // 다시 시도 Alert
                        print(error?.localizedDescription)
                        self.sendOneSidedAlert(title: "이미지를 저장할 수 없습니다!", message: "한 번 더 시도해 주세요!")
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            if self.images.count + images.count > 5 {
                self.sendOneSidedAlert(title: "사진은 5장까지 추가할 수 있어요!")
                return
            } else {
                picCount += images.count
                self.images.append(contentsOf: images)
            }
        }
    }
    
}


extension AdditionalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhoto(_ sender: UIImagePickerController) {
        present(sender, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.images.append(image)
            picCount += 1
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func selectFile() {
        
    }
    
}


extension AdditionalInfoViewController: DeleteDelegate {
    func deleteImages(image: UIImage) {
        if let firstIndex = self.images.firstIndex(of: image) {
            self.images.remove(at: firstIndex)
            self.picCount -= 1
        }
    }
}
