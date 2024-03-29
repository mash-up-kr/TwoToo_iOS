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
        v.addArrangedSubviews(self.partnerNicknameLabel,
                              self.heartImageView,
                              self.myNicknameLabel)
        return v
    }()
    
    /// 챌린지 정보 라벨
    lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .right
        return v
    }()

    // 고정 너비 적용
    public override var intrinsicContentSize: CGSize {
        let width: CGFloat = 83
        let height: CGFloat = 40
        return .init(width: width, height: height)
    }
    
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
            make.width.height.equalTo(14)
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
    
    func configure(challengeOrderText: String?,
                   myNickname: String,
                   partnerNickname: String) {
        if challengeOrderText == nil {
            self.challengeCountLabel.isHidden = true
        }
        self.challengeCountLabel.text = challengeOrderText
        self.myNicknameLabel.text = myNickname
        self.partnerNicknameLabel.text = partnerNickname
    }
}
