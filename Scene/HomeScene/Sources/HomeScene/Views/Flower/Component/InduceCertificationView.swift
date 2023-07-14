//
//  induceCertificationView.swift
//  
//
//  Created by Julia on 2023/07/13.
//

import UIKit

final class InduceCertificationView: UIStackView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "내 씨앗을 눌러 인증 해보세요!"
        v.font = .body1
        v.textColor = .grey500
        return v
    }()

    lazy var certificatedImageView: UIImageView = {
        let v = UIImageView(.icon_certificated)
        v.frame = .init(x: 0, y: 0, width: 75, height: 70)
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 10
        self.addArrangedSubviews(self.titleLabel,
                                 self.certificatedImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
