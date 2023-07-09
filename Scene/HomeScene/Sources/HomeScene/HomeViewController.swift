//
//  HomeViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol HomeDisplayLogic: AnyObject {}

final class HomeViewController: UIViewController {
    var interactor: HomeBusinessLogic
    
    init(interactor: HomeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo",
                                rightButtonImage: .asset(.icon_info))
        return v
    }()
    
    lazy var contentView: TopContentView = {
        let v = TopContentView()
        v.configure(title: "30분이상 운동하기", date: 22)
        return v
    }()
    
    lazy var progressBar: TTProgressBar = {
        let v = TTProgressBar()
        v.layer.cornerRadius = 15
        v.configureNickname(my: "ㅈㄱ공주", partner: "왕자")
        v.configurePercent(my: 30, partner: 70)
        return v
    }()
    
    lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "공쥬"
        return v
    }()
    
    lazy var heartImageView: UIImageView = {
        let v = UIImageView(image: .asset(.icon_heart))
        return v
    }()
    
    lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "왕쟈"
        return v
    }()
    
    lazy var nicknamesStackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 6
        v.axis = .horizontal
        v.addArrangedSubviews(self.myNicknameLabel, self.heartImageView, self.partnerNicknameLabel)
        return v
    }()
    
    lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .right
        v.text = "4번쨰 챌린지듕"
        return v
    }()
    
    lazy var infoStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .trailing
        v.spacing = 10
        v.addArrangedSubviews(self.nicknamesStackView, self.challengeCountLabel)
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar,
                              self.contentView,
                              self.progressBar,
                              self.infoStackView)
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.contentView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.113)
        }
        
        self.progressBar.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(24)
            make.width.equalToSuperview().multipliedBy(0.55)
            make.height.equalTo(62)
        }
        
        self.heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
        }
        
        self.infoStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.progressBar.snp.centerY)
            make.trailing.equalToSuperview().inset(24)
        }

    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension HomeViewController: HomeScene {
    
}

// MARK: - Display Logic

extension HomeViewController: HomeDisplayLogic {
    
}
