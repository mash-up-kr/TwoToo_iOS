//
//  MyFlowerView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

final class MyFlowerView: UIView {

    /// 칭찬시 나타나는 말풍선
    lazy var speechBubbleView: SpeechBubbleView = {
        let v = SpeechBubbleView(title: "공쥬의 말풍선입니다ㅏㅏㅏㅏ",
                                 tailPosition: .left)
        v.isHidden = true
        return v
    }()
    
    /// 꽃 상위에 보여질 인증 유도 스택 뷰
    lazy var induceCertificationView: InduceCertificationView = {
        let v = InduceCertificationView()
        v.isHidden = true
        return v
    }()
    
    lazy var flowerImageView: UIImageView = {
        let v = UIImageView(.icon_step3_my)
        return v
    }()
        
    lazy var nicknameView: TTTagView = {
        let v = TTTagView(textColor: .mainCoral,
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
                         self.induceCertificationView,
                         self.flowerImageView,
                         self.nicknameView)
        
        self.speechBubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        self.induceCertificationView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        self.flowerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.induceCertificationView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        self.nicknameView.snp.makeConstraints { make in
            make.top.equalTo(self.flowerImageView.snp.bottom).offset(7)
            make.height.equalTo(27)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    private func attribute() {
        self.backgroundColor = .orange
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.induceCertificationView.titleLabel.isHidden = viewModel.isCertificationButtonHidden
        self.induceCertificationView.titleLabel.text = viewModel.cetificationGuideText
        self.speechBubbleView.isHidden = viewModel.isComplimentCommentHidden
        self.speechBubbleView.titleLabel.text = viewModel.complimentCommentText
        self.nicknameView.titleLabel.text = viewModel.myNameText
    }
}
