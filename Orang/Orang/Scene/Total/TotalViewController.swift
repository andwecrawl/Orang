//
//  TotalViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/17.
//

import UIKit
import Toast
import FSCalendar


class TotalViewController: BaseViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    private let calendarView = CalendarView()
    
    var testView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    var testView1 = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    var testView2 = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    var testView3 = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    
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
            testView,
            testView1,
            testView2,
            testView3,
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
        
        testView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        testView1.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        testView2.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        testView3.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
    
    override func configureView() {
        calendarView.calendar.delegate = self
        calendarView.calendar.dataSource = self
        calendarView.calendar.select(Date())
        contentView.spacing = 20
        
        setCalendar()
        
        if let toastIngredient {
            self.navigationController?.view.makeToast("\(toastIngredient) 저장되었습니다!", position: .bottom)
        }
    }
    
}


extension TotalViewController {
    // 다음 주로 이동 함수
    @objc private func nextCurrentPage(isPrev: Bool) {
        print("clicked!")
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = 1

        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    // 이전 주로 이동 함수
    @objc private func prevCurrentPage(isPrev: Bool) {
        print("clicked!")
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = -1

        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}


extension TotalViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func setCalendar() {
        let calendar = self.calendarView.calendar
        self.currentPage = calendar.currentPage
        calendar.locale = Locale(identifier: Locale.current.identifier)
        calendar.today = Date()
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
