//
//  CoupleNicknameStackView.swift
//  
//
//  Created by Julia on 2023/07/12.
//

import UIKit

final class CoupleNicknameStackView: UIStackView {
    
    lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "공쥬"
        return v
    }()
    
    lazy var heartImageView: UIImageView = {
        let v = UIImageView(image: .asset(.icon_heart))
        return v
    }()
    
    lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "왕쟈"
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(my: String, partner: String) {
        self.myNicknameLabel.text = my
        self.partnerNicknameLabel.text = partner
    }
    
    private func layout() {
        self.heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
    }
    
    private func attribute() {
        self.spacing = 6
        self.axis = .horizontal
        self.addArrangedSubviews(self.myNicknameLabel,
                                 self.heartImageView,
                                 self.partnerNicknameLabel)
    }
}
