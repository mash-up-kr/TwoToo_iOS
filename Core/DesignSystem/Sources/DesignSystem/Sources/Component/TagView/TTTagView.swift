//
//  TTTagView.swift
//  
//
//  Created by Julia on 2023/07/05.
//

import UIKit
import Util

public final class TTTagView: UIView, UIComponentBased {
    
    public lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        return v
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(textColor: UIColor,
                            fontSize: UIFont,
                            cornerRadius: CGFloat) {
        self.init()
        self.titleLabel.textColor = textColor
        self.titleLabel.font = fontSize
        self.layer.cornerRadius = cornerRadius
    }
    
    public func layout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
    }
    
    public func attribute() {
        self.backgroundColor = .white
    }

    
}
