//
//  TTProgressBar.swift
//  
//
//  Created by Julia on 2023/07/09.
//

import UIKit

final class TTProgressBar: UIView {
    
    // MARK: - My UI
    private lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textAlignment = .center
        v.textColor = .primary
        return v
    }()
    
    private lazy var partnerPercentLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = .body3
        v.textColor = .grey500
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
    
    // MARK: - Partner UI
    private lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .center
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
    
    private lazy var myPercentLabel: UILabel = {
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
        
        self.addSubviews(self.partnerNicknameLabel,
                         self.partnerPercentContentView,
                         self.partnerPercentLabel,
                         self.myNicknameLabel,
                         self.myPercentContentView,
                         self.myPercentLabel)
        
        let percentContentLeadingOffset = UIDevice.current.deviceType == .default ? 9 : 14

        // --> partner
        self.partnerNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
                
        self.partnerPercentContentView.snp.makeConstraints { make in
            make.leading.equalTo(self.partnerNicknameLabel.snp.trailing).offset(percentContentLeadingOffset)
            make.trailing.equalTo(self.partnerPercentLabel.snp.leading).offset(-6)
            make.height.equalToSuperview().dividedBy(5.5)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        self.partnerPercentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview().multipliedBy(0.6)
        }
        
        // --> my
        self.myNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.3)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        self.myPercentContentView.snp.makeConstraints { make in
            make.leading.equalTo(self.myNicknameLabel.snp.trailing).offset(percentContentLeadingOffset)
            make.trailing.equalTo(self.myPercentLabel.snp.leading).offset(-6)
            make.height.equalToSuperview().dividedBy(5.5)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
        
        self.myPercentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(13)
            make.centerY.equalToSuperview().multipliedBy(1.4)
        }
    }
    
    private func attribute() {
        self.backgroundColor = .mainWhite
        self.layer.cornerRadius = 15
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.ProgressViewModel) {
        self.myNicknameLabel.text = viewModel.myNameText
        self.myPercentLabel.text = viewModel.myPercentageText
        self.partnerNicknameLabel.text = viewModel.partnerNameText
        self.partnerPercentLabel.text = viewModel.partnerPercentageText
        self.configurePercent(my: viewModel.myPercentageNumber,
                              partner: viewModel.partnerPercentageNumber)
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.ProgressViewModel) {
        self.myNicknameLabel.text = viewModel.myNameText
        self.myPercentLabel.text = viewModel.myPercentageText
        self.partnerNicknameLabel.text = viewModel.partnerNameText
        self.partnerPercentLabel.text = viewModel.partnerPercentageText
        self.configurePercent(my: viewModel.myPercentageNumber,
                              partner: viewModel.partnerPercentageNumber)
    }
    
    
    private func configurePercent(my: Double, partner: Double) {
        if my == 0 {
            self.myPercentView.snp.remakeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
            }
        }
        else {
            self.myPercentView.snp.remakeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.trailing.equalToSuperview().multipliedBy(my)
            }
        }
        
        if partner == 0 {
            self.partnerPercentView.snp.remakeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
            }
        }
        else {
            self.partnerPercentView.snp.remakeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.trailing.equalToSuperview().multipliedBy(partner)
            }
        }
    }

}
