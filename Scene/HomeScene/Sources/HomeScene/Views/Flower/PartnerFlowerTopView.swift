//
//  File.swift
//  
//
//  Created by Julia on 2023/09/17.
//

import UIKit
import DesignSystem

final class PartnerFlowerTopView: UIView {
    // MARK: - 챌린지 진행 중 : 꽃 이미지 위에 배치한 컴포넌트
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(tailPosition: .partner)
        v.isHidden = true
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
    /// 챌린지 인증 후 나타나는 "완료! ❤️" 스택뷰
    lazy var certificatedStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.alignment = .center
        v.spacing = 3
        v.addArrangedSubviews(self.finishLabel, self.heartImageView)
        v.isHidden = true
        return v
    }()
    /// 인증 완료 후 칭찬 문구 없을 때 이미지 뷰
    lazy var emptySpeechBubbleImageView: UIImageView = {
        let v = UIImageView(.icon_bubble_not_mate)
        v.isHidden = true
        return v
    }()
    // MARK: - 챌린지 완료 : 꽃 이미지 위에 배치한 컴포넌트
    /// 꽃말 보기 말풍선 이미지
    lazy var showFlowerTextImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_bubble_flowerLanguage)
        v.isHidden = true
        return v
    }()
    
    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
//        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.speechBubbleView,
                         self.certificatedStackView,
                         self.showFlowerTextImageView,
                         self.emptySpeechBubbleImageView)
        
        self.heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        self.speechBubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        self.showFlowerTextImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.2)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        self.certificatedStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.emptySpeechBubbleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.PartnerFlowerViewModel.TopViewModel) {
        self.certificatedStackView.isHidden = viewModel.isCertificationCompleteHidden
        if viewModel.isComplimentCommentHidden {
            self.speechBubbleView.isHidden = true
            self.emptySpeechBubbleImageView.isHidden = true
        }
        else {
            // 칭찬문구 O
            if !viewModel.complimentCommentText.isEmpty {
                self.speechBubbleView.configure(title: viewModel.complimentCommentText)
                self.speechBubbleView.isHidden = false
                self.emptySpeechBubbleImageView.isHidden = true
            }
            else { // 칭찬문구 X
                self.emptySpeechBubbleImageView.isHidden = false
                self.speechBubbleView.isHidden = true
            }
        }
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.PartnerFlowerViewModel) {
        // 꽃말 보기 말풍선 히든 여부
        self.showFlowerTextImageView.isHidden = viewModel.isFlowerTextHidden
        // TODO: 챌린지 실패 시에 말풍선도 매핑 필요
    }
}
