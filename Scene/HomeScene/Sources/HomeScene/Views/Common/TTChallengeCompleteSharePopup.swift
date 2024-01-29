//
//  TTChallengeCompleteSharePopup.swift
//
//
//  Created by 박건우 on 1/29/24.
//

import CoreKit
import Lottie
import UIKit

protocol TTChallengeCompleteSharePopupDelegate: AnyObject {
    func didTapChallengeCompleteSharePopupDimView()
    func didTapChallengeCompleteSharePopupCloseButton()
    func didTapChallengeCompleteSharePopupShareButton(image: UIImage)
}

final class TTChallengeCompleteSharePopup: UIView {
    
    weak var delegate: TTChallengeCompleteSharePopupDelegate?
    
    private lazy var dimView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
        v.addTapAction { [weak self] in
            self?.delegate?.didTapChallengeCompleteSharePopupDimView()
        }
        return v
    }()
    
    private lazy var celebrateLottieView: LottieAnimationView = {
        let v = LottieAnimationView(name: "celebrate_lottie", bundle: .module)
        v.loopMode = .playOnce
        v.animationSpeed = 1
        v.play()
        return v
    }()
    
    private lazy var headlineLabel: UILabel = {
        let v = UILabel()
        v.font = .h3
        v.textColor = .white
        v.text = "챌린지 완료 카드를 획득했어요!"
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
        v.numberOfLines = 2
        v.lineBreakMode = .byTruncatingTail
        return v
    }()
    
    private lazy var captionBgView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.font = .body3
        v.textColor = .mainCoral
        return v
    }()
    
    private lazy var partnerFlowerImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    private lazy var myFlowerImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    private lazy var captureBottomBgImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.popup_ground)
        return v
    }()
    
    private lazy var logoLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .mainWhite
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
            self.delegate?.didTapChallengeCompleteSharePopupShareButton(image: image)
        }
        return v
    }()
    
    private lazy var closeButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "닫기", .large)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .clear
        v.addAction { [weak self] in
            self?.delegate?.didTapChallengeCompleteSharePopupCloseButton()
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
        self.addSubviews(self.dimView, self.celebrateLottieView, self.headlineLabel, self.contentView, self.closeButton)
        self.contentView.addSubviews(self.captureBgView, self.shareButton)
        self.captureBgView.addSubviews(self.captureView)
        self.captureView.addSubviews(self.captureBottomBgImageView, self.dateLabel, self.titleLabel, self.captionBgView, self.partnerFlowerImageView, self.myFlowerImageView, self.logoLabel)
        self.captionBgView.addSubview(self.captionLabel)
        
        self.dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.celebrateLottieView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
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
            make.leading.top.trailing.equalToSuperview().inset(11)
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
            make.leading.equalToSuperview().inset(24)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        self.captionBgView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(24)
        }
        self.captionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        self.captureBottomBgImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.captureBottomBgImageView.snp.width).multipliedBy(114 / 375.0)
        }
        self.partnerFlowerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.captionBgView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(42)
            make.leading.equalTo(self.captureView.snp.centerX).offset(10)
            make.width.equalToSuperview().multipliedBy(130 / 375.0)
            make.height.equalTo(self.partnerFlowerImageView.snp.width).multipliedBy(217 / 130.0)
        }
        self.myFlowerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.captionBgView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(42)
            make.trailing.equalTo(self.captureView.snp.centerX).offset(-10)
            make.width.equalToSuperview().multipliedBy(130 / 375.0)
            make.height.equalTo(self.partnerFlowerImageView.snp.width).multipliedBy(217 / 130.0)
        }
        self.logoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(21)
        }
    }
    
    func configure(viewModel: Home.ViewModel.ChallengeCompleteSharePopupViewModel) {
        self.dateLabel.text = viewModel.dateText
        self.titleLabel.text = viewModel.titleNameText
        self.captionLabel.text = viewModel.orderText
        self.partnerFlowerImageView.image = viewModel.partnerFlowerImage
        self.myFlowerImageView.image = viewModel.myFlowerImage
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
