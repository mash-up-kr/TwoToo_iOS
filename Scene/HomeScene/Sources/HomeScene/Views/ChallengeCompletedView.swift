//
//  ChallengeFinishView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit
import DesignSystem

/// 챌린지 완료 후 보여질 화면입니다.
final class ChallengeCompletedView: UIView {
    /// 닉네임 정보, 챌린지 정보를 담은 스택뷰
    lazy var topChallengeInfoView: TopChallengeInfoView = {
        let v = TopChallengeInfoView()
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
                         self.confirmButton)
                
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
            make.centerX.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview().multipliedBy(1.05)
            make.width.equalToSuperview().dividedBy(2)
        }

        self.myFlowerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.05)
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.width.equalToSuperview().dividedBy(2)
        }

        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.7)
            make.width.equalTo(177)
        }
        
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeCompletedViewModel) {
        self.topChallengeInfoView.configureCompleted(viewModel: viewModel.challengeInfo)
        self.progressBar.configureCompleted(viewModel: viewModel.progress)
        self.nicknameStackView.configure(challengeOrderText: viewModel.order.challengeOrderText,
                                         myNickname: viewModel.order.myNameText,
                                         partnerNickname: viewModel.order.partenrNameText)
        self.partnerFlowerView.configureCompleted(viewModel: viewModel.partnerFlower)
        self.myFlowerView.configureCompleted(viewModel: viewModel.myFlower)
    }
    
}
