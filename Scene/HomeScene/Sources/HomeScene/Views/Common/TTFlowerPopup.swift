//
//  TTFlowerPopup.swift
//
//
//  Created by Julia on 10/10/23.
//

import UIKit
import Util

protocol TTFlowerPopupDelegate: AnyObject {
    func didTapCloseView()
}

final class TTFlowerPopup: UIView {
    
    weak var delegate: TTFlowerPopupDelegate?
    
    lazy var dimView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.5)
        v.addTapAction { [weak self] in
            self?.delegate?.didTapCloseView()
        }
        return v
    }()
    
    let flowerNameLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h2
        v.textAlignment = .center
        return v
    }()
    
    let flowerDescLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .body2
        v.textAlignment = .center
        return v
    }()
    
    lazy var flowerImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
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
    
    lazy var closeButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_cancel), for: .normal)
        v.addAction { [weak self] in
            self?.delegate?.didTapCloseView()
        }
        return v
    }()
    
    let backgroundImageView: UIImageView = {
        let v = UIImageView(image: .asset(.flowerPopup_background))
        return v
    }()
    
    /// 컴포넌트들을 담는 뷰
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .second02
        v.addSubviews(self.flowerNameLabel,
                      self.flowerDescLabel,
                      self.flowerImageView,
                      self.flowerOrderLabel,
                      self.backgroundImageView,
                      self.closeButton)
        v.sendSubviewToBack(self.backgroundImageView)
        v.layer.cornerRadius = 20
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
    
    func configure(name flowerName: String,
                   description flowerDescription: String,
                   image: UIImage,
                   order flowerOrder: String) {
        self.flowerNameLabel.text = flowerName
        self.flowerDescLabel.text = flowerDescription
        self.flowerImageView.image = image
        self.flowerOrderLabel.text = flowerOrder
    }
    
    func layout() {
        self.addSubviews(self.dimView,
                         self.contentView)
        
        self.dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints { make in
            make.width.equalTo(273)
            make.height.equalTo(349)
            make.center.equalToSuperview()
        }
        
        self.flowerNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.centerX.equalToSuperview()
        }
        
        self.flowerDescLabel.snp.makeConstraints { make in
            make.top.equalTo(self.flowerNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        self.flowerImageView.snp.makeConstraints { make in
            make.top.equalTo(self.flowerDescLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.lessThanOrEqualTo(165)
        }
        
        self.flowerOrderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        self.backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
}

extension TTFlowerPopup {
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
