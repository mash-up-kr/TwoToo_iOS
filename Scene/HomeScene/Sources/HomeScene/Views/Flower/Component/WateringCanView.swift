//
//  WateringCanStackView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit
import Lottie

/// 물뿌리개 로티 말풍선 뷰
final class WateringCanView: UIView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .grey500
        v.textAlignment = .center
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
    
    /// 물뿌리개 로티와 말풍선 꼬리 담은 뷰
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
        self.addSubviews(self.titleLabel,
                                 self.wateringCanView)
        
        var wateringCanViewWidth = 75
        var wateringCanViewHeight = 55
        var wateringCanViewTopOffset = 10
        
        if UIDevice.current.deviceType == .default {
            wateringCanViewWidth = 65
            wateringCanViewHeight = 45
            wateringCanViewTopOffset = 5
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.wateringCanView.snp.top).offset(-wateringCanViewTopOffset)
        }
        
        self.certificatedLottieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.wateringCanView.snp.makeConstraints { make in
            make.width.equalTo(wateringCanViewWidth)
            make.height.equalTo(wateringCanViewHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.wateringCanUnderArrowView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.bottom.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
  
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
