//
//  induceCertificationView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import Lottie

final class InduceCertificationStackView: UIStackView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .grey500
        v.textAlignment = .center
        v.isHidden = true //temp
        return v
    }()
    
    lazy var certificatedLottieView: LottieAnimationView = {
        let v = LottieAnimationView(name: "watering_lottie", bundle: .module)
        v.loopMode = .loop
        v.animationSpeed = 0.5
        return v
    }()
    
    let wateringCanUnderArrowView: UIImageView = {
        let v = UIImageView(image: UIImage(named: "lottie_arrow",
                                           in: .module,
                                           with: nil))
        return v
    }()
    
    lazy var wateringCanView: UIView = {
        let v = UIView()
        v.backgroundColor = .second01
        v.layer.cornerRadius = 8
        v.addSubviews(self.certificatedLottieView,
                      self.wateringCanUnderArrowView)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.certificatedLottieView.play()
    }
 
    private func layout() {
        self.addArrangedSubviews(self.titleLabel,
                                 self.wateringCanView)
        
        self.certificatedLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.wateringCanView.snp.makeConstraints { make in
            make.width.equalTo(75)
            make.height.equalTo(55)
        }
        
        self.wateringCanUnderArrowView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
  
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
