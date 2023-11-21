//
//  MyFlowerTopView.swift
//  
//
//  Created by Julia on 2023/09/17.
//

import UIKit
import DesignSystem

protocol MyFlowerTopInProgressDelegate: AnyObject {
    /// 물뿌리개를 탭 했을 때 - 인증
    func didTapWateringCanView()
    /// 비어있는 말풍선을 탭 했을 때
    func didTapEmptySpeechBubbleView()
}

protocol MyFlowerTopInCompletedDelegate: AnyObject {
    /// 꽃말 보기 말풍선을 탭 했을 때 - 팝업 띄우기
    func didTapShowMyFlowerLanguage()
}

final class MyFlowerTopView: UIView {
    
    weak var inProgressDelegate: MyFlowerTopInProgressDelegate?
    weak var inCompletedDelegate: MyFlowerTopInCompletedDelegate?
    
    // MARK: - 챌린지 진행 중
    /// 칭찬시 나타나는 말풍선
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(tailPosition: .my)
        v.isHidden = true
        return v
    }()
    /// 물뿌리개 인증 로티 뷰
    lazy var wateringCanView: WateringCanView = {
        let v = WateringCanView()
        v.isHidden = true
        v.addTapAction { [weak self] in
            self?.inProgressDelegate?.didTapWateringCanView()
        }
        return v
    }()
    /// 인증 완료 후 칭찬 문구 작성하기 말풍선 뷰
    lazy var complimentWriteBubbleImageView: UIImageView = {
        let v = UIImageView(.icon_bubble_write)
        v.isHidden = true
        v.isUserInteractionEnabled = true
        v.addTapAction { [weak self] in
            self?.inProgressDelegate?.didTapEmptySpeechBubbleView()
        }
        return v
    }()
    // MARK: - 챌린지 완료
    /// 꽃말 보기 말풍선 이미지
    lazy var showFlowerLanguageBubbleView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_bubble_flowerLanguage)
        v.isHidden = true
        v.isUserInteractionEnabled = true
        v.addTapAction { [weak self] in
            self?.inCompletedDelegate?.didTapShowMyFlowerLanguage()
        }
        return v
    }()
    
    /// 챌린지 실패시(꽃을 피우지 못 했을 때) 보여지는 말풍선 뷰
    lazy var challengeFailBubbleView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.bubble_challenge_fail)
        v.isHidden = true
        return v
    }()
    
    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.speechBubbleView,
                         self.wateringCanView,
                         self.showFlowerLanguageBubbleView,
                         self.complimentWriteBubbleImageView,
                         self.challengeFailBubbleView)
        
        self.remakeInProgressLayout()
        
        self.remakeCompletedLayout()
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel.TopViewModel) {
        self.remakeInProgressLayout()
        
        self.showFlowerLanguageBubbleView.snp.removeConstraints()
        self.challengeFailBubbleView.snp.removeConstraints()
        
        self.wateringCanView.titleLabel.text = viewModel.cetificationGuideText
        self.wateringCanView.titleLabel.isHidden = viewModel.isHiddenCetificationGuideText
        
        if viewModel.isCertificationButtonHidden {
            self.wateringCanView.isHidden = true
            self.wateringCanView.snp.removeConstraints()
        }
        else {
            self.wateringCanView.isHidden = false
        }
        
        if viewModel.isComplimentCommentHidden {
            self.speechBubbleView.isHidden = true
            self.complimentWriteBubbleImageView.isHidden = true
            
            self.speechBubbleView.snp.removeConstraints()
            self.complimentWriteBubbleImageView.snp.removeConstraints()
        }
        else {
            // 칭찬문구 O
            if !viewModel.complimentCommentText.isEmpty {
                self.speechBubbleView.configure(title: viewModel.complimentCommentText)
                self.speechBubbleView.isHidden = false
                self.complimentWriteBubbleImageView.isHidden = true
                
                self.complimentWriteBubbleImageView.snp.removeConstraints()
            }
            else { // 칭찬문구 X
                self.complimentWriteBubbleImageView.isHidden = false
                self.speechBubbleView.isHidden = true
                
                self.speechBubbleView.snp.removeConstraints()
            }
        }
    }
    
    func configureCompleted(isHidden isFlowerLanguageBubbleHidden: Bool) {
        self.remakeCompletedLayout()
        
        self.wateringCanView.snp.removeConstraints()
        self.complimentWriteBubbleImageView.snp.removeConstraints()
        self.speechBubbleView.snp.removeConstraints()
        
        if isFlowerLanguageBubbleHidden { // 챌린지 실패
            self.challengeFailBubbleView.isHidden = false
            self.showFlowerLanguageBubbleView.isHidden = true
            
            self.showFlowerLanguageBubbleView.snp.removeConstraints()
        } else { // 챌린지 성공
            self.challengeFailBubbleView.isHidden = true
            self.showFlowerLanguageBubbleView.isHidden = false
            
            self.challengeFailBubbleView.snp.removeConstraints()
        }
    }
    
    private func remakeInProgressLayout() {
        let speechBubbleBottom = UIDevice.current.deviceType == .default ? 15 : 32
        
        self.speechBubbleView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(150)
            make.bottom.equalToSuperview().offset(-speechBubbleBottom)
        }
        
        self.complimentWriteBubbleImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(62)
            make.bottom.equalToSuperview().offset(-speechBubbleBottom)
        }
        
        self.wateringCanView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func remakeCompletedLayout() {
        self.showFlowerLanguageBubbleView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(48)
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        self.challengeFailBubbleView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(63)
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
