//
//  IntroTagView.swift
//  
//
//  Created by Julia on 2023/07/03.
//

import UIKit

final class InviteTagView: UIView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textAlignment = .center
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
    
    convenience init() {
        self.init()
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func attribute() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .second01
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
    
}
