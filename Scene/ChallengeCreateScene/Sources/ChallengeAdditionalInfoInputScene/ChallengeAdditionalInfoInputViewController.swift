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

final class ChallengeAdditionalInfoInputViewController: UIViewController, UITextViewDelegate {
    var interactor: ChallengeAdditionalInfoInputBusinessLogic

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

    private lazy var challengeRuleTextView: UITextView = {
        let v = UITextView()
        v.backgroundColor = .white
        v.delegate = self
        v.layer.cornerRadius = 10
        v.text = "구체적인 챌린지 룰, 벌칙등을 입력해주세요"
        v.textColor = .grey500
        v.font = .body1
        v.textContainerInset = .init(top: 21, left: 20, bottom: 0, right: 20)

        return v
    }()

    private lazy var nextButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "다음", .large)
        v.setIsEnabled(true)
        return v
    }()

    init(interactor: ChallengeAdditionalInfoInputBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02

        self.headerStackView.addArrangedSubviews(self.processLabel, self.headerLabel, self.captionLabel)
        self.view.addSubviews(self.headerStackView, self.challengeRuleTextView, self.nextButton)

        self.headerStackView.setCustomSpacing(8, after: self.processLabel)
        self.headerStackView.setCustomSpacing(12, after: self.headerLabel)

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(2)
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

// MARK: - Trigger by Parent Scene

extension ChallengeAdditionalInfoInputViewController: ChallengeAdditionalInfoInputScene {
    
}

// MARK: - Display Logic

extension ChallengeAdditionalInfoInputViewController: ChallengeAdditionalInfoInputDisplayLogic {
    func textViewDidBeginEditing(_ textView: UITextView) {
        challengeRuleTextView.text = nil
        challengeRuleTextView.textColor = .lightGray
    }

    func textViewDidEndEditing(_ textView: UITextView) {
       if challengeRuleTextView.text.isEmpty {
           challengeRuleTextView.text = "구체적인 챌린지 룰, 벌칙등을 입력해주세요"
           challengeRuleTextView.textColor = UIColor.lightGray
       }

        if challengeRuleTextView.text.count > 100 {
        // 글자수 제한에 걸리면 마지막 글자를 삭제함.
            challengeRuleTextView.text.removeLast()
        }
   }

    /// 최대 길이 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        let newLength = challengeRuleTextView.text.count - range.length + text.count
        let maxCount = 100
        // 글자수가 초과 된 경우 or 초과되지 않은 경우
        if newLength > maxCount {
            let overflow = newLength - maxCount //초과된 글자수
            if text.count < overflow {
                return true
            }
            let index = text.index(text.endIndex, offsetBy: -overflow)
            let newText = text[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }

            textView.replace(textRange, withText: String(newText))

            return false
        }
        return true
    }
}
