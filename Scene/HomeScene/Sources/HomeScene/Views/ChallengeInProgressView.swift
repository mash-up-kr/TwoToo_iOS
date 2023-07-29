//
//  ChallengeProgressView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit

protocol ChallengeInProgressViewDelegate: AnyObject {
    func didTapCertificateButton()
    func didTapMyFlowerEmptySpeechBubbleView()
    func didTapStickButton()
    func didTapChallengeInfo()
}

/// 챌린지 진행중 뷰
final class ChallengeInProgressView: UIView {
    
    weak var delegate: ChallengeInProgressViewDelegate?

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
        return v
    }()
    /// 나와 상대의 닉네임 뷰
    lazy var nicknameStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        return v
    }()

    /// 내 꽃 정보 뷰
    lazy var myFlowerView: MyFlowerView = {
        let v = MyFlowerView()
        v.delegate = self
        return v
    }()
    /// 상대방 꽃 정보 뷰
    lazy var partnerFlowerView: PartnerFlowerView = {
        let v = PartnerFlowerView()
        return v
    }()
    /// 나와 상대 꽃 사이의 하트 이미지
    lazy var heartImage: UIImageView = {
        let v = UIImageView(image: .asset(.icon_heart))
        return v
    }()
    /// 찌르기 버튼
    lazy var nudgeBeeButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_push_bee), for: .normal)
        v.addAction { [weak self] in
            self?.delegate?.didTapStickButton()
        }
        return v
    }()
    /// 찌르기 버튼 타이틀
    lazy var nudgeTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "콕 찌르기 (5/5)"
        v.textColor = .primary
        v.font = .body2
        v.textAlignment = .center
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
                         self.heartImage,
                         self.nudgeBeeButton,
                         self.nudgeTitleLabel)
                
        self.topChallengeInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.113)
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
        
        self.partnerFlowerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        self.myFlowerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        self.heartImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.myFlowerView.snp.centerY)
        }
                
        self.nudgeBeeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(57)
            make.bottom.equalTo(self.nudgeTitleLabel.snp.top).offset(-8)
        }
        
        self.nudgeTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(38)
        }
        
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeInProgressViewModel) {
        self.topChallengeInfoView.configureInProgress(viewModel: viewModel.challengeInfo)
        self.progressBar.configureInProgress(viewModel: viewModel.progress)
        self.nicknameStackView.configure(challengeOrderText: viewModel.order.challengeOrderText,
                                         myNickname: viewModel.order.myNameText,
                                         partnerNickname: viewModel.order.partenrNameText)
        self.partnerFlowerView.configureInProgress(viewModel: viewModel.partnerFlower)
        self.myFlowerView.configureInProgress(viewModel: viewModel.myFlower)
        self.heartImage.isHidden = viewModel.isHeartHidden
        self.nudgeTitleLabel.text = viewModel.stickText
    }
    
}

extension ChallengeInProgressView: MyFlowerViewDelegate {
    func didTapEmptySpeechBubbleView() {
        self.delegate?.didTapMyFlowerEmptySpeechBubbleView()
    }
    
    func didTapCertificateView() {
        self.delegate?.didTapCertificateButton()
    }
}
