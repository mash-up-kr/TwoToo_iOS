//
//  ChallengeConfirmViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeConfirmDisplayLogic: AnyObject {}

final class ChallengeConfirmViewController: UIViewController {
    var interactor: ChallengeConfirmBusinessLogic

    // MARK: - UI

    private lazy var headerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()

    private lazy var processLabel: UILabel = {
        let v = UILabel()
        v.text = "3/3"
        v.textColor = .primary
        v.font = .h1
        return v
    }()

    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지 정보를 확인해주세요"
        v.font = .h1
        v.textColor = .primary
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "생성한 챌린지는 수정이 어려우니 한번 더 확인해주세요"
        v.textColor = .grey600
        v.font = .body2
        return v
    }()

    private lazy var challengeConfirmView: UIView = {
        let v = UIView()
        v.backgroundColor = .mainWhite
        return v
    }()

    private lazy var challenageTitleStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 12
        return v
    }()

    private lazy var challengeTitleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h3
        v.text = "하루 운동 30분 이상 하기"
        return v
    }()

    private lazy var challengeDateLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h4
        v.text = "23/05/01 ~ 23/05/22"
        return v
    }()

    private lazy var challengeRuleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey600
        v.font = .body2
        v.numberOfLines = 0
        v.text = "운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기"
        v.font = .systemFont(ofSize: 15)
        return v
    }()

    private lazy var challengeTitleView: UIView = {
        let v = UIView()
        v.backgroundColor = .second01
        return v
    }()

    private lazy var challengeAppLabel: UILabel = {
        let v = UILabel()
        v.text = "Twotoo challenge"
        v.font = .body1
        v.textColor = .primary
        return v
    }()

    private lazy var challengeImage: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_seed)
        return v
    }()

    private lazy var nextButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "다음", .large)
        return v
    }()

    init(interactor: ChallengeConfirmBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
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

        self.headerStackView.addArrangedSubviews(self.processLabel, self.headerLabel, self.captionLabel)
        self.challenageTitleStackView.addArrangedSubviews(self.challengeTitleLabel, self.challengeDateLabel)
        self.challengeConfirmView.addSubviews(self.challenageTitleStackView, self.challengeRuleLabel)
        self.challengeTitleView.addSubviews(self.challengeAppLabel, self.challengeImage)
        self.view.addSubviews(self.headerStackView, self.challengeConfirmView, self.challengeTitleView, self.nextButton)

        self.headerStackView.setCustomSpacing(8, after: self.processLabel)
        self.headerStackView.setCustomSpacing(12, after: self.headerLabel)

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-35)
            make.bottom.equalTo(self.challengeConfirmView.snp.top).offset(-41)
        }

        self.challengeConfirmView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(66)
            make.trailing.equalToSuperview().offset(-66)
            make.bottom.equalTo(self.challengeTitleView.snp.top)
        }

        self.challenageTitleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.bottom.equalTo(self.challengeRuleLabel.snp.top).offset(-20)
        }

        self.challengeRuleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.challenageTitleStackView.snp.leading)
            make.trailing.equalTo(self.challenageTitleStackView.snp.trailing)
            make.bottom.equalToSuperview().offset(-20)
        }

        self.challengeTitleView.snp.makeConstraints { make in
            make.leading.equalTo(self.challengeConfirmView.snp.leading)
            make.trailing.equalTo(self.challengeConfirmView.snp.trailing)
            make.bottom.lessThanOrEqualTo(self.nextButton.snp.top).offset(-100)
        }

        self.challengeAppLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(36)
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }

        self.challengeImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-39)
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-21)
            make.width.equalTo(self.challengeImage.snp.height)
        }

        self.nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-54)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension ChallengeConfirmViewController: ChallengeConfirmScene {
    
}

// MARK: - Display Logic

extension ChallengeConfirmViewController: ChallengeConfirmDisplayLogic {
    
}
