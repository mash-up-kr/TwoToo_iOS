//
//  PartnerFlowerView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

final class PartnerFlowerView: UIView {
    
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(tailPosition: .partner)
        return v
    }()
    
    lazy var finishLabel: UILabel = {
        let v = UILabel()
        v.text = "완료!"
        v.font = .body2
        v.textColor = .mainCoral
        return v
    }()
        
    lazy var heartImageView: UIImageView = {
        let v = UIImageView(.icon_heart)
        return v
    }()
    
    /// 챌린지 인증하면 나타나는 문구
    lazy var finishHeartStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 3
        v.addArrangedSubviews(self.finishLabel, self.heartImageView)
        v.isHidden = true
        return v
    }()
    
    lazy var flowerImageView: UIImageView = {
        let v = UIImageView(.icon_step3_mate)
        return v
    }()
    
    lazy var nicknameView: TTTagView = {
        let v = TTTagView(textColor: .primary,
                          fontSize: .body2,
                          cornerRadius: 15)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.speechBubbleView,
                         self.finishHeartStackView,
                         self.flowerImageView,
                         self.nicknameView)
        
        self.heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        self.speechBubbleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(9)
            make.bottom.equalTo(self.flowerImageView.snp.top).offset(-15)
        }
        
        self.finishHeartStackView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        self.flowerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.finishHeartStackView.snp.bottom).offset(8)
            make.centerX.equalToSuperview().multipliedBy(1.2)
        }
        
        self.nicknameView.snp.makeConstraints { make in
            make.top.equalTo(self.flowerImageView.snp.bottom).offset(7)
            make.height.equalTo(27)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(self.flowerImageView.snp.centerX)
        }
    }
    
    private func attribute() {
//        self.backgroundColor = .systemBlue
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeInProgressViewModel.PartnerFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.finishHeartStackView.isHidden = viewModel.isCertificationCompleteHidden
        self.speechBubbleView.isHidden = viewModel.isComplimentCommentHidden
        self.speechBubbleView.titleLabel.text = viewModel.complimentCommentText
        self.nicknameView.titleLabel.text = viewModel.partnerNameText
    }
}
