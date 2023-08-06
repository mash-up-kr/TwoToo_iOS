//
//  ChallengePreCreationView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit
import DesignSystem

protocol ChallengeCreatedViewDelegate: AnyObject {
    func didTapChallengeCreatedStartButton()
}

/// 챌린지 생성전 보여질 화면입니다.
final class ChallengeCreatedView: UIView {
    
    weak var delegate: ChallengeCreatedViewDelegate?
    
    lazy var nicknameStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h1
        v.text = "짝궁과 함께할 22일 챌린지를 \n시작해보세요"
        v.numberOfLines = 2
        v.setLineSpacing(11)
        v.textAlignment = .center
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let v = UIImageView(.icon_flower_seed)
        return v
    }()
    
    lazy var startButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "챌린지 시작하기", .small)
        v.setIsEnabled(true)
        v.addAction { [weak self] in
            self?.delegate?.didTapChallengeCreatedStartButton()
        }
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
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(177)
        }
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeCreatedViewModel) {
        self.nicknameStackView.configure(challengeOrderText: nil,
                                         myNickname: viewModel.myNameText,
                                         partnerNickname: viewModel.partnerNameText)
    }
    
}
    
