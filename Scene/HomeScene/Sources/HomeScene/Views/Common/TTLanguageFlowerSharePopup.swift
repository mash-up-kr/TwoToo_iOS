//
//  TTLanguageFlowerSharePopup.swift
//
//
//  Created by Eddy on 2024/01/15.
//

import CoreKit
import UIKit

protocol TTLanguageFlowerSharePopupDelegate: AnyObject {
    func didTapLanguageFlowerSharePopupDimView()
    func didTapLanguageFlowerSharePopupCloseButton()
    func didTapLanguageFlowerSharePopupShareButton(image: UIImage)
}

final class TTLanguageFlowerSharePopup: UIView {
    
    weak var delegate: TTLanguageFlowerSharePopupDelegate?
    
    private lazy var dimView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
        v.addTapAction { [weak self] in
            self?.delegate?.didTapLanguageFlowerSharePopupDimView()
        }
        return v
    }()
    
    private lazy var headlineLabel: UILabel = {
        let v = UILabel()
        v.font = .h3
        v.textColor = .white
        return v
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var captureBgView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var captureView: UIView = {
        let v = UIView()
        v.backgroundColor = .second02
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    private lazy var flowerLanguageLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    let backgroundImageView: UIImageView = {
        let v = UIImageView(image: .asset(.flowerPopup_background))
        return v
    }()
    
    let flowerOrderLabel: PaddingLabel = {
        let v = PaddingLabel(padding: .init(top: 4, left: 10, bottom: 4, right: 10))
        v.font = .body1
        v.textColor = .mainCoral
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var shareButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "공유하기", .large)
        v.setIsEnabled(true)
        v.addAction { [weak self] in
            guard let self = self else {
                return
            }
            let image = self.makeImage()
            self.delegate?.didTapLanguageFlowerSharePopupShareButton(image: image)
        }
        return v
    }()
    
    private lazy var closeButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "닫기", .large)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .clear
        v.addAction { [weak self] in
            self?.delegate?.didTapLanguageFlowerSharePopupCloseButton()
        }
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.superview != nil {
            self.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func layout() {
        self.addSubviews(self.dimView, self.headlineLabel, self.contentView, self.closeButton)
        self.contentView.addSubviews(self.captureBgView, self.shareButton)
        self.captureBgView.addSubviews(self.captureView)
        self.captureView.addSubviews(self.titleLabel, self.flowerLanguageLabel, self.imageView, self.flowerOrderLabel, self.backgroundImageView)
        self.captureView.sendSubviewToBack(self.backgroundImageView)
        
        self.dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.headlineLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(51)
            make.centerY.equalToSuperview()
        }
        
        self.closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.captureBgView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(13)
        }
        
        self.backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.captureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(self.captureView.snp.bottom).offset(7)
            make.leading.trailing.bottom.equalToSuperview().inset(11)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
        
        self.flowerLanguageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.flowerOrderLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(14)
            make.bottom.equalToSuperview().inset(13)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(image: UIImage, title: String, description: String, order: String) {
        self.headlineLabel.text = "\(title) 카드를 획득했어요!"
        self.imageView.image = image
        self.titleLabel.text = title
        self.flowerLanguageLabel.text = description
        self.flowerOrderLabel.text = order
        
        self.imageView.snp.remakeConstraints { make in
            make.top.equalTo(self.flowerLanguageLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.lessThanOrEqualTo(165)
        }
    }
    
    // MARK: - Business Logic
    
    private func makeImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.captureView.bounds)
        
        let image = renderer.image { ctx in
            self.captureView.drawHierarchy(in: self.captureView.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}

extension TTLanguageFlowerSharePopup {
    /// UILabel의 padding을 설정할 수 있는 클래스
    final class PaddingLabel: UILabel {
        private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        convenience init(padding: UIEdgeInsets) {
            self.init()
            self.padding = padding
        }
        
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: padding))
        }
        
        override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
            return contentSize
        }
    }
}
