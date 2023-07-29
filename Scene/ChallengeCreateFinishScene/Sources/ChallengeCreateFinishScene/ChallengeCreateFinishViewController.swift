//
//  ChallengeCreateFinishViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeCreateFinishDisplayLogic: AnyObject {}

final class ChallengeCreateFinishViewController: UIViewController {
    var interactor: ChallengeCreateFinishBusinessLogic
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지 요청을 보냈습니다"
        v.textColor = .primary
        v.font = .h1
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "짝꿍이 수락하면, 챌린지가 시작됩니다"
        v.textColor = .grey600
        v.font = .body2
        return v
    }()

    private lazy var mainImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_airplane)
        return v
    }()

    private lazy var backgroundImage: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.home_ground)
        return v
    }()

    private lazy var confirmButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "확인", .large)
        v.setTitle("확인", for: .normal)
        v.setIsEnabled(true)
        v.didTapButton { [weak self] in
            Task {
                await self?.interactor.didTapConfimrButton()
            }
        }
        return v
    }()
    
    init(interactor: ChallengeCreateFinishBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02
        self.view.addSubviews(self.titleLabel, self.captionLabel, self.mainImageView, self.backgroundImage, self.confirmButton)

        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.captionLabel.snp.top).offset(-20)
        }

        self.captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.mainImageView.snp.top).offset(-55)
        }

        self.mainImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.backgroundImage.snp.top).offset(-24)
            make.leading.trailing.equalToSuperview().inset(74)
            make.width.equalTo(self.mainImageView.snp.height)
        }

        self.backgroundImage.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.26)
        }

        self.confirmButton.snp.makeConstraints { make in
            make.leading.equalTo(self.backgroundImage.snp.leading).offset(24)
            make.trailing.equalTo(self.backgroundImage.snp.trailing).offset(-24)
            make.bottom.equalTo(self.backgroundImage.snp.bottom).offset(-54)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension ChallengeCreateFinishViewController: ChallengeCreateFinishScene {
    
}

// MARK: - Display Logic

extension ChallengeCreateFinishViewController: ChallengeCreateFinishDisplayLogic {
    
}
