//
//  ChallengeConfirmViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeConfirmDisplayLogic: AnyObject {
    func displayCreateView(info: ChallengeConfirm.ViewModel.ChallengeInfo)
    func displayConfirmView(info: ChallengeConfirm.ViewModel.ChallengeInfo)
    func displayAcceptView(info: ChallengeConfirm.ViewModel.ChallengeInfo)
    
    func displayOptionPopup(title: String)
    func displayQuitPopup(viewModel: ChallengeConfirm.ViewModel.QuitPopup)
    func dismissQuitPopup()
    func displayToast(message: String)
}

final class ChallengeConfirmViewController: UIViewController {
    var interactor: ChallengeConfirmBusinessLogic

    // MARK: - UI

    private lazy var navigationbar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar()
        v.configure(title: nil, 
                    leftButtonImage: .asset(.icon_back),
                    rightButtonImage: nil)
        v.delegate = self
        return v
    }()

    private lazy var headerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()

    private lazy var processLabel: UILabel = {
        let v = UILabel()
        v.text = "3/3"
        v.textColor = .primary
        v.font = .h1
        return v
    }()

    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지 정보를 확인해주세요"
        v.font = .h1
        v.textColor = .primary
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "생성한 챌린지는 수정이 어려우니 한번 더 확인해주세요"
        v.textColor = .grey600
        v.font = .body2
        return v
    }()
    
    private lazy var challengeContentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()

    private lazy var challengeConfirmView: UIView = {
        let v = UIView()
        v.backgroundColor = .mainWhite
        return v
    }()

    private lazy var challenageTitleStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 12
        return v
    }()

    private lazy var challengeTitleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h3
        return v
    }()

    private lazy var challengeDateLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h4
        return v
    }()

    private lazy var challengeRuleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey600
        v.font = .body2
        v.numberOfLines = 0
        return v
    }()

    private lazy var challengeTitleView: UIView = {
        let v = UIView()
        v.backgroundColor = .second01
        return v
    }()

    private lazy var challengeAppLabel: UILabel = {
        let v = UILabel()
        v.text = "Twotoo challenge"
        v.font = .body1
        v.textColor = .primary
        return v
    }()

    private lazy var challengeImage: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_seed)
        return v
    }()
    
    lazy var popupView: TTPopup = {
        let v = TTPopup()
        v.isHidden = true
        v.didTapLeftButton {
            Task {
                await self.interactor.didTapQuitPopupCancelButton()
            }
        }
        v.didTapRightButton {
            Task {
                await self.interactor.didTapQuitPopupQuitButton()
            }
        }
        v.didTapBackground {
            Task {
                await self.interactor.didTapQuitPopupBackground()
            }
        }
        return v
    }()

    private lazy var nextButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "다음", .large)
        v.setIsEnabled(true)
        v.addAction { [weak self] in
            Task {
                await self?.interactor.didTapNextButton()
            }
        }
        return v
    }()

    init(interactor: ChallengeConfirmBusinessLogic) {
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
        self.registNotification()

        Task {
            await self.interactor.didAppear()
        }
    }
    
    @objc private func viewDidAppearWithModalDismissed() {
        Task {
            Loading.shared.showLoadingView()
            await self.interactor.didAppear()
            Loading.shared.stopLoadingView()
        }
    }
    
    private func registNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.viewDidAppearWithModalDismissed),
            name: NSNotification.Name("modal_dismissed"),
            object: nil
        )
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()

        self.headerStackView.addArrangedSubviews(self.processLabel, self.headerLabel, self.captionLabel)
        self.challenageTitleStackView.addArrangedSubviews(self.challengeTitleLabel, self.challengeDateLabel)
        self.challengeConfirmView.addSubviews(self.challenageTitleStackView, self.challengeRuleLabel)
        self.challengeTitleView.addSubviews(self.challengeAppLabel, self.challengeImage)
        self.challengeContentView.addSubviews(self.challengeConfirmView, self.challengeTitleView)
        self.view.addSubviews(self.navigationbar, 
                              self.headerStackView,
                              self.challengeContentView,
                              self.nextButton,
                              self.popupView)

        self.headerStackView.setCustomSpacing(8, after: self.processLabel)
        self.headerStackView.setCustomSpacing(12, after: self.headerLabel)

        self.navigationbar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationbar.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-35)
            make.bottom.equalTo(self.challengeConfirmView.snp.top).offset(-41)
        }
        
        self.challengeContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(66)
            make.trailing.equalToSuperview().offset(-66)
            make.bottom.lessThanOrEqualTo(self.nextButton.snp.top).offset(-100)
        }

        self.challengeConfirmView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.challengeTitleView.snp.top)
            make.height.equalTo(UIScreen.main.bounds.height * 0.30)
            make.top.equalToSuperview()
        }

        self.challenageTitleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            
        }

        self.challengeRuleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.challenageTitleStackView.snp.bottom).offset(20)
            make.leading.equalTo(self.challenageTitleStackView.snp.leading)
            make.trailing.equalTo(self.challenageTitleStackView.snp.trailing)
        }

        self.challengeTitleView.snp.makeConstraints { make in
            make.leading.equalTo(self.challengeConfirmView.snp.leading)
            make.trailing.equalTo(self.challengeConfirmView.snp.trailing)
            make.bottom.equalToSuperview()
        }

        self.challengeAppLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(36)
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }

        self.challengeImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-39)
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-21)
            make.width.equalTo(self.challengeImage.snp.height)
        }

        self.nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-54)
        }
        
        self.popupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(273)
            make.height.equalTo(349)
        }
    }
}

// MARK: - Trigger

extension ChallengeConfirmViewController: TTNavigationDetailBarDelegate {
    func didTapDetailLeftButton() {
        Task {
            await self.interactor.didTapBackButton()
        }
    }
    
    func didTapDetailRightButton() {
        Task {
            await self.interactor.didTapOptionButton()
        }
    }
    
}

// MARK: - Trigger by Parent Scene

extension ChallengeConfirmViewController: ChallengeConfirmScene {
    
}

// MARK: - Display Logic

extension ChallengeConfirmViewController: ChallengeConfirmDisplayLogic {
    func displayCreateView(info: ChallengeConfirm.ViewModel.ChallengeInfo) {
        self.challengeTitleLabel.text = info.title
        self.challengeDateLabel.text = info.date
        self.challengeRuleLabel.text = info.rule
    }

    func displayConfirmView(info: ChallengeConfirm.ViewModel.ChallengeInfo) {
        self.challengeTitleLabel.text = info.title
        self.challengeDateLabel.text = info.date
        self.challengeRuleLabel.text = info.rule

        self.headerStackView.isHidden = true
        self.nextButton.isHidden = true
        self.navigationbar.configure(title: "챌린지 정보",
                                     leftButtonImage: .asset(.icon_back),
                                     rightButtonImage: .asset(.icon_more))
    }

    func displayAcceptView(info: ChallengeConfirm.ViewModel.ChallengeInfo) {
        self.challengeTitleLabel.text = info.title
        self.challengeDateLabel.text = info.date
        self.challengeRuleLabel.text = info.rule

        self.title = ""
        self.processLabel.isHidden = true
    }
    
    // MARK: - Display Popup
    func displayQuitPopup(viewModel: ChallengeConfirm.ViewModel.QuitPopup) {
        self.popupView.configure(title: viewModel.title,
                                 resultView: UIImageView(image: viewModel.iconImage),
                                 description: viewModel.description,
                                 warningText: viewModel.warning,
                                 buttonTitles: viewModel.buttonTitles)
        self.popupView.isHidden = false
    }
    
    func displayOptionPopup(title: String) {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .destructive) { [weak self] _ in
            Task {
                await self?.interactor.didTapOptionPopupQuitButton()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            Task {
                await self.interactor.didTapQuitPopupCancelButton()
            }
        }
        alertVC.addAction(action)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true)
    }
    
    func dismissQuitPopup() {
        self.popupView.isHidden = true
    }
    
    func displayToast(message: String) {
        Toast.shared.makeToast(message)
    }
    
}
