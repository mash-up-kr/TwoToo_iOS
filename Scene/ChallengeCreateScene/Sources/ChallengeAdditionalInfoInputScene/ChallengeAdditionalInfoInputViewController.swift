//
//  ChallengeAdditionalInfoInputViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeAdditionalInfoInputDisplayLogic: AnyObject {}

final class ChallengeAdditionalInfoInputViewController: UIViewController {
    var interactor: ChallengeAdditionalInfoInputBusinessLogic

    // MARK: - UI

    private lazy var navigationbar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar(title: "", leftButtonImage: .asset(.icon_back), rightButtonImage: nil)
        v.delegate = self
        v.delegate?.didTapDetailLeftButton()
        return v
    }()

    private lazy var headerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()

    private lazy var processLabel: UILabel = {
        let v = UILabel()
        v.text = "2/3"
        v.font = .preferredFont(forTextStyle: .title2)
        v.textColor = .primary
        v.font = .h1
        return v
    }()

    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지 정보를 추가해보세요"
        v.font = .preferredFont(forTextStyle: .title2)
        v.font = .h1
        v.textColor = .primary
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "(선택) 목표를 달성하기위한 둘만의 룰을 작성해보세요"
        v.font = .preferredFont(forTextStyle: .body)
        v.textColor = .grey600
        v.font = .body2
        return v
    }()

    private lazy var challengeRuleTextView: TTTextView = {
        let v = TTTextView(placeHolder: "구체적인 챌린지 룰, 벌칙 등을 입력해주세요", maxCount: 200)
        v.contentInset = .init(top: 21, left: 20, bottom: 0, right: 20)
        v.backgroundColor = .mainWhite
        v.customDelegate = self
        v.layer.cornerRadius = 10
        v.textColor = .grey500
        v.font = .body1
        return v
    }()

    private lazy var nextButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "다음", .large)
        v.setIsEnabled(true)
        v.addAction {
            Task {
                await self.interactor.didTapNextButton()
            }
        }
        return v
    }()

    init(interactor: ChallengeAdditionalInfoInputBusinessLogic) {
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
        self.view.addSubviews(self.navigationbar, self.headerStackView, self.challengeRuleTextView, self.nextButton)

        self.headerStackView.setCustomSpacing(8, after: self.processLabel)
        self.headerStackView.setCustomSpacing(12, after: self.headerLabel)

        self.navigationbar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationbar.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-35)
            make.bottom.equalTo(self.challengeRuleTextView.snp.top).offset(-42)
        }

        self.challengeRuleTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.lessThanOrEqualTo(self.nextButton.snp.top).offset(-100)
            make.height.equalTo(self.challengeRuleTextView.snp.width).multipliedBy(0.77)
        }

        self.nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-54)
        }
    }
}

// MARK: - Trigger

extension ChallengeAdditionalInfoInputViewController: TTTextViewDelegate, TTNavigationDetailBarDelegate {
    func textViewDidChange(text: String) {
        Task {
            await self.interactor.didEnterChallengeAdditionalInfo(commet: text)
        }
    }

    func textViewDidEndEditing(text: String) {
        Task {
            await self.interactor.didEnterChallengeAdditionalInfo(commet: text)
        }
    }

    func didTapDetailLeftButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func didTapDetailRightButton() {

    }
}

// MARK: - Trigger by Parent Scene

extension ChallengeAdditionalInfoInputViewController: ChallengeAdditionalInfoInputScene {
    
}

// MARK: - Display Logic

extension ChallengeAdditionalInfoInputViewController: ChallengeAdditionalInfoInputDisplayLogic {

}
