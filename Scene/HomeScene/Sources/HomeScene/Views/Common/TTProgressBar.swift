//
//  TTProgressBar.swift
//  
//
//  Created by Julia on 2023/07/09.
//

import UIKit

final class TTProgressBar: UIView {
    
    // MARK: - My UI
    private lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textAlignment = .center
        v.textColor = .primary
        return v
    }()
    
    private lazy var myPercentLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = .body3
        v.textColor = .grey500
        return v
    }()
    
    private lazy var myPercentView: UIView = {
        let v = UIView()
        v.backgroundColor = .mainPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    private lazy var myPercentContentView: UIView = {
        let v = UIView()
        v.addSubview(self.myPercentView)
        v.backgroundColor = .mainLightPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    // MARK: - Partner UI
    private lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .center
        return v
    }()
        
    private lazy var partnerPercentView: UIView = {
        let v = UIView()
        v.backgroundColor = .mainPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    private lazy var partnerPercentContentView: UIView = {
        let v = UIView()
        v.addSubview(self.partnerPercentView)
        v.backgroundColor = .mainLightPink
        v.layer.cornerRadius = 5
        return v
    }()
    
    private lazy var partnerPercentLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = .body3
        v.textColor = .grey500
        return v
    }()

    // MARK: - method
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layout()
        self.attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        self.addSubviews(self.myNicknameLabel,
                         self.myPercentContentView,
                         self.myPercentLabel,
                         self.partnerNicknameLabel,
                         self.partnerPercentContentView,
                         self.partnerPercentLabel)
        // --> my
        self.myNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        self.myPercentContentView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.trailing.equalTo(self.myPercentLabel.snp.leading).offset(-13)
            make.height.equalToSuperview().dividedBy(5.5)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        self.myPercentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        // --> partner
        self.partnerNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        self.partnerPercentContentView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.trailing.equalTo(self.partnerPercentLabel.snp.leading).offset(-13)
            make.height.equalToSuperview().dividedBy(5.5)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        self.partnerPercentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
    }
    
    private func attribute() {
        self.backgroundColor = .mainWhite
    }
    
    func configureNickname(my: String, partner: String) {
        self.myNicknameLabel.text = my
        self.partnerNicknameLabel.text = partner
    }
    
    func configurePercent(my: Int, partner: Int) {
        self.myPercentLabel.text = "\(my)%"
        self.partnerPercentLabel.text = "\(partner)%"
        
        let myPercent = CGFloat(my) / CGFloat(100)
        let partnerPercent = CGFloat(partner) / CGFloat(100)

        self.myPercentView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(myPercent)
        }

        self.partnerPercentView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(partnerPercent)
        }
    }

}
