//
//  PooPeeViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/13.
//

import UIKit

class PooPeeViewController: BaseViewController {
    private let segmentedControl = {
        let segmentedControl = UnderlineSegmentedControl(items: ["대변", "소변"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let pooVC = PooViewController()
    
    private let peeVC = PeeViewController()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    var dataViewControllers: [UIViewController] {
        [self.pooVC, self.peeVC]
    }
    
    var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers(
                [dataViewControllers[self.currentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }
    }
    
    var selectedPet: [PetTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setNavigationBar() {
        
        title = "대소변 기록하기"
        let nextButton = UIBarButtonItem(title: "next".localized(), style: .plain, target: self, action: #selector(nextButtonClicked))
        navigationItem.rightBarButtonItem = nextButton
        

    }
    
    @objc func nextButtonClicked() {
        let vc = AdditionalInfoViewController()
        vc.title = "추가적인 증상이 있나요?"
        
        if currentPage == 0 { // Poo
            
            guard let pooColor = pooVC.selectedPoo?.type else {
                sendOneSidedAlert(title: "해당하는 요소를 선택해 주세요!")
                return
            }
            
            if pooColor != PooColor.none {
                guard let pooForm = pooVC.selectedForm?.type else {
                    sendOneSidedAlert(title: "해당하는 요소를 선택해 주세요!")
                    return
                }
                vc.selectedPooForm = pooForm
            }
            vc.selectedPooColor = pooColor
            
        } else { // Pee
            
            guard let peeColor = peeVC.selectedPeeColor?.type else {
                sendOneSidedAlert(title: "해당하는 요소를 선택해 주세요!")
                return
            }
            vc.selectedPeeColor = peeColor
        }
        
        vc.recordType = .pooPee
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.pageViewController.view)
    }
    
    override func setConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(segmentedControl.snp.bottom).offset(6)
        }
    }
    
    override func configureView() {
        self.segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.changeValue(control: self.segmentedControl)
    }
    
    
    @objc private func changeValue(control: UISegmentedControl) {
        // 코드로 값을 변경하면 해당 메소드 호출 x
        self.currentPage = control.selectedSegmentIndex
    }
}

extension PooPeeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = self.dataViewControllers.firstIndex(of: viewController),
            index - 1 >= 0
        else { return nil }
        return self.dataViewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = self.dataViewControllers.firstIndex(of: viewController),
            index + 1 < self.dataViewControllers.count
        else { return nil }
        return self.dataViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0],
            let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}
