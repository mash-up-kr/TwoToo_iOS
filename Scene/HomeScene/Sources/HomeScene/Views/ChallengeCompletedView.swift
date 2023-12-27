//
//  ChallengeFinishView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit
import DesignSystem

protocol ChallengeCompletedViewDelegate: AnyObject {
    /// 챌린지 정보를 탭 했을 때
    func didTapChallengeInfo()
    /// 챌린지 완료하기 버튼 탭 했을 때
    func didTapChallengeCompletedFinishButton()
    /// 내 꽃말 보기 이미지 뷰를 탭했을 때
    func didTapShowFlowerLaunage(viewModel: Home.ViewModel.ChallengeCompletedViewModel.FlowerLanguagePopupViewModel)
}

/// 챌린지 완료 후 보여질 화면입니다.
final class ChallengeCompletedView: UIView {
    
    weak var delegate: ChallengeCompletedViewDelegate?

    /// 닉네임 정보, 챌린지 정보를 담은 스택뷰
    lazy var topChallengeInfoView: TopChallengeInfoView = {
        let v = TopChallengeInfoView()
        v.addTapAction { [weak self] in
            self?.delegate?.didTapChallengeInfo()
        }
        return v
    }()
    /// 챌린지 진행도 뷰
    lazy var progressBar: TTProgressBar = {
        let v = TTProgressBar()
        v.isHidden = true
        return v
    }()
    /// 나와 상대의 닉네임 뷰
    lazy var nicknameStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        return v
    }()
    /// 내 꽃 상위 컴포넌트
    lazy var myFlowerTopView: MyFlowerTopView = {
        let v = MyFlowerTopView()
        v.inCompletedDelegate = self
        return v
    }()
    /// 내 꽃 정보 뷰
    lazy var myFlowerView: MyFlowerView = {
        let v = MyFlowerView()
        return v
    }()
    /// 상대방 꽃 상위 컴포넌트
    lazy var partnerFlowerTopView: PartnerFlowerTopView = {
        let v = PartnerFlowerTopView()
        v.inCompletedDelegate = self
        return v
    }()
    /// 상대방 꽃 정보 뷰
    lazy var partnerFlowerView: PartnerFlowerView = {
        let v = PartnerFlowerView()
        return v
    }()
    /// 챌린지 완료하기 버튼
    lazy var confirmButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "챌린지 완료하기", .small)
        v.setIsEnabled(true)
        v.addAction { [weak self] in
            self?.delegate?.didTapChallengeCompletedFinishButton()
        }
        return v
    }()

    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubviews(self.topChallengeInfoView,
                         self.progressBar,
                         self.nicknameStackView,
                         self.myFlowerView,
                         self.partnerFlowerView,
                         self.myFlowerTopView,
                         self.partnerFlowerTopView,
                         self.confirmButton)
                
        self.topChallengeInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.progressBar.snp.makeConstraints { make in
           make.top.equalTo(self.topChallengeInfoView.snp.bottom).offset(11)
           make.leading.equalToSuperview().offset(24)
           make.width.equalToSuperview().multipliedBy(0.55)
           make.height.equalTo(62)
       }
        
        self.nicknameStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.progressBar.snp.centerY)
            make.leading.equalTo(self.progressBar.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().inset(24)
        }
        
        let flowerBottomOffset = UIDevice.current.deviceType == .default ? -12 : 33
        
        // --> PartnerFlower
        self.partnerFlowerTopView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.progressBar.snp.bottom).offset(2)
            make.width.equalToSuperview().dividedBy(2)
            make.leading.equalToSuperview()
//            make.centerX.equalToSuperview().multipliedBy(0.58)
        }
        
        self.partnerFlowerView.snp.makeConstraints { make in
            make.top.equalTo(self.partnerFlowerTopView.snp.bottom).offset(5)
            make.width.equalToSuperview().dividedBy(2)
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.confirmButton.snp.top).offset(-flowerBottomOffset)
        }
        
        // --> MyFlower
        self.myFlowerTopView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.progressBar.snp.bottom).offset(2)
            make.width.equalToSuperview().dividedBy(2)
            make.trailing.equalToSuperview()
//            make.centerX.equalToSuperview().multipliedBy(1.42) // 진행중도 테스트 해봐야 함
        }
        
        self.myFlowerView.snp.makeConstraints { make in
            make.top.equalTo(self.myFlowerTopView.snp.bottom).offset(5)
            make.width.equalToSuperview().dividedBy(2)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.confirmButton.snp.top).offset(-flowerBottomOffset)
        }

        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(49)
            make.width.equalTo(177)
        }
    }
    
    private var myPopupViewModel: Home.ViewModel.ChallengeCompletedViewModel.FlowerLanguageViewModel?
    private var partnerPopupViewModel: Home.ViewModel.ChallengeCompletedViewModel.FlowerLanguageViewModel?
    
    func configure(viewModel: Home.ViewModel.ChallengeCompletedViewModel) {
        self.topChallengeInfoView.configureCompleted(viewModel: viewModel.challengeInfo)
        self.progressBar.configure(viewModel: viewModel.progress)
        self.nicknameStackView.configure(challengeOrderText: viewModel.order.challengeOrderText,
                                         myNickname: viewModel.order.myNameText,
                                         partnerNickname: viewModel.order.partenrNameText)
        self.myFlowerView.configureCompleted(viewModel: viewModel.myFlower)
        self.myFlowerTopView.configureCompleted(isHidden: viewModel.myFlower.isFlowerLanguageBubbleHidden)
        self.myPopupViewModel = viewModel.myFlower.flowerLanguagePopup
        self.partnerFlowerView.configureCompleted(viewModel: viewModel.partnerFlower)
        self.partnerFlowerTopView.configureCompleted(isHidden: viewModel.partnerFlower.isFlowerLanguageBubbleHidden)
        self.partnerPopupViewModel = viewModel.partnerFlower.flowerLanguagePopup
    }
    
}

// MARK: - ChallengeCompletedViewDelegate
extension ChallengeCompletedView: MyFlowerTopInCompletedDelegate, PartnerFlowerTopInCompletedDelegate {
    func didTapShowMyFlowerLanguage() {
        if let viewModel = myPopupViewModel {
            self.delegate?.didTapShowFlowerLaunage(viewModel: .init(show: viewModel, dismiss: nil))
        }
    }
    
    func didTapShowPartnerFlowerLanguage() {
        if let viewModel = partnerPopupViewModel {
            self.delegate?.didTapShowFlowerLaunage(viewModel: .init(show: viewModel, dismiss: nil))
        }
    }
}
