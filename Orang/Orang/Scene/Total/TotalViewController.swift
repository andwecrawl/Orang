//
//  TotalViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit
import Toast
import FSCalendar


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
    
    private var calendarCurrentPage: Int = 0
    private var currentPage: Date?
    var selectedDate: Date = Date()
    
    private let today: Date = {
        return Date()
    }()
    
    
    var toastIngredient: String?
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "모아보기"
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
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(372)
            
        }
        
        diaryView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
        
        dailyView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
        
        medicalView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(200)
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
}




// DiaryView
extension TotalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dailyView.tableView == tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTempTableViewCell.identifier) as? DailyTempTableViewCell else { return UITableViewCell() }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else { return UITableViewCell() }
        return cell
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

    func setCalendarHeight() {

    }

    func setWeekdayFont() {

    }

    func setCalendarColor() {
        
        let calendar = self.calendarView.calendar
        // headerColor
        calendar.appearance.headerTitleColor = Design.Color.content

        // 동그라미 색 지정
        calendar.appearance.selectionColor = Design.Color.tintColor
        calendar.appearance.todayColor = Design.Color.tintColor?.withAlphaComponent(0.4)

        // 요일 색깔 설정
        calendar.appearance.weekdayTextColor = Design.Color.border
        // 달에 유효하지 않은 날짜의 색 지정
        calendar.appearance.titlePlaceholderColor = UIColor.gray.withAlphaComponent(0.8)
        // 평일 날짜 색
        calendar.appearance.titleDefaultColor = Design.Color.content
    }


    // height 관련
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {

    }


    // 선택된 날짜 설정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return Design.Color.tintColor
    }


    // 날짜 선택 시 할 일 지정
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

    }


    // 날짜 선택 해제 불가능
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
         return false
    }


    // mm월이 바뀌면 자동으로 변경
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarView.calendarLabel.text = self.currentPage?.toCalendarTitle()
    }
}
