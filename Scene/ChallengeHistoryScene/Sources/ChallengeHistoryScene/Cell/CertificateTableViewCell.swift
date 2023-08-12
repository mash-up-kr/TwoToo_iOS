//
//  CertificateTableViewCell.swift
//  
//
//  Created by Julia on 2023/07/24.
//

import UIKit
import Util

protocol CertificateTableViewCellDelegate: AnyObject {
    func didTapUserCell(id: String, willCertificate: Bool)
    func didTapPartnerCell(id: String)
}

final class CertificateTableViewCell: UITableViewCell {
    
    /// 내 챌린지 인증 ID
    var myCertificateID: String = ""
    /// 파트너 챌린지 인증 ID
    var partnerCertificateID: String = ""
    
    /// 유저가 인증해야 될 상태인 경우
    /// - 오늘 O
    /// - 유저 인증 X
    var willCertificate: Bool = false
    
    weak var delegate: CertificateTableViewCellDelegate?

    // MARK: - my component
    let myTimeLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .white
        return v
    }()
        
    lazy var myImageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.addTapAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapUserCell(id: self.myCertificateID,
                                          willCertificate: self.willCertificate)
        }
        v.isUserInteractionEnabled = true
        return v
    }()
    
    // MARK: - middle component
    lazy var dateLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .center
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
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.addTapAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapPartnerCell(id: self.partnerCertificateID)
        }
        v.isUserInteractionEnabled = true
        return v
    }()

    // MARK: - method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.attribute()
        self.applyDimming()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.myImageView.image = nil
        self.partnerImageView.image = nil
        self.myCertificateID = ""
        self.partnerCertificateID = ""
        self.willCertificate = false
    }
    
    func configure(viewModel: ChallengeHistory.ViewModel.CellInfo) {
        self.dateLabel.text = viewModel.dateText
        // 유저 인증 O
        if let myInfo = viewModel.my {
            self.myImageView.kf.setImage(with: myInfo.photoURL)
            self.myTimeLabel.text = myInfo.timeText
            self.myCertificateID = myInfo.certificateID
        } else  { // 유저 인증 X, 오늘인지 판단
            self.myImageView.image = viewModel.isToday ? .asset(.history_certificate) : .asset(.history_fail)
        }
        // 파트너 인증 O
        if let partnerInfo = viewModel.partner {
            self.partnerImageView.kf.setImage(with: partnerInfo.photoURL)
            self.partnerTimeLabel.text = partnerInfo.timeText
            self.partnerCertificateID = partnerInfo.certificateID
        } else { // 파트너 인증 X, 오늘인지 판단
            self.partnerImageView.image = viewModel.isToday ? .asset(.history_waiting) : .asset(.history_fail)
        }
        // 유저 이미지 인증하기 상태
        if viewModel.isToday && self.myCertificateID.isEmpty {
            self.willCertificate = true
        }
        else {
            self.willCertificate = false
        }
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

    func applyDimming() {
        [self.myImageView, self.partnerImageView].forEach { image in
            let dimLayer = CALayer()
            dimLayer.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
            dimLayer.frame = .init(x: 0, y: 0, width: 127, height: 127)
            image.layer.addSublayer(dimLayer)
        }
    }
}
