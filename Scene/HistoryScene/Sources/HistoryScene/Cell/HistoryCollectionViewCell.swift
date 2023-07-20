//
//  HistoryCollectionViewCell.swift
//  
//
//  Created by Julia on 2023/07/20.
//

import UIKit
import Util

public final class HistoryCollectionViewCell: UICollectionViewCell {
    
    lazy var countLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainPink
        v.text = "2번째 챌린지"
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .primary
        v.text = "하루~!~! 운동하긔"
        return v
    }()
    
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .grey500
        v.text = "2023/12/32 - 2023/12/32"
        return v
    }()
    
    lazy var flowerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.addArrangedSubviews(self.myFlowerImageView, self.partnerFlowerImageView)
        return v
    }()
    
    lazy var myFlowerImageView: UIImageView = {
        let v = UIImageView(.flower_small_fig)
        return v
    }()
    
    lazy var partnerFlowerImageView: UIImageView = {
        let v = UIImageView(.flower_small_rose)
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
        self.addSubviews(self.countLabel, self.titleLabel, self.dateLabel, self.flowerStackView)
        
        self.countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.countLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.flowerStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
    func attribute() {
        self.backgroundView = UIImageView(image: .asset(.history_card))
    }
    
    public func configure() {
        
    }
    
}
