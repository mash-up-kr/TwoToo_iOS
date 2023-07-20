//
//  HistoryViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//
import CoreKit
import UIKit

protocol HistoryDisplayLogic: AnyObject {}

final class HistoryViewController: UIViewController {
    var interactor: HistoryBusinessLogic
    
    init(interactor: HistoryBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "우리의 정원", rightButtonImage: .asset(.icon_info))
        return v
    }()
    
    lazy var gardenCollectionView: UICollectionView = {
        let layout = generateCollectionViewLayout()
        let v = UICollectionView(frame: .zero,
                                 collectionViewLayout: layout)
        v.registerCell(HistoryCollectionViewCell.self)
        v.showsVerticalScrollIndicator = false
        v.delegate = self
        v.dataSource = self
        v.backgroundColor = .clear
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.view.backgroundColor = .second02
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar, self.gardenCollectionView)
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top).offset(13)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.gardenCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalTo(guide.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func generateCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let horizontalPadding: CGFloat = 48
        let itemSpacing: CGFloat = 13
        let itemEstimatedWidth: CGFloat = 157
        let itemEstimatedHeight: CGFloat = 216
        
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - horizontalPadding - itemSpacing) / 2
        let cellHeight = (cellWidth * itemEstimatedHeight) / itemEstimatedWidth
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(cellHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(itemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpacing
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension HistoryViewController: HistoryScene {
    
}

// MARK: - Display Logic

extension HistoryViewController: HistoryDisplayLogic {
    
}

// MARK: - CollectionView
extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: HistoryCollectionViewCell.self, indexPath: indexPath)
        cell.configure() // TODO: - 수정 예정
        return cell
    }
    
}

extension HistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderColor = UIColor.mainPink.cgColor
            cell.layer.borderWidth = 3
            // TODO: - 푸쉬코드
        }
    }
}
