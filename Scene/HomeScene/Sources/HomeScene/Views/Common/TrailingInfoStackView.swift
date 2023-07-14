//
//  CoupleNicknameStackView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit

/// 내 닉네임 ❤️ 상대 닉네임, 챌린지 횟수 정보가 담긴 스택뷰
final class TrailingInfoStackView: UIView {
    
    lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        return v
    }()
    
    lazy var heartImageView: UIImageView = {
        let v = UIImageView(image: .asset(.icon_heart))
        return v
    }()
    
    lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        return v
    }()
    
    lazy var nicknameStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 7
        v.addArrangedSubviews(self.myNicknameLabel,
                              self.heartImageView,
                              self.partnerNicknameLabel)
        return v
    }()
    
    /// 챌린지 정보 라벨
    lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .right
        v.text = "4번쨰 챌린지듕"
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.nicknameStackView,
                         self.challengeCountLabel)
        
        self.heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        self.nicknameStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.4)
        }
        
        self.challengeCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.6)
        }
    }
    
    private func attribute() {
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeInProgressViewModel.OrderViewModel) {
        self.challengeCountLabel.text = viewModel.challengeOrderText
        self.myNicknameLabel.text = viewModel.myNameText
        self.partnerNicknameLabel.text = viewModel.partenrNameText
    }
}
