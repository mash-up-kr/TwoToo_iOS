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
    
    lazy var customContentView: ChallengeCompletedView = {
        let v = ChallengeCompletedView()
        v.configure(viewModel: .init(challengeInfo: .init(challengeNameText: "30분 운동하기"),
                                     progress: .init(partnerNameText: "공쥬",
                                                     myNameText: "왕쟈ㅑ",
                                                     partnerPercentageText: "33%",
                                                     myPercentageText: "44%",
                                                     partnerPercentageNumber: 33,
                                                     myPercentageNumber: 44),
                                     order: .init(challengeOrderText: "3번째 챌린지 중",
                                                  partenrNameText: "공쥬",
                                                  myNameText: "왕쟈"),
                                     partnerFlower: .init(image: .asset(.icon_step3_mate)!,
                                                          isFlowerTextHidden: false,
                                                          flowerNameText: "장미",
                                                          flowerDescText: "장미꽃설명",
                                                          partnerNameText: "공쥬"),
                                     myFlower: .init(image: .asset(.icon_step3_my)!,
                                                     isFlowerTextHidden: false,
                                                     flowerNameText: "벚꽃",
                                                     flowerDescText: "벚꽃설명임",
                                                     myNameText: "왕쟈")))
        return v
    }()
    
    lazy var groundImageView: UIImageView = {
        let v = UIImageView(.home_ground)
        return v
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.view.backgroundColor = .second02
        self.view.sendSubviewToBack(self.groundImageView)
    }

    // MARK: - Layout
    private func setUI() {
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubviews(self.navigationBar,
                              self.customContentView,
                              self.groundImageView)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let tabBarHeight: CGFloat = UIDevice.current.safeAreaBottomHeight + 61
        self.customContentView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarHeight)
        }
        
        self.groundImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3.5)
            make.bottom.equalToSuperview().inset(tabBarHeight)
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
