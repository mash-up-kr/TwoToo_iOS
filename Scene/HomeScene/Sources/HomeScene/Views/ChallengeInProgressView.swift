//
//  ChallengeProgressView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit

/// 챌린지 진행중 뷰
final class ChallengeInProgressView: UIView {
    /// 닉네임 정보, 챌린지 정보를 담은 스택뷰
    lazy var topChallengeInfoView: TopChallengeInfoView = {
        let v = TopChallengeInfoView()
        v.configure(viewModel: .init(challengeNameText: "30분이상 운동하기",
                                     dDayText: "D-22"))
        return v
    }()
    /// 챌린지 진행도 뷰
    lazy var progressBar: TTProgressBar = {
        let v = TTProgressBar()
        v.configure(viewModel: .init(partnerNameText: "상대상대",
                                     myNameText: "나요",
                                     partnerPercentageText: "33%",
                                     myPercentageText: "80%",
                                     partnerPercentageNumber: 33,
                                     myPercentageNumber: 80))
        return v
    }()
    /// 나와 상대의 닉네임 뷰
    lazy var trailingInfoStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        v.configure(viewModel: .init(challengeOrderText: "4번째 챌린지 진행중",
                                     partenrNameText: "상대상대",
                                     myNameText: "나요"))
        return v
    }()

    /// 내 꽃 정보 뷰
    lazy var myFlowerView: MyFlowerView = {
        let v = MyFlowerView()
        v.configure(viewModel: .init(image: .asset(.icon_step1_my)!,
                                     isCertificationButtonHidden: true,
                                     cetificationGuideText: "내 씨앗을 눌러 인증 해보세요!",
                                     isComplimentCommentHidden: false,
                                     complimentCommentText: "안녕하세요녕하세요녕",
                                     myNameText: "나의꽃"))
        return v
    }()
    /// 상대방 꽃 정보 뷰
    lazy var partnerFlowerView: PartnerFlowerView = {
        let v = PartnerFlowerView()
        v.configure(viewModel: .init(image: .asset(.icon_step3_mate)!,
                                     isCertificationCompleteHidden: true,
                                     isComplimentCommentHidden: false,
                                     complimentCommentText: "수고고수고수고수고수고수고수고수고수고수고수고수고수고수고",
                                     partnerNameText: "상대방꽃"))
        return v
    }()
    /// 찌르기 버튼
    lazy var nudgeBeeButton: UIButton = {
       let v = UIButton()
       v.setImage(.asset(.icon_push_bee), for: .normal)
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
        self.attribute()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubviews(self.topChallengeInfoView,
                         self.progressBar,
                         self.trailingInfoStackView,
                         self.myFlowerView,
                         self.partnerFlowerView,
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
        
        self.trailingInfoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.progressBar.snp.centerY)
            make.leading.equalTo(self.progressBar.snp.trailing).offset(10)
            make.height.equalTo(40)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.partnerFlowerView.snp.makeConstraints { make in
            make.bottom.equalTo(self.nudgeBeeButton.snp.top).offset(-22)
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        self.myFlowerView.snp.makeConstraints { make in
            make.bottom.equalTo(self.nudgeBeeButton.snp.top).offset(-22)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.width.equalToSuperview().dividedBy(2)
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
    
    func attribute() {
        
    }
    
}
