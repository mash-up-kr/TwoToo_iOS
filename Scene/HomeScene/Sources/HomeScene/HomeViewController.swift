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
    /// 네비게이션 바
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo",
                                rightButtonImage: .asset(.icon_info))
        return v
    }()
    /// 챌린지 이름, 디데이가 담긴 뷰
    lazy var contentView: TopContentView = {
        let v = TopContentView()
        v.configure(title: "30분이상 운동하기", date: 22)
        return v
    }()
    /// 챌린지 진행도 뷰
    lazy var progressBar: TTProgressBar = {
        let v = TTProgressBar()
        v.layer.cornerRadius = 15
        v.configureNickname(my: "제갈공주", partner: "왕자")
        v.configurePercent(my: 30, partner: 70)
        return v
    }()
    /// 내 닉네임 라벨
    lazy var myNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "공쥬"
        return v
    }()
    /// 하트 이미지
    lazy var heartImageView: UIImageView = {
        let v = UIImageView(image: .asset(.icon_heart))
        return v
    }()
    /// 상대방 닉네임 라벨
    lazy var partnerNicknameLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.text = "왕쟈"
        return v
    }()
    /// 닉네임 정보 스택뷰
    lazy var nicknamesStackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 6
        v.axis = .horizontal
        v.addArrangedSubviews(self.myNicknameLabel, self.heartImageView, self.partnerNicknameLabel)
        return v
    }()
    /// 챌린지 정보 라벨
    lazy var challengeCountLabel: UILabel = {
        let v = UILabel()
        v.font = .body2
        v.textColor = .mainCoral
        v.textAlignment = .right
        v.text = "4번쨰 챌린지듕"
        return v
    }()
    /// 닉네임 정보, 챌린지 정보를 담은 스택뷰
    lazy var infoStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.alignment = .trailing
        v.spacing = 10
        v.addArrangedSubviews(self.nicknamesStackView, self.challengeCountLabel)
        return v
    }()
    /// 나와 상대방이 키우는 꽃 단계 뷰
    /// 홈 화면 업로드 될 때 주입됩니다.
    lazy var flowersStepView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    /// 꽃 아래 보여질 땅 배경 이미지 뷰
    lazy var groundImageView: UIImageView = {
        let v = UIImageView(.home_ground)
        return v
    }()
    /// 찌르기 버튼
    lazy var nudgeBeeButton: UIButton = {
        let v = UIButton()
        v.setImage(.asset(.icon_push_bee), for: .normal)
        return v
    }()
    /// 찌르기 버튼 타이틀
    lazy var nudgeTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "콕 찌르기 (5/5)"
        v.textColor = .primary
        v.font = .body2
        v.textAlignment = .center
        return v
    }()
        
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.sendGroundImageViewToBack()
    }
    
    private func sendGroundImageViewToBack() {
        self.view.sendSubviewToBack(self.groundImageView)
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.navigationBar,
                              self.contentView,
                              self.progressBar,
                              self.infoStackView,
                              self.flowersStepView,
                              self.groundImageView,
                              self.nudgeBeeButton,
                              self.nudgeTitleLabel)
        
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
        
        self.flowersStepView.snp.makeConstraints { make in
            make.top.equalTo(self.infoStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.nudgeBeeButton.snp.top).offset(-10)
        }
        
        let tabBarHeight: CGFloat = 61.0 + UIDevice.current.safeAreaBottomHeight
        self.groundImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.26)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-tabBarHeight)
        }

        let buttonSize: CGFloat = (UIScreen.main.bounds.width) * 0.15
        self.nudgeBeeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(buttonSize)
        }
        
        let nudgeBottomOffset: CGFloat = 20 + tabBarHeight
        self.nudgeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nudgeBeeButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-nudgeBottomOffset)
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
