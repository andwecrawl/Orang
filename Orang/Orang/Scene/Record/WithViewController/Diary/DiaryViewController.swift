//
//  DiaryViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit
import PhotosUI


final class DiaryViewController: BaseViewController, MoveToFirstScene {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: PicCollectionViewCell.identifier)
        view.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: AddCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let titleTextField = UnderLineTextField.textFieldBuilder(placeholder: "제목을 입력해 주세요!")
    let contentTextView = UITextView.TextViewBuilder()
    
    var selectedPet: [PetTable]?
    var picCount: Int = 0
    let repository = PetTableRepository()
    
    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.loadFileURL()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "일상 기록 추가하기"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let pet = selectedPet?.first else { return }
        guard let title = titleTextField.text else {
            titleTextField.setError()
            sendOneSidedAlert(title: "제목을 입력해 주세요!")
            return
        }
        if images.isEmpty {
            sendOneSidedAlert(title: "이미지를 하나 이상 등록해 주세요!")
            return
        }
        let content = contentTextView.text
        let date = Date()
        
        let record = RecordTable(recordType: .diary, petID: pet._id, recordDate: date, title: title, content: content, images: [])
        
        var imageIdentifiers: [String] = []
        // photo 추가
        for index in images.indices {
            let identifier = "\(date)\(index)"
            imageIdentifiers.append(identifier)
            if !ImageManager.shared.saveImageToDirectory(directoryName: .diaries, identifier: identifier, image: images[index]) {
                sendOneSidedAlert(title: "이미지 저장에 실패했습니다.", message: "다시 시도해 주세요!")
                return
            }
        }
        record.imageArray = imageIdentifiers
        
        repository.updateRecords(id: pet._id, record)
        moveToFirstScene()
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
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(300)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(86)
        }
    }
    
    override func configureView() {
        
    }
    
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

extension DiaryViewController: PHPickerViewControllerDelegate, AddDelegate {
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


extension DiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhoto() {
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = false
        camera.cameraDevice = .rear
        camera.cameraCaptureMode = .photo
        camera.delegate = self
        present(camera, animated: true, completion: nil)
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


extension DiaryViewController: DeleteDelegate {
    func deleteImages(image: UIImage) {
        if let firstIndex = self.images.firstIndex(of: image) {
            self.images.remove(at: firstIndex)
            self.picCount -= 1
        }
    }
}
