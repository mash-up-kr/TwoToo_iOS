//
//  Loading.swift
//  
//
//  Created by Eddy on 2023/08/01.
//

import UIKit
import Lottie

public final class Loading {
    
    private let loadingView = LoadingView(frame: .zero)
    
    public static let shared = Loading()
    
    private init() {}
    
    /// 사용 예시:
    /// ```swift
    /// Loading.shared.showLoadingView()
    /// ```
    public func showLoadingView() {
        
        guard let window = UIWindow.key else {
            return
        }
        
        self.loadingView.alpha = 0
        UIView.animate(withDuration: 1, delay: 1) { [weak self] in
            guard let self = self else {
                return
            }
            window.addSubview(self.loadingView)
            window.bringSubviewToFront(self.loadingView)
            
            let height = window.frame.height
            let width = window.frame.width
            
            self.loadingView.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
            
            self.loadingView.startLoading()
            
            self.loadingView.alpha = 1
        }
    }
    
    /// 사용 예시:
    /// ```swift
    /// Loading.shared.stopLoadingView()
    /// ```
    public func stopLoadingView() {
        self.loadingView.stopLoading()
    }
}

/// indicatorView
public final class LoadingView: UIView {
            
    private let indicatorImageView: LottieAnimationView = {
        let v = LottieAnimationView(name: "flower lottie", bundle: .module)
        v.loopMode = .loop
        v.animationSpeed = 0.5
        return v
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.isHidden = true
        self.addSubview(self.indicatorImageView)
    }
    
    private func layout() {
        self.indicatorImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(144)
            make.width.equalTo(128)
        }
    }
    
    /// indicator 시작
    public func startLoading() {
        self.indicatorImageView.play()
        self.isHidden = false
    }
    
    /// indicator 끝
    public func stopLoading() {
        self.indicatorImageView.stop()
        self.isHidden = true
    }
}
