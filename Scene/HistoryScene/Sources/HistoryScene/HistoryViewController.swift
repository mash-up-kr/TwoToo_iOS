//
//  HistoryViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//
import CoreKit
import UIKit

protocol HistoryDisplayLogic: AnyObject {
    func displayChallengeList(viewModel: History.ViewModel.CellInfoList)
    func displayChallengeEmptyView()
    func displayToast(viewModel: History.ViewModel.Toast)
}

final class HistoryViewController: UIViewController, TTNavigationBarDelegate, UICollectionViewDataSource {

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
        let v = TTNavigationBar(title: "우리의 히스토리",
                                rightButtonImage: .asset(.icon_info))
        v.delegate = self
        return v
    }()
    
    lazy var historyCollectionView: UICollectionView = {
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
    
    // TODO: - Empty뷰 디자인 없음
    lazy var historyEmptyView: UIView = {
        let v = UIView()
        v.isHidden = true
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setAttribute()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            await self.interactor.didAppear()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar,
                              self.historyCollectionView,
                              self.historyEmptyView)
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.historyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalTo(guide.snp.bottom)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.historyEmptyView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setAttribute() {
        self.view.backgroundColor = .second02 // TODO: - will change
    }
        
    // MARK: - CollectionView DataSource
    var cellInfoList: History.ViewModel.CellInfoList = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: HistoryCollectionViewCell.self, indexPath: indexPath)
        let viewModel = self.cellInfoList[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
}

// MARK: - Trigger

extension HistoryViewController {
    
    func didTapRightButton() {
        Task {
            await self.interactor.didTapManualButton()
        }
    }
}

// MARK: - Trigger by Parent Scene

extension HistoryViewController: HistoryScene {
    
}

// MARK: - Display Logic

extension HistoryViewController: HistoryDisplayLogic {
    func displayChallengeList(viewModel: History.ViewModel.CellInfoList) {
        self.cellInfoList = viewModel
        self.historyCollectionView.reloadData()
    }
    
    func displayChallengeEmptyView() {
        self.historyCollectionView.isHidden = true
        self.historyEmptyView.isHidden = false
    }
    
    func displayToast(viewModel: History.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}

extension HistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Task {
            await self.interactor.didTapChallengeHistory(index: indexPath.row)
        }
    }
}

extension HistoryViewController {
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

extension HistoryViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
