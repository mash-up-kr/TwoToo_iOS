//
//  CertificateTableViewCell.swift
//  
//
//  Created by Julia on 2023/07/24.
//

import UIKit
import Util

final class CertificateTableViewCell: UITableViewCell {

    // MARK: - my component
    let myTimeLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .white
        return v
    }()
    
    lazy var myImageView: UIImageView = {
        let v = UIImageView(image: .asset(.history_fail))
        v.layer.cornerRadius = 10
        return v
    }()
    
    // MARK: - middle component
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .center
        v.text = "7/24"
        return v
    }()
    
    lazy var dateView: UIView = {
        let v = UIView()
        v.backgroundColor = .second01
        v.layer.cornerRadius = 15
        v.addSubview(self.dateLabel)
        v.bringSubviewToFront(self.dateLabel)
        return v
    }()
    
    let lineImageView: UIImageView = {
        let v = UIImageView(image: .asset(.history_line))
        return v
    }()
    
    // MARK: - partner component
    let partnerTimeLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .white
        return v
    }()
    
    lazy var partnerImageView: UIImageView = {
        let v = UIImageView(image: .asset(.history_waiting))
        v.layer.cornerRadius = 10
        v.addSubview(self.partnerTimeLabel)
        return v
    }()

    // MARK: - method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ChallengeHistory.ViewModel.CellInfo) {
        self.dateLabel.text = viewModel.dateText
        self.myImageView.kf.setImage(with: viewModel.my.photoURL)
        self.myTimeLabel.text = viewModel.my.timeText
        self.partnerImageView.kf.setImage(with: viewModel.partner.photoURL)
        self.partnerTimeLabel.text = viewModel.partner.timeText
    }
    
    func layout() {
        self.contentView.addSubviews(self.myImageView,
                                     self.dateView,
                                     self.lineImageView,
                                     self.partnerImageView)
        
        self.contentView.bringSubviewToFront(self.dateView)
        self.myImageView.addSubview(self.myTimeLabel)
        self.partnerImageView.addSubview(self.partnerTimeLabel)
        
        self.dateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.myTimeLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
        }
        
        self.partnerTimeLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
        }
        
        self.myImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().inset(17)
            make.width.height.equalTo(127)
        }
        
        self.dateView.snp.makeConstraints { make in
            make.width.height.equalTo(45)
            make.leading.equalTo(self.partnerImageView.snp.trailing).offset(13)
            make.trailing.equalTo(self.myImageView.snp.leading).offset(-13)
            make.centerX.centerY.equalToSuperview()
        }
        
        self.lineImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalToSuperview()
        }
        
        self.partnerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().inset(17)
            make.width.height.equalTo(127)
        }
    }
        
    func attribute() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
