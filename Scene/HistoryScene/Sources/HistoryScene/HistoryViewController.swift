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
    
    lazy var historyEmptyView: UIView = {
        let v = UIView()
        v.isHidden = true
        return v
    }()
    
    lazy var historyEmptyLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey500
        v.font = .body1
        v.text = "챌린지를 완료해\n히스토리를 만들어보세요 :)"
        v.textAlignment = .center
        v.numberOfLines = 0
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
            Loading.shared.showLoadingView()
            await self.interactor.didAppear()
            Loading.shared.stopLoadingView()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar,
                              self.historyCollectionView,
                              self.historyEmptyView)
        self.historyEmptyView.addSubview(self.historyEmptyLabel)
        
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
            make.bottom.equalTo(guide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        self.historyEmptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setAttribute() {
        self.view.setBackgroundDefault()
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && self.animated {
            cell.layer.borderColor = UIColor.mainPink.cgColor
            UIView.animate(
                withDuration: 0.5,
                animations: ({
                    cell.layer.borderWidth = 3
                    cell.layer.cornerRadius = 10
                }),
                completion: { _ in
                    UIView.animate(withDuration: 2) {
                        cell.layer.borderWidth = 0
                    }
                }
            )
            self.animated = false
        }
    }
    
    var animated: Bool = false
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
    
    func displayUpdated() {
        self.animated = true
    }
}

// MARK: - Display Logic

extension HistoryViewController: HistoryDisplayLogic {
    func displayChallengeList(viewModel: History.ViewModel.CellInfoList) {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.cellInfoList = viewModel
                self.historyCollectionView.reloadData()
            },
            completion: nil
        )
    }
    
    func displayChallengeEmptyView() {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                guard let self = self else {
                    return
                }
                self.historyCollectionView.isHidden = true
                self.historyEmptyView.isHidden = false
            },
            completion: nil
        )
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
