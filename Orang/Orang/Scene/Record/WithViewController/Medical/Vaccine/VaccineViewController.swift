//
//  VaccineViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/10.
//

import UIKit

protocol VaccineProtocol {
    func addButtonHandler()
    func deleteButtonHandler()
    func presentVaccineVC(vc: VaccineTypeViewController)
}


final class VaccineViewController: BaseViewController {
    
    private let hospitalLabel = UILabel.labelBuilder(text: "hospitalName".localized(), size: 16, weight: .bold, settingTitle: true)
    private let hospitalTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputHospitalName".localized(), textAlignment: .center)
    private let hospitalStackView = UIStackView.stackViewBuilder()
    
    private let dateLabel = UILabel.labelBuilder(text: "date".localized(), size: 16, weight: .bold, settingTitle: true)
    private let dateTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputDate".localized())
    private let timeTextField = UnderLineTextField.textFieldBuilder(placeholder: "inputTime".localized(), isTimeTextfield: true)
    private let dateStackView = UIStackView.stackViewBuilder()

    private let vaccineTypeLabel = UILabel.labelBuilder(text: "접종 항목".localized(), size: 16, weight: .bold, settingTitle: true)
    lazy var vaccineCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(VaccineCategoryCollectionViewCell.self, forCellWithReuseIdentifier: VaccineCategoryCollectionViewCell.identifier)
        view.register(VaccineAddCollectionViewCell.self, forCellWithReuseIdentifier: VaccineAddCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let vaccineTypeTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종 항목을".localized(), textAlignment: .center)
    private let vaccineTypeStackView = UIStackView.stackViewBuilder()
    private let vaccineDetailTextField = UnderLineTextField.textFieldBuilder(placeholder: "선택해 주세요.".localized(), isTimeTextfield: true, textAlignment: .center)
    private let vaccineButton = UIButton()
    
    private let inputVaccineTextField = UnderLineTextField.textFieldBuilder(placeholder: "접종한 백신을 입력해 주세요!", textAlignment: .center)
    private let noVaccineButton = UIButton.idkButtonBuilder(title: "접종한 백신이 표에 없어요.")
    
    var selectedPet: [PetTable]?
    var vaccineCategoryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        title = "예방 접종 내역 기록하기"
        
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func nextButtonClicked() {
        // 병원 이름 / 날짜, 시간 / 접종 항목 / 접종 비용 넘겨야 함
        let vc = AdditionalMemoViewController()
        vc.title = "추가로 기록하기"
        vc.selectedPet = selectedPet
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            hospitalStackView,
            dateStackView,
            vaccineTypeLabel,
            vaccineCollectionView
        ]
            .forEach{ view.addSubview($0) }
        
        hospitalStackView.AddArrangedSubviews([hospitalLabel, hospitalTextField])
        dateStackView.AddArrangedSubviews([dateLabel, dateTextField, timeTextField])
        
    }
    
    override func setConstraints() {
        hospitalStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(hospitalStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        vaccineTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateStackView.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        vaccineCollectionView.snp.makeConstraints { make in
            make.top.equalTo(vaccineTypeLabel)
            make.leading.equalTo(vaccineTypeLabel.snp.trailing).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        configureTextField([dateTextField, timeTextField], date: dateTextField, time: timeTextField)
    }
}



// setup TextField
extension VaccineViewController {
    func configureTextField(_ textFields: [UITextField], date: UITextField, time: UITextField) {
        textFields.forEach { element in
            element.textAlignment = .center
            element.delegate = self
        }
        date.tag = 1
        time.tag = 2
        setupDatePicker(textField: date)
        setupDatePicker(textField: time)
    }
    
    func setupDatePicker(textField: UITextField) {
        // 여기서 datePicker를 weak로 써줘야 하나?
        let datePicker = UIDatePicker()
        datePicker.tag = textField.tag
        
        // 원하는 언어로 지역 설정
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        textField.inputView = datePicker
        if textField == dateTextField {
            datePicker.preferredDatePickerStyle = .inline
            datePicker.datePickerMode = .date
            dateTextField.text = datePicker.date.toFormattedString()
        } else {
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels
            timeTextField.text = datePicker.date.toFormattedStringTime()
        }
    }
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        if sender.tag == 1 {
            dateTextField.text = sender.date.toFormattedString()
        } else {
            timeTextField.text = sender.date.toFormattedStringTime()
        }
    }
}


// textField Delegate
extension VaccineViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField || textField == timeTextField {
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


// collectionView
extension VaccineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vaccineCategoryCount < 3 {
            return vaccineCategoryCount + 1 // AddButton까지
        } else {
            return vaccineCategoryCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        let row = indexPath.row
        print(indexPath)
        if vaccineCategoryCount < 3 { // AddButton 있음
            if item == vaccineCategoryCount { // 마지막 Cell이라면
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VaccineAddCollectionViewCell.identifier, for: indexPath) as? VaccineAddCollectionViewCell else { return UICollectionViewCell() }
                cell.delegate = self
                return cell
            } else { // 추가하는 Cell이라면
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VaccineCategoryCollectionViewCell.identifier, for: indexPath) as? VaccineCategoryCollectionViewCell else { return UICollectionViewCell() }
                cell.delegate = self
                return cell
            }
        } else { // AddButton 없음
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VaccineCategoryCollectionViewCell.identifier, for: indexPath) as? VaccineCategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        }
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width - 130
        layout.itemSize = CGSize(width: width, height: 70)
        
        return layout
    }
}


extension VaccineViewController: VaccineProtocol {
    func addButtonHandler() {
        vaccineCategoryCount += 1
        vaccineCollectionView.reloadData()
    }
    
    func deleteButtonHandler() {
        vaccineCategoryCount -= 1
        vaccineCollectionView.reloadData()
    }
    
    func presentVaccineVC(vc: VaccineTypeViewController) {
        
        guard let selectedPet else { return }
        vc.selectedPet = selectedPet.first!
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    
}
