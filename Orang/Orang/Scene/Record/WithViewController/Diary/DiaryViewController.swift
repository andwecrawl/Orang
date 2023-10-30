//
//  DiaryViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit
import PhotosUI

final class DiaryViewController: BaseViewController, MoveToFirstScene, UITextViewDelegate {
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: PicCollectionViewCell.identifier)
        view.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: AddCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let titleTextField = UnderLineTextField.textFieldBuilder(placeholder: "noTitleError".localized())
    let contentTextView = UITextView.TextViewBuilder()
    
    var selectedPet: [PetTable]?
    let repository = PetTableRepository()
    
    let viewModel = DiaryViewModel()
    
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
        
        title = "diaryNavigationTitle".localized()
        let saveButton = UIBarButtonItem(title: "save".localized(), style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonClicked() {
        guard let pet = selectedPet?.first else { return }
        
        let recordDate = viewModel.checkValidation(petID: pet._id) { titleAlert in
            self.titleTextField.setError()
            self.view.makeToast(titleAlert)
        } imageHandler: { imageAlert in
            self.view.makeToast(imageAlert)
        }

        guard let recordDate else { return }
        
        var imageIdentifiers: [String] = []
        ImageManager.shared.makeImageString(directoryName: .diaries, createDate: recordDate, images: images) { imageIdentifier in
            imageIdentifiers.append(contentsOf: imageIdentifier)
        } errorHandler: {
            self.sendOneSidedAlert(title: "failToSaveImage".localized(), message: "plzRetry".localized())
            return
        }
        
        viewModel.saveData(images: imageIdentifiers)

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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(titleTextField)
            make.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(86)
        }
    }
    
    override func configureView() {
        
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChanged), for: .editingChanged)
        contentTextView.delegate = self
        
        viewModel.title.bind { text in
            self.titleTextField.text = text
        }
        
        viewModel.content.bind { text in
            self.contentTextView.text = text
        }
        
    }
    
    @objc func titleTextFieldDidChanged() {
        viewModel.title.value = titleTextField.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content.value = textView.text
    }
    
}

extension DiaryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let add = viewModel.add
        let images = viewModel.images
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
        var config = PHPickerConfiguration()
        
        config.filter = .images
        config.selectionLimit = 5 - viewModel.imageCount.value
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
                viewModel.imageCount.value += images.count
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
            viewModel.imageCount.value += 1
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension DiaryViewController: UIDocumentPickerDelegate {
    func selectFile() {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .jpeg, .webP, .rawImage], asCopy: true)
        controller.delegate = self
        controller.allowsMultipleSelection = true
        present(controller, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if urls.count > 5 {
            self.sendOneSidedAlert(title: "noMoreImagesError".localized())
        }
        for url in urls {
            if images.count > 4 {
                self.sendOneSidedAlert(title: "최대 사진 갯수를 초과했습니다!", message: "선택한 사진의 일부만 추가됩니다.")
                return
            }
            guard let image = UIImage(contentsOfFile: url.path) else { return }
            self.images.append(image)
        }
    }
}


extension DiaryViewController: DeleteDelegate {
    func deleteImages(image: UIImage) {
        if let firstIndex = self.images.firstIndex(of: image) {
            self.images.remove(at: firstIndex)
            self.viewModel.imageCount.value -= 1
        }
    }
}
