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
        v.configure(viewModel: .init(challengeOrderText: "4번째 챌린지중", partenrNameText: "파트너", myNameText: "나"))
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
        let v = UIImageView(.icon_flower_seed) // TODO: - 이미지 바뀐다함 ㅠㅠ
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
            make.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(99)
            make.trailing.equalToSuperview().inset(99)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
