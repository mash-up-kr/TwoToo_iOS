//
//  MyInfoTableViewCell.swift
//  
//
//  Created by Eddy on 2023/07/28.
//

import UIKit
import CoreKit

final class MyInfoTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h4
        v.textColor = .primary
        v.text = "공지사항"
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        self.titleLabel.text = text
    }
    
    private func setLayout() {
        self.contentView.setBackgroundDefault()
        
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}
