//
//  AdditionalInfoViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit
import PhotosUI


final class AdditionalInfoViewController: BaseViewController, MoveToFirstScene {
    
    private let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    private let dateStackView = UIStackView.stackViewBuilder(axis: .horizontal)
    
    private let informationLabel = UILabel.labelBuilder(text: "additionalInfoInformationLabel".localized(), size: 16, weight: .semibold)
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: PicCollectionViewCell.identifier)
        view.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: AddCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private let contentTextView = UITextView.TextViewBuilder()
    
    var selectedPet: [PetTable]?
    var recordType: RecordType?
    var selectedPooColor: PooColor?
    var selectedPooForm: PooForm?
    var selectedPeeColor: PeeColor?
    var selectedSymptoms: [AbnormalSymptomsType]?
    
    var picCount: Int = 0
    
    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let repository = PetTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.loadFileURL()
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let selectedPet else {
            self.sendOneSidedAlert(title: "failFindSelectedPet".localized(), message: "failFindSelectedPetDetail".localized())
            return
        }
        guard let pet = selectedPet.first else {
            print("nopet")
            return }
        guard let date = dateTextField.text else {
            print("nodate")
            return }
        guard let time = timeTextField.text else {
            print("notime")
            return }
        guard let recordDate = "\(date) \(time)".toDateContainsTime() else { return }
        let content = contentTextView.text
        
        if let selectedPooColor { // 대변
            
            let record = RecordTable(recordType: .pooPee, petID: pet._id, recordDate: recordDate, pooColor: selectedPooColor, pooForm: selectedPooForm, content: content, images: [])
            
            var imageIdentifiers: [String] = []
            // photo 추가
            for index in images.indices {
                let identifier = "\(date)\(index)"
                imageIdentifiers.append(identifier)
                if !ImageManager.shared.saveImageToDirectory(directoryName: .dailyRecords, identifier: identifier, image: images[index]) {
                    sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
                    return
                }
            }
            record.imageArray = imageIdentifiers
            
            repository.updateRecords(id: pet._id, record)
            
            moveToFirstScene()
            
        } else if let selectedPeeColor { // 소변
            let record = RecordTable(recordType: .pooPee, petID: pet._id, recordDate: recordDate, peeColor: selectedPeeColor, content: content, images: [])
            
            var imageIdentifiers: [String] = []
            // photo 추가
            for index in images.indices {
                let identifier = "\(date)\(index)"
                imageIdentifiers.append(identifier)
                if !ImageManager.shared.saveImageToDirectory(directoryName: .dailyRecords, identifier: identifier, image: images[index]) {
                    sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
                    return
                }
            }
            record.imageArray = imageIdentifiers
            
            repository.updateRecords(id: pet._id, record)
            moveToFirstScene()
            
        } else if let selectedSymptoms { // 이상 증상
            
            let record = RecordTable(recordType: .abnormalSymptoms, petID: pet._id, recordDate: recordDate, abnormalSymptoms: selectedSymptoms, content: content, images: [])
            
            var imageIdentifiers: [String] = []
            // photo 추가
            for index in images.indices {
                let identifier = "\(date)\(index)"
                imageIdentifiers.append(identifier)
                if !ImageManager.shared.saveImageToDirectory(directoryName: .dailyRecords, identifier: identifier, image: images[index]) {
                    sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
                    return
                }
            }
            record.imageArray = imageIdentifiers
            
            repository.updateRecords(id: pet._id, record)
            print("saved!!")
            moveToFirstScene()
        }
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            dateStackView,
            informationLabel,
            collectionView,
            contentTextView
        ]
            .forEach { view.addSubview($0) }
        
        dateStackView.addArrangedSubviews([dateLabel, dateTextField, timeTextField])
    }
    
    override func setConstraints() {
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(20)
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
        configureTextField([dateTextField, timeTextField], date: dateTextField, time: timeTextField)
    }
    
}


// collectionViewSetting
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
            self.sendOneSidedAlert(title: "noMoreImagesError".localized())
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
                        self.sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            if self.images.count + images.count > 5 {
                self.sendOneSidedAlert(title: "noMoreImagesError".localized())
                return
            } else {
                picCount += images.count
                self.images.append(contentsOf: images)
            }
        }
    }
    
}


extension AdditionalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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


extension AdditionalInfoViewController: DeleteDelegate {
    func deleteImages(image: UIImage) {
        if let firstIndex = self.images.firstIndex(of: image) {
            self.images.remove(at: firstIndex)
            self.picCount -= 1
        }
    }
}

extension AdditionalInfoViewController: UIDocumentPickerDelegate {
    // 왠지는 모르겟지만 안돌아감......
    func selectFile() {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .jpeg, .webP, .rawImage], asCopy: true)
        controller.delegate = self
        controller.allowsMultipleSelection = true
        present(controller, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        var images: [UIImage] = []
        if urls.count > 5 {
            self.sendOneSidedAlert(title: "noMoreImagesError".localized())
        }
        for url in urls {
            guard let image = UIImage(contentsOfFile: url.path) else { return }
            images.append(image)
        }
        self.images = images
    }
}
