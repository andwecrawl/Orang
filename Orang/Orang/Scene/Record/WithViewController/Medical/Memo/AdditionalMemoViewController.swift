//
//  AdditionalMemoViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/15.
//

import UIKit
import PhotosUI


final class AdditionalMemoViewController: BaseViewController, MoveToFirstScene {
    
    private let informationLabel = UILabel.labelBuilder(text: "추가로 기록할 내용을 적어 주세요!", size: 16, weight: .semibold)
    
    private lazy var collectionView = {
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
    var recordType: RecordType?
    var selectedSymptoms: [Any]?
    var hospital: String?
    var treatmentDate: Date?
    var vaccineTypes: [String]?
    
    var picCount: Int = 0
    
    var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let repository = PetTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(vaccineTypes)
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    @objc func saveButtonClicked() {
        guard let pet = selectedPet?.first else { return }
        guard let hospital else { return }
        guard let treatmentDate else { return }
        guard let vaccineTypes else { return }
        let content = contentTextView.text
        
        let record = MedicalRecordTable(hospital: hospital, petId: pet._id, treatmentDate: treatmentDate, recordType: .vaccine, vaccineType: vaccineTypes, content: content, imageArray: [])
        var imageIdentifiers: [String] = []
        // photo 추가
        let date = record.createdDate
        for index in images.indices {
            let identifier = "\(date)\(index)"
            imageIdentifiers.append(identifier)
            if !ImageManager.shared.saveImageToDirectory(directoryName: .dailyRecords, identifier: identifier, image: images[index]) {
                sendOneSidedAlert(title: "이미지 저장에 실패했습니다.", message: "다시 시도해 주세요!")
                return
            }
        }
        record.imageArray = imageIdentifiers
        
        repository.updateMedicalRecords(id: pet._id, record)
        
        print("saved!!")
        moveToFirstScene()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            informationLabel,
            collectionView,
            contentTextView
        ]
            .forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(informationLabel)
            make.height.equalTo(200)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(86)
        }
    }
    
    override func configureView() {
        informationLabel.numberOfLines = 0
    }
    
}



// CollectionView Setting
extension AdditionalMemoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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


// deleteImage
extension AdditionalMemoViewController: DeleteDelegate {
    func deleteImages(image: UIImage) {
        if let firstIndex = self.images.firstIndex(of: image) {
            self.images.remove(at: firstIndex)
            self.picCount -= 1
        }
    }
}


// Bring Images from PhotoAlbum
extension AdditionalMemoViewController: PHPickerViewControllerDelegate, AddDelegate {
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


// Camera
extension AdditionalMemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
}


// fileApp
extension AdditionalMemoViewController: UIDocumentPickerDelegate {
    // 왠지는 모르겟지만 안돌아감......
    func selectFile() {
        print("hello?")
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .jpeg, .webP, .rawImage], asCopy: true)
        controller.delegate = self
        controller.allowsMultipleSelection = true
        present(controller, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        var images: [UIImage] = []
        if urls.count > 5 {
            self.sendOneSidedAlert(title: "이미지를 5개 이상 첨부할 수 없습니다!")
        }
        for url in urls {
            guard let image = UIImage(contentsOfFile: url.path) else { return }
            images.append(image)
        }
        self.images = images
    }
}
