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
        v.font = .body1
        v.textColor = .grey500
        return v
    }()

    lazy var certificatedImageView: UIImageView = {
        let v = UIImageView(.icon_certificated)
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 10
        self.alignment = .center
        self.addArrangedSubviews(self.titleLabel,
                                 self.certificatedImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
