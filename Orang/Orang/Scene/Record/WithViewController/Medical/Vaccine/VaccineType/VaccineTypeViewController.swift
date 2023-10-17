//
//  VaccineTypeViewController.swift
//  Orang
//
//  Created by yeoni on 2023/10/15.
//

import UIKit

class VaccineTypeViewController: BaseViewController {
    
    let informationLabel = UILabel.labelBuilder(size: 15, weight: .semibold)
    
    enum Section {
        case main
    }
    
    class Vaccine: Hashable {
        let title: String
        let variation: String
        let subitems: [Vaccine]
        
        init(title: String, variation: String = "",
             subitems: [Vaccine] = []) {
            self.title = title
            self.variation = variation
            self.subitems = subitems
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: Vaccine, rhs: Vaccine) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Vaccine>! = nil
    private lazy var outlineCollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = Design.Color.background
        collectionView.delegate = self
        return collectionView
    }()
    
    
    var completionHandler: ((String, String) -> ())?
    var selectedPet: PetTable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    override func setNavigationBar() {
        navigationItem.title = "기본 예방 접종 항목"
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        [
            informationLabel,
            outlineCollectionView
        ]
            .forEach({ view.addSubview($0) })
    }
    
    override func setConstraints() {
        informationLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        guard let selectedPet else { return }
        let species = selectedPet.species
        if species == .etc {
            guard let detail = selectedPet.detailSpecies else { return }
            outlineCollectionView.isHidden = true
            informationLabel.text = "\(detail)의 경우 예방 접종 항목을 제공하지 않습니다!"
        } else if !(species == .cat || species == .dog || species == .rabbit) {
            outlineCollectionView.isHidden = true
            informationLabel.text = "\(species.toString)의 경우 예방 접종 항목을 제공하지 않습니다!"
        } else {
            outlineCollectionView.isHidden = false
            informationLabel.isHidden = true
        }
    }
    
    private lazy var menuItems: [Vaccine] = {
        if selectedPet?.species == .cat {
            return [
                Vaccine(title: "기초 예방 접종", subitems: [
                    Vaccine(title: "1차: 생후 6주 ~ 8주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 1차")
                    ]),
                    Vaccine(title: "2차: 8주 ~ 10주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 2차")
                    ]),
                    Vaccine(title: "3차: 10주 ~ 12주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 3차"),
                        Vaccine(title: "광견병", variation: "기초 예방 3차")
                    ]),
                    Vaccine(title: "4차: 12주 ~ 14주", subitems: [
                        Vaccine(title: "전염성 복막염", variation: "기초 예방 4차")
                    ]),
                    Vaccine(title: "5차: 14주 ~ 16주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 5차"),
                        Vaccine(title: "광견병", variation: "기초 예방 5차")
                    ])
                ]),
                Vaccine(title: "월별 예방 접종", subitems: [
                    Vaccine(title: "심장사상충", variation: "월별 접종"),
                    Vaccine(title: "외부기생충", variation: "월별 접종"),
                    Vaccine(title: "내부기생충", variation: "월별 접종")]),
                Vaccine(title: "연도별 예방 접종", subitems: [
                    Vaccine(title: "종합 백신", variation: "연도별 접종"),
                    Vaccine(title: "광견병", variation: "연도별 접종")
                ])
            ]
        } else if selectedPet?.species == .dog {
            return [
                Vaccine(title: "기초 예방 접종", subitems: [
                    Vaccine(title: "1차: 생후 6주 ~ 8주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 1차"),
                        Vaccine(title: "코로나 장염", variation: "기초 예방 1차")
                    ]),
                    Vaccine(title: "2차: 8주 ~ 10주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 2차"),
                        Vaccine(title: "코로나 장염", variation: "기초 예방 2차")
                    ]),
                    Vaccine(title: "3차: 10주 ~ 12주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 3차"),
                        Vaccine(title: "켄넬코프", variation: "기초 예방 3차")
                    ]),
                    Vaccine(title: "4차: 12주 ~ 14주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 4차"),
                        Vaccine(title: "켄넬코프", variation: "기초 예방 4차")
                    ]),
                    Vaccine(title: "5차: 14주 ~ 16주", subitems: [
                        Vaccine(title: "종합 백신", variation: "기초 예방 5차"),
                        Vaccine(title: "신종플루", variation: "기초 예방 5차")
                    ]),
                    Vaccine(title: "6차: 16주 ~ 18주", subitems: [
                        Vaccine(title: "광견병", variation: "기초 예방 6차"),
                        Vaccine(title: "신종플루", variation: "기초 예방 6차"),
                        Vaccine(title: "항체가 검사", variation: "기초 예방 6차")
                    ])
                ]),
                Vaccine(title: "월별 예방 접종", subitems: [
                    Vaccine(title: "심장사상충", variation: "월별 접종"),
                    Vaccine(title: "외부기생충", variation: "월별 접종"),
                    Vaccine(title: "내부기생충", variation: "월별 접종")]),
                Vaccine(title: "연도별 예방 접종", subitems: [
                    Vaccine(title: "종합 백신", variation: "연도별 접종"),
                    Vaccine(title: "코로나 장염", variation: "연도별 접종"),
                    Vaccine(title: "켄넬코프", variation: "연도별 접종"),
                    Vaccine(title: "신종플루", variation: "연도별 접종"),
                    Vaccine(title: "광견병", variation: "연도별 접종"),
                    Vaccine(title: "곰팡이 백신", variation: "연도별 접종"),
                    Vaccine(title: "항체가 검사", variation: "연도별 접종")
                ])
            ]
        } else if selectedPet?.species == .rabbit {
            return [
                Vaccine(title: "바이러스 출혈열 백신", variation: "기초 예방 접종"),
                Vaccine(title: "광견병", variation: "기초 예방 접종"),
                Vaccine(title: "외부기생충", variation: "기초 예방 접종"),
                Vaccine(title: "내부기생충", variation: "기초 예방 접종"),
                Vaccine(title: "곰팡이성 피부병", variation: "기초 예방 접종")
            ]
        } else {
            return []
        }
    }()
    
}

extension VaccineTypeViewController {
    
    private func configureDataSource() {
        
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Vaccine> { (cell, indexPath, menuItem) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .boldSystemFont(ofSize: 15)
            cell.contentConfiguration = contentConfiguration
            
            var disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            disclosureOptions.tintColor = Design.Color.tintColor
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Vaccine> { cell, indexPath, menuItem in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .systemFont(ofSize: 15)
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Vaccine>(collectionView: outlineCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Vaccine) -> UICollectionViewCell? in
            if item.subitems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        }
        
        let snapshot = initialSnapshot()
        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }
    
    private func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<Vaccine> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<Vaccine>()
        
        func addItems(_ menuItems: [Vaccine], to parent: Vaccine?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where !menuItem.subitems.isEmpty {
                addItems(menuItem.subitems, to: menuItem)
            }
        }
        
        addItems(menuItems, to: nil)
        return snapshot
    }
    
}

extension VaccineTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        
        completionHandler?(menuItem.title, menuItem.variation)
        dismiss(animated: true)
    }
}
