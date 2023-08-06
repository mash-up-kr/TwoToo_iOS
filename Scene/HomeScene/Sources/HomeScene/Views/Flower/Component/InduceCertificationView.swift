//
//  induceCertificationView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import Lottie

final class InduceCertificationView: UIView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .grey500
        return v
    }()
    
    lazy var certificatedLottieView: LottieAnimationView = {
        let v = LottieAnimationView(name: "watering_lottie", bundle: .module)
        v.loopMode = .loop
        v.animationSpeed = 0.5
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    private func layout() {
        self.addSubviews(self.titleLabel,
                         self.certificatedLottieView)
        
        self.certificatedLottieView.play()
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(16)
        }
        
        self.certificatedLottieView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.width.equalTo(75)
            make.height.equalTo(70)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
