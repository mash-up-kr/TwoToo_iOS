//
//  LoginViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayOnboarding(viewModel: Login.ViewModel.Onborading)
}

final class LoginViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var interactor: LoginBusinessLogic

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.identifier)
        v.backgroundColor = .white
        return v
    }()

    lazy var onboardingPageControl: UIPageControl = {
        let v = UIPageControl()
        v.currentPage = 0
        v.pageIndicatorTintColor = .grey400
        v.currentPageIndicatorTintColor = .grey500
        v.numberOfPages = 3
        return v
    }()

    lazy var kakaoLogin: UIButton = {
        let v = UIButton()
        v.setTitle("hello", for: .normal)
        v.layer.cornerRadius = 20
        v.backgroundColor = .grey400
//        v.isHidden = true
        return v
    }()

    lazy var appleLogin: UIButton = {
        let v = UIButton()
        v.setTitle("hello", for: .normal)
        v.layer.cornerRadius = 20
        v.backgroundColor = .grey400
//        v.isHidden = true
        return v
    }()

    lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.distribution = .fillEqually
        v.spacing = 16
        return v
    }()
    
    init(interactor: LoginBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

        Task {
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.collectionView, self.onboardingPageControl, self.buttonStackView)
        self.buttonStackView.addArrangedSubviews(self.kakaoLogin, self.appleLogin)

        self.collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.onboardingPageControl.snp.top).offset(-32)
        }

        self.onboardingPageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.buttonStackView.snp.top).offset(-29)
            make.height.equalTo(12)
        }

        self.buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-36)
        }
    }

    var onboardingItems: [Login.ViewModel.Onborading.Item] = []
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension LoginViewController: LoginScene {
    
}

// MARK: - Display Logic

extension LoginViewController: LoginDisplayLogic {
    func displayOnboarding(viewModel: Login.ViewModel.Onborading) {
        viewModel.items.unwrap {
            self.onboardingItems = $0
            self.collectionView.reloadData()
        }
    }
}

extension LoginViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.onboardingItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: LoginCollectionViewCell.self, indexPath: indexPath)
        cell.configure(image: onboardingItems[indexPath.row].image, text: onboardingItems[indexPath.row].text)
        return cell
    }
}

extension LoginViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
