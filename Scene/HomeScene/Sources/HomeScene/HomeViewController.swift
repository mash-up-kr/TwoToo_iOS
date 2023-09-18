//
//  HomeViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayChallengeCreatedViewModel(viewModel: Home.ViewModel.ChallengeCreatedViewModel)
    func displayChallengeWaitingViewModel(viewModel: Home.ViewModel.ChallengeWaitingViewModel)
    func displayChallengeBeforeStartViewModel(viewModel: Home.ViewModel.ChallengeBeforeStartViewModel)
    func displayChallengeBeforeStartDateViewModel(viewModel: Home.ViewModel.ChallengeBeforeStartDateViewModel)
    func displayChallengeAfterStartDateViewModel(viewModel: Home.ViewModel.ChallengeAfterStartDateViewModel)
    func displayChallengeInProgressViewModel(viewModel: Home.ViewModel.ChallengeInProgressViewModel)
    func displayChallengeCompletedViewModel(viewModel: Home.ViewModel.ChallengeCompletedViewModel)
    func displayBothCertificationViewModel(viewModel: Home.ViewModel.BothCertificationViewModel)
    func displayCompletedViewModel(viewModel: Home.ViewModel.CompletedViewModel)
    func displayToast(viewModel: Home.ViewModel.Toast)
}

final class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic
    
    init(interactor: HomeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    /// 네비게이션 바
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo",
                                rightButtonImage: .asset(.icon_info))
        v.delegate = self
        return v
    }()
    
    lazy var createdView: ChallengeCreatedView = {
        let v = ChallengeCreatedView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var waitingView: ChallengeWaitingView = {
        let v = ChallengeWaitingView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var beforeStartView: ChallengeBeforeStartView = {
        let v = ChallengeBeforeStartView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var beforeStartDateView: ChallengeBeforeStartDateView = {
        let v = ChallengeBeforeStartDateView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var afterStartDateView: ChallengeAfterStartDateView = {
        let v = ChallengeAfterStartDateView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var inProgressView: ChallengeInProgressView = {
        let v = ChallengeInProgressView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    lazy var completedView: ChallengeCompletedView = {
        let v = ChallengeCompletedView()
        v.isHidden = true
        v.delegate = self
        return v
    }()
    
    var bothCertificationPopupView: TTPopup?
    
    var completedPopupView: TTPopup?
    
    lazy var groundImageView: UIImageView = {
        let v = UIImageView(.home_ground)
        return v
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubviews(self.navigationBar,
                              self.groundImageView,
                              self.createdView,
                              self.waitingView,
                              self.beforeStartView,
                              self.beforeStartDateView,
                              self.afterStartDateView,
                              self.inProgressView,
                              self.completedView)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let tabBarHeight: CGFloat = UIDevice.current.safeAreaBottomHeight + 61
        let groundHeight = UIDevice.current.deviceType == .default ? 170 : 212
        
        self.groundImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(groundHeight)
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        
        self.createdView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.waitingView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.beforeStartView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.beforeStartDateView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.afterStartDateView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.inProgressView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        self.completedView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension HomeViewController: HomeScene {
    
}

// MARK: - Display Logic

extension HomeViewController: HomeDisplayLogic {
    
    func displayChallengeCreatedViewModel(viewModel: Home.ViewModel.ChallengeCreatedViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.createdView.configure(viewModel: viewModel)
            self?.createdView.isHidden = false
        }
    }
    
    func displayChallengeWaitingViewModel(viewModel: Home.ViewModel.ChallengeWaitingViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.waitingView.configure(viewModel: viewModel)
            self?.waitingView.isHidden = false
        }
    }
    
    func displayChallengeBeforeStartViewModel(viewModel: Home.ViewModel.ChallengeBeforeStartViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.beforeStartView.configure(viewModel: viewModel)
            self?.beforeStartView.isHidden = false
        }
    }
    
    func displayChallengeBeforeStartDateViewModel(viewModel: Home.ViewModel.ChallengeBeforeStartDateViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.beforeStartDateView.configure(viewModel: viewModel)
            self?.beforeStartDateView.isHidden = false
        }
    }
    
    func displayChallengeAfterStartDateViewModel(viewModel: Home.ViewModel.ChallengeAfterStartDateViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.afterStartDateView.configure(viewModel: viewModel)
            self?.afterStartDateView.isHidden = false
        }
    }
    
    func displayChallengeInProgressViewModel(viewModel: Home.ViewModel.ChallengeInProgressViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.inProgressView.configure(viewModel: viewModel)
            self?.inProgressView.isHidden = false
        }
    }
    
    func displayChallengeCompletedViewModel(viewModel: Home.ViewModel.ChallengeCompletedViewModel) {
        self.displayWithClearAndAnimation { [weak self] in
            self?.completedView.configure(viewModel: viewModel)
            self?.completedView.isHidden = false
        }
    }
    
    func displayBothCertificationViewModel(viewModel: Home.ViewModel.BothCertificationViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                let popupView = TTPopup()
                popupView.configure(title: Home.ViewModel.BothCertificationViewModel.title,
                                    resultView: popupContentView,
                                    description: Home.ViewModel.BothCertificationViewModel.message,
                                    buttonTitles: [
                                        Home.ViewModel.BothCertificationViewModel.noOptionText,
                                        Home.ViewModel.BothCertificationViewModel.yesOptionText
                                    ])
                
                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapBothCertificationPopupNoOption()
                    }
                }
                
                popupView.didTapRightButton {
                    Task {
                        await self?.interactor.didTapBothCertificationPopupYesOption()
                    }
                }
                
                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapBothCertificationPopupBackground()
                    }
                }
                
                self?.bothCertificationPopupView = popupView
                
                if let bothCertificationPopupView = self?.bothCertificationPopupView {
                    self?.view.addSubview(bothCertificationPopupView)
                }
            }
            
            viewModel.dismiss.unwrap {
                self?.bothCertificationPopupView?.removeFromSuperview()
                self?.bothCertificationPopupView = nil
            }
        }
    }
    
    func displayCompletedViewModel(viewModel: Home.ViewModel.CompletedViewModel) {
        self.displayWithAnimation { [weak self] in
            viewModel.show.unwrap {
                let popupContentView = UIView()
                let imageView = UIImageView()
                imageView.image = $0.image
                imageView.contentMode = .scaleAspectFit
                popupContentView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                let popupView = TTPopup()
                popupView.configure(title: $0.title,
                                     resultView: popupContentView,
                                     description: $0.message,
                                     buttonTitles: [Home.ViewModel.CompletedViewModel.optionText])
                
                popupView.didTapLeftButton {
                    Task {
                        await self?.interactor.didTapChallengeCompletedPopupConfirmButton()
                    }
                }
                
                popupView.didTapBackground {
                    Task {
                        await self?.interactor.didTapChallengeCompletedPopupBackground()
                    }
                }
                
                self?.completedPopupView = popupView
                
                if let completedPopupView = self?.completedPopupView {
                    self?.view.addSubview(completedPopupView)
                }
            }
            
            viewModel.dismiss.unwrap {
                self?.completedPopupView?.removeFromSuperview()
                self?.completedPopupView = nil
            }
        }
    }
    
    func displayToast(viewModel: Home.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
    
    /// 뷰를 정리하고 애니메이션과 함께 뷰를 그립니다.
    private func displayWithClearAndAnimation(animations: @escaping () -> Void) {
        self.displayWithAnimation { [weak self] in
            self?.displayClearView()
            animations()
        }
    }
    
    /// 애니메이션과 함께 뷰를 그립니다.
    private func displayWithAnimation(animations: @escaping () -> Void) {
        UIView.transition(
            with: self.view,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: animations,
            completion: nil
        )
    }
    
    /// 홈 뷰를 정리합니다.
    private func displayClearView() {
        self.createdView.isHidden = true
        self.waitingView.isHidden = true
        self.beforeStartView.isHidden = true
        self.beforeStartDateView.isHidden = true
        self.afterStartDateView.isHidden = true
        self.inProgressView.isHidden = true
        self.completedView.isHidden = true
    }
}

// MARK: - Delegate
extension HomeViewController: ChallengeCreatedViewDelegate{
    func didTapChallengeCreatedStartButton() {
        Task {
            await self.interactor.didTapChallengeStartButton()
        }
    }
}

extension HomeViewController: ChallengeWaitingViewDelegate{
    func didTapChallengeWaitingConfirmButton() {
        Task {
            await self.interactor.didTapChallengeConfirmButton()
        }
    }
}

extension HomeViewController: ChallengeBeforeStartViewDelegate{
    func didTapChallengeBeforeStartConfirmButton() {
        Task {
            await self.interactor.didTapChallengeConfirmButton()
        }
    }
}

extension HomeViewController: ChallengeBeforeStartDateViewDelegate{
    func didTapChallengeBeforeStartDateViewConfirmButton() {
        Task {
            await self.interactor.didTapChallengeConfirmButton()
        }
    }
}
extension HomeViewController: ChallengeAfterStartDateViewDelegate{
    func didTapChallengeAfterStartDateStartButton() {
        Task {
            await self.interactor.didTapChallengeStartButton()
        }
    }
}
extension HomeViewController: ChallengeInProgressViewDelegate{
    func didTapChallengeInfo() {
        Task {
            await self.interactor.didTapChallengeInfo()
        }
    }
    
    func didTapMyFlowerEmptySpeechBubbleView() {
        Task {
            await self.interactor.didTapMyComplimentCommnet()
        }
    }
    
    func didTapCertificateButton() {
        Task {
            await self.interactor.didTapMyFlower()
        }
    }
    
    func didTapStickButton() {
        Task {
            await self.interactor.didTapStickButton()
        }
    }
}
extension HomeViewController: ChallengeCompletedViewDelegate{
    func didTapChallengeCompletedFinishButton() {
        Task {
            await self.interactor.didTapChallengeCompleteButton()
        }
    }
}

extension HomeViewController: TTNavigationBarDelegate {
    func didTapRightButton() {
        Task {
            await self.interactor.didTapGuideButton()
        }
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
