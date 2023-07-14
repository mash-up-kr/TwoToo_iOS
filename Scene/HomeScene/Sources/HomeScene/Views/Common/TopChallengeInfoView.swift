//
//  TopContentView.swift
//  
//
//  Created by Julia on 2023/07/09.
//

import UIKit
import DesignSystem

final class TopChallengeInfoView: UIView {
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .h1
        return v
    }()
    
    lazy var dateTagView: TTTagView = {
        let v = TTTagView(textColor: .grey500,
                          fontSize: .body1,
                          cornerRadius: 4)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubviews(self.titleLabel, self.dateTagView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        self.dateTagView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
    }
    
    func attribute() {
        self.backgroundColor = .second01
        self.layer.cornerRadius = 15
    }
    
    public func configure(title: String, dDay: Int) {
        self.titleLabel.text = title
        self.dateTagView.titleLabel.text = "D-\(dDay)"
    }
    
}
