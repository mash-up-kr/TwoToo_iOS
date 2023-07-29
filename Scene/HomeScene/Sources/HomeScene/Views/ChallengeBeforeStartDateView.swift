//
//  ChallengeBeforeStartView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit
import DesignSystem

protocol ChallengeBeforeStartDateViewDelegate: AnyObject {
    func didTapChallengeBeforeStartDateViewConfirmButton()
}

/// 챌린지 시작일 전 보여질 화면입니다.
final class ChallengeBeforeStartDateView: UIView {
    
    weak var delegate: ChallengeBeforeStartDateViewDelegate?
    
    lazy var nicknameStackView: TrailingInfoStackView = {
        let v = TrailingInfoStackView()
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h1
        v.text = "챌린지 대기중이에요"
        v.textAlignment = .center
        v.numberOfLines = 2
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.text = "아직 챌린지 시작 전이에요!\n시작날짜에 다시 들어와주세요!"
        v.numberOfLines = 2
        v.textColor = .grey600
        v.font = .body2
        v.setLineSpacing(10)
        v.textAlignment = .center
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let v = UIImageView(.icon_sleepingseed)
        return v
    }()
    
    lazy var confirmButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "챌린지 확인하기", .small)
        v.setIsEnabled(true)
        v.addAction { [weak self] in
            self?.delegate?.didTapChallengeBeforeStartDateViewConfirmButton()
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
                         self.descriptionLabel,
                         self.iconImageView,
                         self.confirmButton)
        
        self.nicknameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(26)
            make.height.equalTo(40)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-25)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.iconImageView.snp.top).offset(-10)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(177)
        }
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeBeforeStartDateViewModel) {
        self.nicknameStackView.configure(challengeOrderText: nil,
                                         myNickname: viewModel.myNameText,
                                         partnerNickname: viewModel.partnerNameText)
    }
}
