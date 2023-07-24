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

protocol FlowerSelectDisplayLogic: AnyObject {}

final class FlowerSelectViewController: UIViewController {
    var interactor: FlowerSelectBusinessLogic

    // MARK: - UI
    
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
        return v
    }()

    private lazy var flowerCollectionView: UICollectionView = {
        let v = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        v.registerCell(FlowerSelectCell.self)
        v.delegate = self
        v.dataSource = self
        v.collectionViewLayout = createCollectionViewlayout()
        v.backgroundColor = .second02
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
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02

        self.headerStackView.addArrangedSubviews(self.headerLabel, self.captionLabel)
        self.view.addSubviews(self.headerStackView, self.flowerCollectionView, self.challengeButton)

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(2)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalTo(self.flowerCollectionView.snp.top).offset(-25)
        }

        self.flowerCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-100)
        }

        self.challengeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-54)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension FlowerSelectViewController: FlowerSelectScene {
    
}

// MARK: - Display Logic

extension FlowerSelectViewController: FlowerSelectDisplayLogic {
    
}

extension FlowerSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: FlowerSelectCell.self, indexPath: indexPath)

//        cell.configure(image: arr[indexPath.row].image, title: arr[indexPath.row].titlle, description: arr[indexPath.row].decs)

        return cell
    }
}
