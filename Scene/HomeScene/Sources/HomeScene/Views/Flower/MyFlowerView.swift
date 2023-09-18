//
//  MyFlowerView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

protocol MyFlowerViewDelegate: AnyObject {
    /// 인증(물뿌리개, 꽃 이미지) 컴포넌트를 탭 했을 때
    func didTapCertificateView()
    /// 비어있는 말풍선을 탭 했을 때
    func didTapEmptySpeechBubbleView()
}

final class MyFlowerView: UIView {
    
    weak var delegate: MyFlowerViewDelegate?
    
    lazy var flowerImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .bottom
        v.addTapAction { [weak self] in
            self?.delegate?.didTapCertificateView()
        }
        return v
    }()
    
    lazy var nicknameView: TTTagView = {
        let v = TTTagView(textColor: .mainCoral,
                          fontSize: .body2,
                          cornerRadius: 13)
        return v
    }()
    
    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
//        self.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.flowerImageView,
                         self.nicknameView)
        
        self.flowerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(self.nicknameView.snp.top).offset(-7)
        }
        
        self.nicknameView.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(self.flowerImageView.snp.centerX)
        }
        
        // SE 같은 작은 화면일때만 꽃 크기의 최대 높이를 설정한다.
//        if UIDevice.current.deviceType == .default {
//            self.flowerImageView.snp.remakeConstraints { make in
//                make.height.lessThanOrEqualTo(180)
//                make.centerX.equalToSuperview().multipliedBy(1.2)
//                make.bottom.equalTo(self.nicknameView.snp.top).offset(-7)
//            }
//        }
    }
    
    private func attribute() {
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.MyFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.nicknameView.titleLabel.text = viewModel.myNameText
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.MyFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.nicknameView.titleLabel.text = viewModel.myNameText
    }
}

extension MyFlowerView: MyFlowerTopViewDelegate {
    func didTapWateringCanView() {
        self.delegate?.didTapCertificateView()
    }
    
    func didTapEmptySpeechBubbleView() {
        self.delegate?.didTapEmptySpeechBubbleView()
    }
}
