//
//  AlertViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/03.
//

import UIKit
import FSCalendar

class AlertViewController: BaseViewController {
    
    private var calendar = FSCalendar()
    
    private let dailyTodoButton = UIButton.shadowButtonBuilder(title: "dailyTodo".localized(), subtitle: "dailyTodoDetail".localized(), isBig: true)
    private let medicalAppointmentButton = UIButton.shadowButtonBuilder(title: "medicalAppointment".localized(), subtitle: "medicalAppointmentDetail".localized(), isBig: true)
    
    var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendar.select(Date())
    }
    
    override func setNavigationBar() {
        super.setNavigationBar()
        
        title = "일정 관리"
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        [
            calendar,
            dailyTodoButton,
            medicalAppointmentButton
        ]
            .forEach { view.addSubview($0) }
        
    }
        
    override func setConstraints() {
//        calendar.backgroundColor = .gray
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
        dailyTodoButton.backgroundColor = .white.withAlphaComponent(0.8)
        dailyTodoButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.equalTo(calendar.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        medicalAppointmentButton.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.equalTo(dailyTodoButton.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    override func configureView() {
        calendar.dataSource = self
        calendar.delegate = self
        
        setCalendar()
    }

}

extension AlertViewController: FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func setCalendar() {
        calendar.locale = Locale(identifier: Locale.current.identifier)
        calendar.today = Date()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.weekdayFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.titleFont = .systemFont(ofSize: 15, weight: .bold)
        
        setCalendarColor()
    }
    
    func setCalendarHeight() {
        
    }
    
    func setWeekdayFont() {
        
    }
    
    func setCalendarColor() {
        // 동그라미 색 지정
        calendar.appearance.selectionColor = Design.Color.tintColor
        calendar.appearance.todayColor = Design.Color.todaysColor
        
        // 달에 유효하지 않은 날짜의 색 지정
        self.calendar.appearance.titlePlaceholderColor = UIColor.gray.withAlphaComponent(0.8)
        // 평일 날짜 색
        self.calendar.appearance.titleDefaultColor = Design.Color.content
    }
    
    // 날짜 선택 시 할 일 지정
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    // height 관련
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
    }
    
    
    // 선택된 날짜 설정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return Design.Color.tintColor
    }
    
}



