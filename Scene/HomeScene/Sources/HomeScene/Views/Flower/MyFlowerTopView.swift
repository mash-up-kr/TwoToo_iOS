//
//  MyFlowerTopView.swift
//  
//
//  Created by Julia on 2023/09/17.
//

import UIKit
import DesignSystem

protocol MyFlowerTopViewDelegate: AnyObject {
    /// 물뿌리개를 탭 했을 때 - 인증
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
    lazy var wateringCanView: WateringCanView = {
        let v = WateringCanView()
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.speechBubbleView,
                         self.wateringCanView,
                         self.showFlowerTextImageView,
                         self.complimentWriteBubbleImageView)
        
        let speechBubbleBottom = UIDevice.current.deviceType == .default ? 20 : 32

        self.speechBubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-speechBubbleBottom)
        }
        
        self.complimentWriteBubbleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.greaterThanOrEqualToSuperview().offset(-speechBubbleBottom)
        }
        
        self.wateringCanView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(12)
        }
        
        self.showFlowerTextImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel.TopViewModel) {
        self.wateringCanView.isHidden = viewModel.isCertificationButtonHidden
        self.wateringCanView.titleLabel.text = viewModel.cetificationGuideText
        
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
        // 꽃말 보기 말풍선 히든 여부
        self.showFlowerTextImageView.isHidden = viewModel.isFlowerTextHidden
        // TODO: 챌린지 실패 시에 말풍선도 매핑 필요
    }
}
