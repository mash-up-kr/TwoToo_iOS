//
//  MyFlowerTopView.swift
//  
//
//  Created by Julia on 2023/09/17.
//

import UIKit
import DesignSystem

protocol MyFlowerTopViewDelegate: AnyObject {
    /// 물뿌리개 인증 버튼을 탭 했을 때
    func didTapWateringCanView()
    /// 비어있는 말풍선을 탭 했을 때
    func didTapEmptySpeechBubbleView()
}

final class MyFlowerTopView: UIView {
    
    weak var delegate: MyFlowerTopViewDelegate?
    
    // MARK: - 챌린지 진행 중
    /// 칭찬시 나타나는 말풍선
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(tailPosition: .my)
        v.isHidden = true
        return v
    }()
    /// 물뿌리개 인증 로티 뷰
    lazy var wateringCanStackView: WateringCanStackView = {
        let v = WateringCanStackView()
        v.axis = .vertical
        v.isHidden = true
        v.addTapAction { [weak self] in
            self?.delegate?.didTapWateringCanView()
        }
        return v
    }()
    /// 인증 완료 후 칭찬 문구 작성하기 말풍선 뷰
    lazy var complimentWriteBubbleImageView: UIImageView = {
        let v = UIImageView(.icon_bubble_write)
        v.isHidden = true
        v.isUserInteractionEnabled = true
        v.addTapAction { [weak self] in
            self?.delegate?.didTapEmptySpeechBubbleView()
        }
        return v
    }()
    // MARK: - 챌린지 완료
    /// 꽃말 보기 말풍선 이미지
    lazy var flowerLanguageImageView: UIImageView = {
        let v = UIImageView()
//        v.image = .asset(.)
        return v
    }()
    
    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.speechBubbleView,
                         self.wateringCanStackView,
                         self.flowerLanguageImageView,
                         self.complimentWriteBubbleImageView)
        
        self.speechBubbleView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().offset(-42)
        }
        
        self.complimentWriteBubbleImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().offset(-24)
        }
        
        self.wateringCanStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        self.flowerLanguageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel.TopViewModel) {
        self.wateringCanStackView.isHidden = viewModel.isCertificationButtonHidden
        self.wateringCanStackView.titleLabel.text = viewModel.cetificationGuideText
        
        if viewModel.isComplimentCommentHidden {
            self.speechBubbleView.isHidden = true
            self.complimentWriteBubbleImageView.isHidden = true
        }
        else {
            // 칭찬문구 O
            if !viewModel.complimentCommentText.isEmpty {
                self.speechBubbleView.configure(title: viewModel.complimentCommentText)
                self.speechBubbleView.isHidden = false
                self.complimentWriteBubbleImageView.isHidden = true
            }
            else { // 칭찬문구 X
                self.complimentWriteBubbleImageView.isHidden = false
                self.speechBubbleView.isHidden = true
            }
        }
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.MyFlowerViewModel) {
        
    }
}
