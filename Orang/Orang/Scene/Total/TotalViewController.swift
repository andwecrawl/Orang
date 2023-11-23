//
//  TotalViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit
import Toast
import FSCalendar
import RealmSwift


final class TotalViewController: BaseViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    private let calendarView = CalendarView()
    
    private let diaryView = DiaryView()
    
    private let dailyView = DiaryView()
    
    private let medicalView = DiaryView()
    
    private let emptyView = EmptyView()
    
    var testView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var height: (diary: Int, daily: Int, medical: Int) = (80, 80, 80)
    
    private var calendarCurrentPage: Int = 0
    private var currentPage: Date?
    var selectedDate: Date = Date()
    
    private let today: Date = {
        return Date()
    }()
    
    let petRepository = PetTableRepository()
    let recordRepository = RecordTableRepository()
    var petList: Results<PetTable>!
    var diaryRecords: Results<RecordTable>!
    var dailyRecords: Results<RecordTable>!
    var medicalRecords: Results<MedicalRecordTable>!
    
    var diaryEvent: [Date] = []
    var dailyEvent: [Date] = []
    var medicalEvent: [Date] = []
    
    var toastIngredient: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(date: selectedDate)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            loadData(date: selectedDate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData(date: selectedDate)
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        title = "totalNavigationTitle".localized()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.backgroundColor = Design.Color.background
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Design.Color.background
        view.addSubview(scrollView)
        
        contentView.axis = .vertical
        contentView.spacing = 18
        scrollView.addSubview(contentView)
        
        setScrollViewLayout()
        
        [
            calendarView,
            diaryView,
            dailyView,
            medicalView,
            emptyView,
            testView
        ]
            .forEach { contentView.addArrangedSubview($0) }
        
    }
    
    private func setScrollViewLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setConstraints() {
        
        calendarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(372)
            
        }
        
        diaryView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(height.diary)
        }
        
        dailyView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(height.daily)
        }
        
        medicalView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(height.medical)
        }
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        testView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
    
    override func configureView() {
        
        configureCalendarView()
        configureDiaryView()
        configureDailyView()
        configureMedicalView()
        configureEmptyView()
        
        if let toastIngredient {
            self.navigationController?.view.makeToast("\(toastIngredient) 저장되었습니다!", position: .bottom)
        }
    }
    
    func configureCalendarView() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.calendar.select(Date())
        contentView.spacing = 20
        
        setCalendar()
        
        calendarView.previousButton.addTarget(self, action: #selector(previousButtonClicked), for: .touchUpInside)
        calendarView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
    }
    
    
    func configureDiaryView() {
        diaryView.tableView.delegate = self
        diaryView.tableView.dataSource = self
    }

    func configureDailyView() {
        dailyView.recordLabel.text = "생활 기록"
        dailyView.tableView.delegate = self
        dailyView.tableView.dataSource = self
    }
    
    func configureMedicalView() {
        medicalView.recordLabel.text = "진료 기록"
        medicalView.tableView.delegate = self
        medicalView.tableView.dataSource = self
    }
    
    func configureEmptyView() {
        if selectedDate.startOfTheDate == Date().startOfTheDate {
            emptyView.recordLabel.text = "todaysRecord".localized()
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"
            let str = dateFormatter.string(from: selectedDate)
            emptyView.recordLabel.text = "recordOf".localized(with: str)
        }
    }
}


// loadData & updateConstraints
extension TotalViewController {
    func loadData(date: Date) {
        petList = petRepository.fetch()
        diaryRecords = recordRepository.fetchRecords(date: date, type: .diary, objectType: RecordTable.self)
        dailyRecords = recordRepository.fetchRecords(date: date, type: .daily, objectType: RecordTable.self)
        medicalRecords = recordRepository.fetchRecords(date: date, type: .medical, objectType: MedicalRecordTable.self)
        configureEvents()
        
        setContentView()
        configureEmptyView()
        
        diaryView.tableView.reloadData()
        dailyView.tableView.reloadData()
        medicalView.tableView.reloadData()
    }
    
    func setContentView() {
        if diaryRecords.isEmpty && dailyRecords.isEmpty && medicalRecords.isEmpty {
            diaryView.isHidden = true
            dailyView.isHidden = true
            medicalView.isHidden = true
            testView.isHidden = true
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            testView.isHidden = false
        }
        
        if diaryRecords.isEmpty {
            diaryView.isHidden = true
        } else {
            diaryView.isHidden = false
            let newHeight = 80 + diaryRecords.count * 80
            if newHeight != height.diary {
                height.diary = newHeight
                diaryView.snp.updateConstraints { make in
                    make.height.greaterThanOrEqualTo(height.diary)
                }
            }
        }
        if dailyRecords.isEmpty {
            dailyView.isHidden = true
        } else {
            dailyView.isHidden = false
            let newHeight = 80 + dailyRecords.count * 80
            if newHeight != height.daily {
                height.daily = newHeight
                dailyView.snp.updateConstraints { make in
                    make.height.greaterThanOrEqualTo(height.daily)
                }
            }
        }
        if medicalRecords.isEmpty {
            medicalView.isHidden = true
        } else {
            medicalView.isHidden = false
            let newHeight = 80 + medicalRecords.count * 80
            if newHeight != height.medical {
                height.medical = newHeight
                medicalView.snp.updateConstraints { make in
                    make.height.greaterThanOrEqualTo(height.medical)
                }
            }
        }
    }
}


// DiaryView
extension TotalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if diaryView.tableView == tableView {
            return diaryRecords.count
        } else if dailyView.tableView == tableView {
            return dailyRecords.count
        } else {
            return medicalRecords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if diaryView.tableView == tableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else { return UITableViewCell() }
            let record = diaryRecords[row]
            let petID = record.petId
            let data = makeRecordCellData(petID: petID, recordType: record.recordType, record: record)
            cell.titleLabel.text = data.title
            cell.subtitleLabel.text = data.subtitle
            if let image = data.images.last {
                cell.diaryImageView.image = image
            }
            if tableView.isLast(for: indexPath) {
                DispatchQueue.main.async {
                    cell.addAboveTheBottomBorderWithColor(color: Design.Color.buttonBackground)
                }
            }
            return cell
            
        } else if dailyView.tableView == tableView {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTempTableViewCell.identifier) as? DailyTempTableViewCell else { return UITableViewCell() }
            let record = dailyRecords[row]
            let petID = record.petId
            let data = makeRecordCellData(petID: petID, recordType: record.recordType, record: record)
            cell.titleLabel.text = data.title
            cell.subtitleLabel.text = data.subtitle
            if let profileImage = data.images.first, let symbolImage = data.images.last {
                cell.diaryImageView.image = profileImage
                cell.typeImageView.image = symbolImage
            }
            if tableView.isLast(for: indexPath) {
                DispatchQueue.main.async {
                    cell.addAboveTheBottomBorderWithColor(color: Design.Color.buttonBackground)
                }
            }
            return cell

        } else { // medicalView
            

            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTempTableViewCell.identifier) as? DailyTempTableViewCell else { return UITableViewCell() }

            let record = medicalRecords[row]
            let petID = record.petId
            let data = makeMedicalCellData(petID: petID, recordType: record.recordType, record: record)
            cell.titleLabel.text = data.title
            cell.subtitleLabel.text = data.subtitle
            if let profileImage = data.images.first, let symbolImage = data.images.last {
                cell.diaryImageView.image = profileImage
                cell.typeImageView.image = symbolImage
            }
            if tableView.isLast(for: indexPath) {
                DispatchQueue.main.async {
                    cell.addAboveTheBottomBorderWithColor(color: Design.Color.buttonBackground)
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기

//        let modity = UIContextualAction(style: .normal, title: "수정") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("수정 클릭 됨")
//            success(true)
//        }
//        modity.backgroundColor = .systemBlue

        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let item = indexPath.item
            var records: ImageManager.DirectoryName
            
            if tableView == self.diaryView.tableView {
                records = .diaries
                let record = self.diaryRecords[item]
                record.imageArray.forEach({ ImageManager.shared.removeImageFromDirectory(directoryName: records, identifier: $0) })
                self.recordRepository.deleteRecord(record)
            } else if tableView == self.dailyView.tableView {
                records = .dailyRecords
                let record = self.dailyRecords[item]
                record.imageArray.forEach({ ImageManager.shared.removeImageFromDirectory(directoryName: records, identifier: $0) })
                self.recordRepository.deleteRecord(record)
            } else {
                records = .medicalRecords
                let record = self.medicalRecords[item]
                record.imageArray.forEach({ ImageManager.shared.removeImageFromDirectory(directoryName: records, identifier: $0) })
                self.recordRepository.deleteMedicalRecord(record)
            }
            success(true)
            self.configureEvents()
            self.calendarView.calendar.reloadData()
            tableView.reloadData()
            self.setContentView()
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
    func makeRecordCellData(petID: ObjectId, recordType: RecordType, record: RecordTable) -> (title: String, subtitle: String?, images: [UIImage?]) {
        
        if let pet = petList.filter({ $0._id == petID }).first {
            let profileImage = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
            let unit = record.weightUnit?.toString ?? ""
            
            switch recordType {
            case .diary:
                if let title = record.title {
                    let subtitle = record.content
                    let diaryImage = ImageManager.shared.loadImageFromDirectory(directoryName: .diaries, with: record.imageArray.first ?? "")
                    return (title, subtitle, [profileImage, diaryImage])
                }
            case .weight:
                let title = "\(pet.name)의 \(record.recordType)"
                let weight = record.weight ?? 0
                let subtitle = "\(weight)\(unit)"
                let typeImage = record.recordType.image
                return (title, subtitle, [profileImage, typeImage])
            case .snack:
                let title = "\(pet.name)의 \(record.recordType)"
                let snack = record.snackAmount ?? 0
                let snackSpecies = record.snackSpecies ?? ""
                let subtitle = "\(snackSpecies): \(snack)\(unit)"
                let typeImage = record.recordType.image
                return (title, subtitle, [profileImage, typeImage])
            case .pooPee:
                let title = "\(pet.name)의 \(record.recordType)"
                let typeImage = record.recordType.image
                if let peeColor = record.peeColor {
                    let subtitle = peeColor.title
                    return (title, subtitle, [profileImage, typeImage])
                } else if let pooColor = record.pooColor {
                    let subtitle = "\(pooColor.title) | \(record.pooForm?.title ?? "")"
                    return (title, subtitle, [profileImage, typeImage])
                }
            case .abnormalSymptoms:
                let title = "\(pet.name)의 \(record.recordType)"
                let subtitle = record.abnormalSymptomsArray.map({
                    if $0 == .others {
                        return record.content ?? ""
                    } else {
                        return $0.title
                    }
                }).joined(separator: " | ")
                let typeImage = record.recordType.image
                return (title, subtitle, [profileImage, typeImage])
            default: break
            }
        }
        
        return ("데이터를 찾을 수 없습니다.", "데이터를 찾을 수 없습니다.", [])
    }
    
    func makeMedicalCellData(petID: ObjectId, recordType: RecordType, record: MedicalRecordTable) -> (title: String, subtitle: String?, images: [UIImage?]) {
        if let pet = petList.filter({ $0._id == petID }).first {
            let profileImage = ImageManager.shared.loadImageFromDirectory(directoryName: .profile, with: pet.profileImage)
            let typeImage = record.recordType.image
            let title = "\(pet.name)의 \(record.description)"
            
            if recordType == .vaccine {
                
                let subtitle =  "\(record.hospital) | \(record.vaccineTypeArray.joined(separator: ", "))"
                return (title, subtitle, [profileImage, typeImage])
                
            } else { // recordType == .medicalHistory
                
                let treatment = record.treatment ?? "작성한 내원 사유가 없어요!"
                let memo = record.content ?? ""
                let subtitle = "\(record.hospital) | \(treatment) | \(memo)"
                
                return (title, subtitle, [profileImage, typeImage])
            }
        }
        
        return ("데이터를 찾을 수 없습니다.", "데이터를 찾을 수 없습니다.", [])
    }
    
}



// Calendar
extension TotalViewController {
    @objc func previousButtonClicked() {
        let current = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = -1
        
        self.currentPage = current.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        if let currentPage {
            self.calendarView.calendar.setCurrentPage(currentPage, animated: true)
        }
    }
    
    @objc func nextButtonClicked() {
        let current = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = 1
        
        self.currentPage = current.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        if let currentPage {
            self.calendarView.calendar.setCurrentPage(currentPage, animated: true)
        }
    }
}

extension TotalViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func setCalendar() {
        let calendar = self.calendarView.calendar
        self.currentPage = calendar.currentPage
        calendar.locale = Locale(identifier: Locale.current.identifier)
        calendar.today = today
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.weekdayFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.titleFont = .systemFont(ofSize: 15, weight: .bold)
        calendar.scrollEnabled = true
        calendar.headerHeight = 0

        setCalendarColor()
        calendarCurrentPageDidChange(calendar)
    }

    func setWeekdayFont() {

    }

    func setCalendarColor() {
        
        let calendar = self.calendarView.calendar
        // headerColor
        calendar.appearance.headerTitleColor = Design.Color.buttonContent

        // 동그라미 색 지정
        calendar.appearance.selectionColor = Design.Color.tintColor
        calendar.appearance.todayColor = Design.Color.tintColor.withAlphaComponent(0.4)

        // 요일 색깔 설정
        calendar.appearance.weekdayTextColor = Design.Color.border
        // 달에 유효하지 않은 날짜의 색 지정
        calendar.appearance.titlePlaceholderColor = UIColor.gray.withAlphaComponent(0.8)
        // 평일 날짜 색
        calendar.appearance.titleDefaultColor = Design.Color.buttonContent
        calendar.appearance.eventSelectionColor = Design.Color.tintColor
    }

    // 선택된 날짜 설정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return Design.Color.tintColor
    }


    // 날짜 선택 시 할 일 지정
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        loadData(date: date)
    }


    // 날짜 선택 해제 불가능
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
         return false
    }


    // mm월이 바뀌면 자동으로 변경
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentPage = calendar.currentPage
        self.calendarView.calendarLabel.text = self.currentPage?.toCalendarTitle()
    }
}


extension TotalViewController {
    
    func configureEvents() {
        let events = recordRepository.fetchMonthlyRecords(date: selectedDate)
        diaryEvent = events.diaryRecord
        dailyEvent = events.dailyRecord
        medicalEvent = events.medicalRecord
    }
    
    // 이벤트 밑에 Dot 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formattedDate = date.startOfTheDate
        var dots = 0
        if self.diaryEvent.contains(formattedDate){
            dots += 1
        }
        if self.dailyEvent.contains(formattedDate){
            dots += 1
        }
        if self.medicalEvent.contains(formattedDate){
            dots += 1
        }
        return dots
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        let formattedDate = date.startOfTheDate
        
        var colors: [UIColor] = []
        
        if self.diaryEvent.contains(formattedDate){
            colors.append(Design.Color.diary)
        }

        if self.dailyEvent.contains(formattedDate){
            colors.append(Design.Color.daily)
        }
        
        if self.medicalEvent.contains(formattedDate){
            colors.append(Design.Color.medical)
        }

        return colors
    }

    // Default Event Dot 색상 분기처리 - FSCalendarDelegateAppearance
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
        
        let formattedDate = date.startOfTheDate
        
        var colors: [UIColor] = []
        
        if self.diaryEvent.contains(formattedDate){
            colors.append(Design.Color.diary)
        }

        if self.dailyEvent.contains(formattedDate){
            colors.append(Design.Color.daily)
        }
        
        if self.medicalEvent.contains(formattedDate){
            colors.append(Design.Color.medical)
        }

        return colors
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 1)
    }
    
}
