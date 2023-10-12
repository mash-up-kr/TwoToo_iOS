//
//  HistoryCollectionViewCell.swift
//  
//
//  Created by Julia on 2023/07/20.
//

import UIKit
import Util

public final class HistoryCollectionViewCell: UICollectionViewCell {
    
    private lazy var orderLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainPink
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .primary
        return v
    }()
    
    private lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .grey500
        return v
    }()
    
    private lazy var myFlowerImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private lazy var partnerFlowerImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private lazy var flowerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        v.addArrangedSubviews(self.myFlowerImageView, self.partnerFlowerImageView)
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
        self.addSubviews(self.orderLabel,
                         self.titleLabel,
                         self.dateLabel,
                         self.flowerStackView)
        
        self.orderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.orderLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7)
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
    
    func configure(viewModel: History.ViewModel.CellInfo) {
        self.titleLabel.text = viewModel.nameText
        self.dateLabel.text = viewModel.dateText
        self.myFlowerImageView.image = viewModel.myFlowerImage
        self.partnerFlowerImageView.image = viewModel.partnerFlowerImage
        
        if viewModel.isFinished {
            self.partnerFlowerImageView.isHidden = false
            self.orderLabel.text = "\(viewModel.order)번째 챌린지"
            self.orderLabel.textColor = .mainCoral
        }
        else {
            self.partnerFlowerImageView.isHidden = true
            self.orderLabel.text = "\(viewModel.order)번째 챌린지 중"
            self.myFlowerImageView.image = .asset(.icon_challenge_progress)
            self.orderLabel.textColor = .mainPink
        }
    }
}
