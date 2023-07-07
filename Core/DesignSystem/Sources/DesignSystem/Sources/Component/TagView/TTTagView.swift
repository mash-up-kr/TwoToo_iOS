//
//  TTTagView.swift
//  
//
//  Created by Julia on 2023/07/05.
//

import UIKit
import Util

public final class TTTagView: UIView, UIComponentBased {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        return v
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(title: String,
                            textColor: UIColor,
                            fontSize: UIFont,
                            cornerRadius: CGFloat) {
        self.init()
        self.titleLabel.text = title
        self.titleLabel.textColor = textColor
        self.titleLabel.font = fontSize
        self.layer.cornerRadius = cornerRadius
    }
    
    public func layout() {
        self.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    public func attribute() {
        
    }
    
    func configureTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
}
