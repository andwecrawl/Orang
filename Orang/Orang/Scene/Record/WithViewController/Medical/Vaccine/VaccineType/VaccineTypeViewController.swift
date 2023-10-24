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
        navigationItem.title = "basicVaccinations".localized()
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
            informationLabel.text = "sorryForNot %@".localized(with: detail)
        } else if !(species == .cat || species == .dog || species == .rabbit) {
            outlineCollectionView.isHidden = true
            informationLabel.text = "sorryForNot %@".localized(with: species.toString)
        } else {
            outlineCollectionView.isHidden = false
            informationLabel.isHidden = true
        }
    }
    
    private lazy var menuItems: [Vaccine] = {
        if selectedPet?.species == .cat {
            return [
                Vaccine(title: "basic_vaccination".localized(), subitems: [
                    Vaccine(title: "\("1st_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [6, 8]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic1st_dose".localized())
                    ]),
                    
                    
                    Vaccine(title: "\("2nd_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [8, 10]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic2nd_dose".localized())
                    ]),
                    Vaccine(title: "\("3rd_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [10, 12]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic3rd_dose".localized()),
                        Vaccine(title: "rabies".localized(), variation: "basic3rd_dose".localized())
                    ]),
                    Vaccine(title: "\("4th_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [12, 14]))", subitems: [
                        Vaccine(title: "infectious_peritonitis".localized(), variation: "basic4th_dose".localized())
                    ]),
                    Vaccine(title: "\("5th_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [14, 16]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic5th_dose".localized()),
                        Vaccine(title: "rabies".localized(), variation: "basic5th_dose".localized())
                    ])
                ]),
                Vaccine(title: "monthly_vaccination".localized(), subitems: [
                    Vaccine(title: "heartworm".localized(), variation: "monthly_vaccination".localized()),
                    Vaccine(title: "external_parasites".localized(), variation: "monthly_vaccination".localized()),
                    Vaccine(title: "internal_parasites".localized(), variation: "monthly_vaccination".localized())]),
                Vaccine(title: "annually_vaccination".localized(), subitems: [
                    Vaccine(title: "comprehensive_vaccine".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "rabies".localized(), variation: "annually_vaccination".localized())
                ])
            ]
        } else if selectedPet?.species == .dog {
            return [
                Vaccine(title: "basic_vaccination".localized(), subitems: [
                    Vaccine(title: "\("1st_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [6, 8]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic1st_dose".localized()),
                        Vaccine(title: "corona_enteritis".localized(), variation: "basic1st_dose".localized())
                    ]),
                    Vaccine(title: "\("2nd_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [8, 10]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic2nd_dose".localized()),
                        Vaccine(title: "corona_enteritis".localized(), variation: "basic2nd_dose".localized())
                    ]),
                    Vaccine(title: "\("3rd_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [10, 12]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic3rd_dose".localized()),
                        Vaccine(title: "bordetella".localized(), variation: "basic3rd_dose".localized())
                    ]),
                    Vaccine(title: "\("4th_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [12, 14]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic4th_dose".localized()),
                        Vaccine(title: "bordetella".localized(), variation: "basic4th_dose".localized())
                    ]),
                    Vaccine(title: "\("5th_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [14, 16]))", subitems: [
                        Vaccine(title: "comprehensive_vaccine".localized(), variation: "basic5th_dose".localized()),
                        Vaccine(title: "canine_influenza".localized(), variation: "basic5th_dose".localized())
                    ]),
                    Vaccine(title: "\("6th_dose".localized()): \("doseDate_%d_to_%d_weeks".localized(with: [16, 18]))", subitems: [
                        Vaccine(title: "rabies".localized(), variation: "basic6th_dose".localized()),
                        Vaccine(title: "canine_influenza".localized(), variation: "basic6th_dose".localized()),
                        Vaccine(title: "antibody_test".localized(), variation: "basic6th_dose".localized())
                    ])
                ]),
                Vaccine(title: "monthly_vaccination".localized(), subitems: [
                    Vaccine(title: "heartworm".localized(), variation: "monthly_vaccination".localized()),
                    Vaccine(title: "external_parasites".localized(), variation: "monthly_vaccination".localized()),
                    Vaccine(title: "internal_parasites".localized(), variation: "monthly_vaccination".localized())]),
                Vaccine(title: "annually_vaccination".localized(), subitems: [
                    Vaccine(title: "comprehensive_vaccine".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "corona_enteritis".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "bordetella".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "canine_influenza".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "rabies".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "fungal_skin_disease".localized(), variation: "annually_vaccination".localized()),
                    Vaccine(title: "antibody_test".localized(), variation: "annually_vaccination".localized())
                ])
            ]
        } else if selectedPet?.species == .rabbit {
            return [
                Vaccine(title: "viral_hemorrhagic_disease".localized(), variation: "basic_vaccination".localized()),
                Vaccine(title: "rabies".localized(), variation: "basic_vaccination".localized()),
                Vaccine(title: "external_parasites".localized(), variation: "basic_vaccination".localized()),
                Vaccine(title: "internal_parasites".localized(), variation: "basic_vaccination".localized()),
                Vaccine(title: "fungal_skin_disease".localized(), variation: "basic_vaccination".localized())
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
            contentConfiguration.textProperties.font = Design.Font.scdreamBold.midFont
            cell.contentConfiguration = contentConfiguration
            
            var disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            disclosureOptions.tintColor = Design.Color.tintColor
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Vaccine> { cell, indexPath, menuItem in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = Design.Font.scdreamMedium.midFont
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
