//
//  LoginViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import AuthenticationServices

protocol LoginDisplayLogic: AnyObject {
    func displayOnboarding(viewModel: Login.ViewModel.Onborading)
    func displaySocialLogin(viewModel: Login.ViewModel.SocialLogin)
    func displayToast(viewModel: Login.ViewModel.Toast)
}

final class LoginViewController: UIViewController {
    private var interactor: LoginBusinessLogic
    private var onboardingItems: [Login.ViewModel.Onborading.Item] = []

    // MARK: - UI

    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo", rightButtonImage: nil)
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 100)
        layout.minimumLineSpacing = 0

        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: LoginCollectionViewCell.identifier)
        v.backgroundColor = .second02
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        return v
    }()

    private lazy var onboardingPageControl: UIPageControl = {
        let v = UIPageControl()
        v.pageIndicatorTintColor = .grey400
        v.currentPageIndicatorTintColor = .grey500
        return v
    }()

    private lazy var kakaoLoginButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(named: "kakaoLogin", in: .module, with: nil), for: .normal)
        v.contentHorizontalAlignment = .fill
        v.layer.cornerRadius = 20
        v.addAction { [weak self] in
            Task {
                await self?.interactor.didTapKakaoLoginButton()
            }
        }
        return v
    }()

    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        var v: ASAuthorizationAppleIDButton
        if #available(iOS 13.2, *) {
            v = ASAuthorizationAppleIDButton(type: .default, style: .black)
            v.cornerRadius = 17
        }
        else {
            v = ASAuthorizationAppleIDButton(frame: .zero)
        }
        v.addAction { [weak self] in
            Task {
                await self?.interactor.didTapAppleLoginButton()
            }
        }
        return v
    }()

    private lazy var buttonStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 16
        v.isHidden = true
        return v
    }()
    
    init(interactor: LoginBusinessLogic) {
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
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02
        
        self.view.addSubviews(self.navigationBar,
                              self.collectionView,
                              self.onboardingPageControl,
                              self.buttonStackView)
        self.buttonStackView.addArrangedSubviews(self.kakaoLoginButton,
                                                 self.appleLoginButton)

        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.onboardingPageControl.snp.top).offset(-10)
        }
        self.onboardingPageControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.buttonStackView.snp.top).offset(-29)
            make.height.equalTo(12)
        }
        self.kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo((UIScreen.main.bounds.width - 48) * 57 / 327)
        }
        self.appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo((UIScreen.main.bounds.width - 48) * 57 / 327)
        }
        self.buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(36)
        }
    }
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
            self.onboardingPageControl.numberOfPages = self.onboardingItems.count
            self.collectionView.reloadData()
        }
    }

    func displaySocialLogin(viewModel: Login.ViewModel.SocialLogin) {
        viewModel.isHidden.unwrap { [weak self] hidden in
            self?.buttonStackView.isHidden = hidden
        }
    }
    
    func displayToast(viewModel: Login.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension LoginViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.onboardingItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: LoginCollectionViewCell.self, indexPath: indexPath)
        cell.configure(image: self.onboardingItems[indexPath.row].image, text: self.onboardingItems[indexPath.row].text)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension LoginViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        guard !value.isNaN else {
            return
        }
        
        self.onboardingPageControl.currentPage = Int(round(value))
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.view.frame.size.width)

        Task {
             await self.interactor.didSwipeOnboarding(index: index + 1)
        }
    }
}
