//
//  FlowerSelectViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import DesignSystem

protocol FlowerSelectDisplayLogic: AnyObject {
    /// 꽃 리스트를 보여준다.
    func displayFlowerSelectView(viewModel: FlowerSelect.ViewModel.Flower)
    /// 챌린지 수락 버전 버튼을 보여준다.
    func displayAccpetView(viewModel: FlowerSelect.ViewModel.createChallengeButton)
    /// 챌린지 생성 버전 버튼을 보여준다.
    func displayCrateView(viewModel: FlowerSelect.ViewModel.createChallengeButton)
    /// 꽃을 선택한 화면을 보여준다.
    func displayFlowerSelect(viewModel: FlowerSelect.ViewModel.FlowerSelect)
    /// 챌린지 생성 실패 토스트를 보여준다.
    func displayCreateChallengeFailToast(viewModel: FlowerSelect.ViewModel.Toast)
    /// 챌린지 시작 실패 토스트를 보여준다.
    func displayStartChallengeFailToast(viewModel: FlowerSelect.ViewModel.Toast)
    /// 챌린지 시작 성공 토스트를 보여준다.
    func displayStartChallengeSuccessToast(viewModel: FlowerSelect.ViewModel.Toast)
}

final class FlowerSelectViewController: UIViewController, TTNavigationDetailBarDelegate {
    var interactor: FlowerSelectBusinessLogic
    private var flowerItems: FlowerSelect.ViewModel.Flower = .init()
    private var selectedFlower: FlowerSelect.ViewModel.FlowerSelect = .init()
    
    // MARK: - UI

    private lazy var navigationbar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar()
        v.configure(title: "",
                    leftButtonImage: .asset(.icon_back),
                    rightButtonImage: nil)
        v.delegate = self
        return v
    }()

    private lazy var headerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 26
        return v
    }()

    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지를 하는동안\n짝꿍이 키울 꽃을 골라주세요"
        v.font = .h1
        v.textColor = .primary
        v.numberOfLines = 0
        v.setLineSpacing(11)
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "어떤 꽃인지는 챌린지 종료 후 확인할 수 있습니다 :)"
        v.textColor = .grey600
        v.font = .body2
        return v
    }()

    private lazy var challengeButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "챌린지 보내기", .large)
        v.setIsEnabled(true)
        v.didTapButton { [weak self] in
            Task {
                Loading.shared.showLoadingView()
                await self?.interactor.didTapButton()
                Loading.shared.stopLoadingView()
            }
        }
        return v
    }()

    private lazy var flowerCollectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        v.registerCell(FlowerSelectCell.self)
        v.delegate = self
        v.dataSource = self
        v.collectionViewLayout = createCollectionViewlayout()
        v.setBackgroundDefault()
        v.showsVerticalScrollIndicator = false
        return v
    }()

    private func createCollectionViewlayout() -> UICollectionViewLayout {
        let itemSpacing: CGFloat = 13
        let horizontalPadding: CGFloat = 48
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - horizontalPadding - itemSpacing) / 2
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cellWidth),
            heightDimension: .absolute(cellWidth)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/2)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(13)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 13

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(110)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        ]

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    init(interactor: FlowerSelectBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

        Task {
            await self.interactor.didLoad()
        }
    }

    func didTapDetailLeftButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func didTapDetailRightButton() {

    }


    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()

        self.headerStackView.addArrangedSubviews(self.headerLabel, self.captionLabel)
        self.view.addSubviews(self.navigationbar,
            self.headerStackView, self.flowerCollectionView, self.challengeButton)

        self.navigationbar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationbar.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalTo(self.flowerCollectionView.snp.top).offset(-25)
        }

        self.flowerCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.challengeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}

// MARK: - Trigger

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension FlowerSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flowerItems.flowers?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: FlowerSelectCell.self, indexPath: indexPath)
        cell.configure(item: self.flowerItems.flowers?[indexPath.row])
        cell.configure(isEnabled: indexPath.item == self.selectedFlower.indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Task {
            await self.interactor.didTapFlower(flowerIndex: self.selectedFlower.indexPath == indexPath.item ? nil : indexPath.row)
        }
    }
}

// MARK: - Trigger by Parent Scene

extension FlowerSelectViewController: FlowerSelectScene {
    
}

// MARK: - Display Logic

extension FlowerSelectViewController: FlowerSelectDisplayLogic {
    func displayAccpetView(viewModel: FlowerSelect.ViewModel.createChallengeButton) {
        self.challengeButton.isHidden = viewModel.isHidden
        self.challengeButton.setTitle(viewModel.title, for: .normal)
    }
    
    func displayCrateView(viewModel: FlowerSelect.ViewModel.createChallengeButton) {
        self.challengeButton.isHidden = viewModel.isHidden
        self.challengeButton.setTitle(viewModel.title, for: .normal)
    }
    
    func displayFlowerSelectView(viewModel: FlowerSelect.ViewModel.Flower) {
        flowerItems = viewModel
        self.flowerCollectionView.reloadData()
    }
    
    func displayFlowerSelect(viewModel: FlowerSelect.ViewModel.FlowerSelect) {
        self.challengeButton.isHidden = viewModel.indexPath == nil
        self.selectedFlower = viewModel
        self.flowerCollectionView.reloadData()
    }
    
    func displayCreateChallengeFailToast(viewModel: FlowerSelect.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
    
    func displayStartChallengeFailToast(viewModel: FlowerSelect.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
    
    func displayStartChallengeSuccessToast(viewModel: FlowerSelect.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}
