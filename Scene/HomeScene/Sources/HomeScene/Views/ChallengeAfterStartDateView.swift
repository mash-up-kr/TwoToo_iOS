//
//  ChallengeAfterStartDateViewModel.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit
import DesignSystem

/// 챌린지 시작일 초과 화면
final class ChallengeAfterStartDateView: UIView {
    
    lazy var nicknameStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h1
        v.text = "챌린지 확인 기간이 지났어요"
        v.numberOfLines = 2
        v.setLineSpacing(22)
        v.textAlignment = .center
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let v = UIImageView(.icon_cryingseed)
        return v
    }()
    
    lazy var startButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "챌린지 시작하기", .small)
        v.setIsEnabled(true)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.nicknameStackView,
                         self.titleLabel,
                         self.iconImageView,
                         self.startButton)
        
        self.nicknameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(26)
            make.width.equalTo(83)
            make.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(177)
        }
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeAfterStartDateViewModel) {
        self.nicknameStackView.configure(challengeOrderText: nil,
                                         myNickname: viewModel.myNameText,
                                         partnerNickname: viewModel.partnerNameText)
    }
}
