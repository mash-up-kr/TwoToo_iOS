//
//  TTCertificationSharePopup.swift
//  
//
//  Created by 박건우 on 2024/01/14.
//

import CoreKit
import UIKit

protocol TTCertificationSharePopupDelegate: AnyObject {
    func didTapCertificationSharePopupDimView()
    func didTapCertificationSharePopupCloseButton()
    func didTapCertificationSharePopupShareButton(image: UIImage)
}

final class TTCertificationSharePopup: UIView {
    
    weak var delegate: TTCertificationSharePopupDelegate?
    
    private lazy var dimView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
        v.addTapAction { [weak self] in
            self?.delegate?.didTapCertificationSharePopupDimView()
        }
        return v
    }()
    
    private lazy var headlineLabel: UILabel = {
        let v = UILabel()
        v.font = .h3
        v.textColor = .white
        v.text = "카드를 공유해보세요"
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
        v.backgroundColor = .second01
        return v
    }()
    
    private lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .black
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h3
        v.textColor = .primary
        v.lineBreakMode = .byTruncatingTail
        return v
    }()
    
    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.font = .body3
        v.textColor = .mainCoral
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 13
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var logoLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .mainCoral
        v.text = "Twotoo"
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
            self.delegate?.didTapCertificationSharePopupShareButton(image: image)
        }
        return v
    }()
    
    private lazy var closeButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "닫기", .large)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .clear
        v.addAction { [weak self] in
            self?.delegate?.didTapCertificationSharePopupCloseButton()
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
        self.captureView.addSubviews(self.dateLabel, self.titleLabel, self.captionLabel, self.imageView, self.logoLabel)
        
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
        self.captureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.shareButton.snp.makeConstraints { make in
            make.top.equalTo(self.captureView.snp.bottom).offset(7)
            make.leading.trailing.bottom.equalToSuperview().inset(11)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.equalToSuperview().inset(17)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        self.captionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        self.logoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(14)
            make.bottom.equalToSuperview().inset(13)
            make.leading.trailing.equalToSuperview().inset(17)
        }
    }
    
    func configure(image: UIImage, viewModel: Home.ViewModel.CertificationSharePopupViewModel) {
        self.imageView.image = image
        self.dateLabel.text = viewModel.dateText
        self.titleLabel.text = viewModel.titleNameText
        self.captionLabel.text = viewModel.progressText
        
        self.imageView.snp.remakeConstraints { make in
            make.top.equalTo(self.captionLabel.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(17)
            make.height.equalTo(self.imageView.snp.width).dividedBy(image.size.width / image.size.height)
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
