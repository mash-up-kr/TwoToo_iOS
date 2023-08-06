//
//  TopContentView.swift
//  
//
//  Created by Julia on 2023/07/09.
//

import UIKit
import DesignSystem

final class TopChallengeInfoView: UIView {
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .mainCoral
        v.font = .h1
        v.numberOfLines = 2
        v.textAlignment = .center
        v.lineBreakMode = .byTruncatingTail
        return v
    }()
    
    lazy var dateTagView: TTTagView = {
        let v = TTTagView(textColor: .grey500,
                          fontSize: .body1,
                          cornerRadius: 4)
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
        self.addSubviews(self.titleLabel, self.dateTagView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.dateTagView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func attribute() {
        self.backgroundColor = .second01
        self.layer.cornerRadius = 15
    }
    
    func configureInProgress(viewModel: Home.ViewModel.ChallengeInProgressViewModel.ChallengeInfoViewModel) {
        self.titleLabel.text = viewModel.challengeNameText
        self.dateTagView.titleLabel.text = viewModel.dDayText
    }
    
    func configureCompleted(viewModel: Home.ViewModel.ChallengeCompletedViewModel.ChallengeInfoViewModel) {
        self.titleLabel.text = viewModel.challengeNameText
        self.dateTagView.titleLabel.text = "D-0"
    }
    
}
