//
//  PartnerFlowerView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import DesignSystem

final class PartnerFlowerView: UIView {

    lazy var flowerImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .bottom
        return v
    }()
    
    lazy var nicknameView: TTTagView = {
        let v = TTTagView(textColor: .primary,
                          fontSize: .body2,
                          cornerRadius: 15)
        return v
    }()
    // MARK: - Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
//        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubviews(self.flowerImageView,
                         self.nicknameView)
        
        self.flowerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.2)
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

    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.PartnerFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.nicknameView.titleLabel.text = viewModel.partnerNameText
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.PartnerFlowerViewModel) {
        self.flowerImageView.image = viewModel.image
        self.nicknameView.titleLabel.text = viewModel.partnerNameText
    }
}
