//
//  MyFlowerView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

final class MyFlowerView: UIView {
    // MARK: - 챌린지 진행 중 : 꽃 이미지 위에 배치한 컴포넌트
    /// 칭찬시 나타나는 말풍선
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(tailPosition: .my)
        v.isHidden = true
        return v
    }()
    /// 꽃 상위에 보여질 인증 유도 스택 뷰
    lazy var induceCertificationView: InduceCertificationView = {
        let v = InduceCertificationView()
        v.isHidden = true
        return v
    }()
    /// 인증 완료 후 칭찬 문구 없을 때 이미지 뷰
    lazy var emptySpeechBubbleImageView: UIImageView = {
        let v = UIImageView(.icon_bubble_write)
        v.isHidden = true
        return v
    }()
    // MARK: - 챌린지 완료 : 꽃 이미지 위에 배치한 컴포넌트
    /// 꽃 이름 라벨
    lazy var flowerNameLabel: UILabel = {
        let v = UILabel()
        v.font = .h3
        v.textColor = .primary
        return v
    }()
    /// 꽃말 라벨
    lazy var flowerDescLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .primary
        return v
    }()
    /// 챌린지 완료뷰 - 꽃 이름, 꽃말 스택뷰
    lazy var flowerInfoStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 7
        v.isHidden = true
        v.alignment = .center
        v.addArrangedSubviews(self.flowerNameLabel, self.flowerDescLabel)
        return v
    }()
    // MARK: - 공통 컴포넌트
    lazy var flowerImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    lazy var nicknameView: TTTagView = {
        let v = TTTagView(textColor: .mainCoral,
                          fontSize: .body2,
                          cornerRadius: 15)
        return v
    }()
    // MARK: - Method
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
                         self.induceCertificationView,
                         self.flowerInfoStackView,
                         self.emptySpeechBubbleImageView,
                         self.flowerImageView,
                         self.nicknameView)
        
        self.speechBubbleView.snp.makeConstraints { make in
            make.centerX.equalTo(self.flowerImageView.snp.centerX)
            make.bottom.equalTo(self.flowerImageView.snp.top).offset(-42)
        }
        
        self.emptySpeechBubbleImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.flowerImageView.snp.centerX)
            make.bottom.equalTo(self.flowerImageView.snp.top).offset(-32)
        }
        
        self.induceCertificationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(self.flowerImageView.snp.top).offset(-8)
        }
        
        self.flowerInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(self.flowerImageView.snp.top).offset(-12)
        }
        
        self.flowerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.8)
        }
        
        self.nicknameView.snp.makeConstraints { make in
            make.top.equalTo(self.flowerImageView.snp.bottom).offset(7)
            make.height.equalTo(27)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(self.flowerImageView.snp.centerX)
        }
    }
    
    private func attribute() {
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.induceCertificationView.isHidden = viewModel.isCertificationButtonHidden
        self.induceCertificationView.titleLabel.text = viewModel.cetificationGuideText
        self.nicknameView.titleLabel.text = viewModel.myNameText
        
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
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.MyFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.flowerInfoStackView.isHidden = viewModel.isFlowerTextHidden
        self.flowerNameLabel.text = viewModel.flowerNameText
        self.flowerDescLabel.text = viewModel.flowerDescText
        self.nicknameView.titleLabel.text = viewModel.myNameText
    }
}
