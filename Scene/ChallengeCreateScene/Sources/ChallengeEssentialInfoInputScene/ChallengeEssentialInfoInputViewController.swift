//
//  ChallengeEssentialInfoInputViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import DesignSystem
import Util

protocol ChallengeEssentialInfoInputDisplayLogic: AnyObject {
    /// NextButton enable 한다
    func displaySetEnableNextButton(viewModel: ChallengeEssentialInfoInput.ViewModel.NextButton)
    /// 캘린더 화면 보여준다.
    func displayCalendar(viewModel: ChallengeEssentialInfoInput.ViewModel.ChallengeDate)
    /// 챌린지 명을 업데이트 시켜준다.
    func displayChallengeName(viewModel: ChallengeEssentialInfoInput.ViewModel.Name)
}

final class ChallengeEssentialInfoInputViewController: UIViewController {
    var interactor: ChallengeEssentialInfoInputBusinessLogic

    // MARK: - UI
    
    private lazy var headerStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()

    private lazy var processLabel: UILabel = {
        let v = UILabel()
        v.text = "1/3"
        v.font = .preferredFont(forTextStyle: .title2)
        v.textColor = .primary
        v.font = .h1
        return v
    }()

    private lazy var headerLabel: UILabel = {
        let v = UILabel()
        v.text = "챌린지 정보를 작성해주세요"
        v.font = .preferredFont(forTextStyle: .title2)
        v.font = .h2
        v.textColor = .primary
        return v
    }()

    private lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.text = "시작일을 기준으로 22일동안 진행되는 챌린지입니다"
        v.font = .preferredFont(forTextStyle: .body)
        v.textColor = .grey600
        v.font = .body2
        return v
    }()

    private lazy var challengeRecommendButton: UIButton = {
        let v = UIButton()
        v.setTitle("챌린지추천 >", for: .normal)
        v.backgroundColor = .primary
        v.titleLabel?.font = .body2
        v.layer.cornerRadius = 10
        v.contentEdgeInsets = .init(top: 8, left: 11, bottom: 8, right: 11)
        v.addTapAction { [weak self] in
            Task {
                await self?.interactor.didTapChallengeRecommendationButton()
            }
        }
        return v
    }()

    private lazy var startDateStackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 8
        v.axis = .vertical
        return v
    }()

    private lazy var startDateLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .body1
        v.text = "시작일"
        return v
    }()

    private lazy var startDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.backgroundColor = .mainWhite
        v.datePickerMode = .date
        v.locale = Locale(identifier: "ko_KR")
        v.calendar.locale = Locale(identifier: "ko_KR")
        v.addTarget(self, action: #selector(didTapStartDate), for: .valueChanged)
        return v
    }()

    private lazy var endDateStackView: UIStackView = {
        let v = UIStackView()
        v.spacing = 8
        v.axis = .vertical
        v.alignment = .leading
        return v
    }()

    private lazy var endDatePicker: UIDatePicker = {
        let v = UIDatePicker()
        v.backgroundColor = .mainWhite
        v.datePickerMode = .date
        v.locale = Locale(identifier: "ko_KR")
        v.calendar.locale = Locale(identifier: "ko_KR")
        v.addTarget(self, action: #selector(didTapEndDate), for: .valueChanged)
        return v
    }()

    private lazy var endDateLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .body1
        v.text = "종료일"
        return v
    }()

    private lazy var nextButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "다음", .large)
        v.addAction {
            Task {
                await self.interactor.didTapNextButton()
            }
        }
        return v
    }()

    private lazy var challengeNameTextField: TTTextField = {
        let v = TTTextField(title: "챌린지 이름", placeholder: "챌린지 이름을 입력해주세요", maxLength: 20)
        return v
    }()
    
    init(interactor: ChallengeEssentialInfoInputBusinessLogic) {
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

        Task {
            await self.interactor.didLoad()
        }
        
        self.challengeNameTextField.didChangeTextAction = { text in
            Task {
                await self.interactor.didEnterChallengeNameComment(comment: text)
            }
        }
        
        self.challengeNameTextField.returnValueAction = { text in
            Task {
                await self.interactor.didEnterChallengeNameComment(comment: text)
            }
        }
    }
    
    @objc private func didTapStartDate(_ sender: UIDatePicker) {
        Task {
            await self.interactor.didTapStartDate(startDate: startDatePicker.date)
        }
    }

    @objc private func didTapEndDate(_ sender: UIDatePicker) {
        Task {
            await self.interactor.didTapEndDate(endDate: endDatePicker.date)
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02

        self.headerStackView.addArrangedSubviews(self.processLabel, self.headerLabel, self.captionLabel)
        self.startDateStackView.addArrangedSubviews(self.startDateLabel, self.startDatePicker)
        self.endDateStackView.addArrangedSubviews(self.endDateLabel, self.endDatePicker)

        self.view.addSubviews(self.headerStackView, self.challengeNameTextField, self.challengeRecommendButton, self.startDateStackView, self.endDateStackView, self.nextButton)

        self.headerStackView.setCustomSpacing(8, after: self.processLabel)
        self.headerStackView.setCustomSpacing(12, after: self.headerLabel)

        self.headerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(2)
            make.leading.equalToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-35)
            make.bottom.equalTo(self.challengeNameTextField.snp.top).offset(-19)
        }

        self.challengeNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(70)
            make.bottom.equalTo(self.challengeRecommendButton.snp.top).offset(-20)
        }

        self.challengeRecommendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
        }
        
        self.startDateStackView.snp.makeConstraints { make in
            make.top.equalTo(self.challengeRecommendButton.snp.bottom).offset(43)
            make.leading.equalTo(self.challengeRecommendButton.snp.leading)
            make.width.equalTo(UIScreen.main.bounds.width * 0.27)
        }

        self.endDateStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.startDateStackView.snp.trailing).offset(36)
            make.top.equalTo(self.startDateStackView.snp.top)
            make.width.equalTo(UIScreen.main.bounds.width * 0.27)
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

extension ChallengeEssentialInfoInputViewController: ChallengeEssentialInfoInputScene {
    
}

// MARK: - Display Logic

extension ChallengeEssentialInfoInputViewController: ChallengeEssentialInfoInputDisplayLogic {
    func displayCalendar(viewModel: ChallengeEssentialInfoInput.ViewModel.ChallengeDate) {
        
        viewModel.startDate.unwrap { startDate in
            self.startDatePicker.date = startDate
        }
        
        viewModel.endDate.unwrap { endDate in
            self.endDatePicker.date = endDate
        }
    }

    func displaySetEnableNextButton(viewModel: ChallengeEssentialInfoInput.ViewModel.NextButton) {
        viewModel.isEnabled.unwrap { enable in
            self.nextButton.setIsEnabled(enable)
        }
    }

    func displayChallengeName(viewModel: ChallengeEssentialInfoInput.ViewModel.Name) {
        viewModel.text.unwrap {
            self.challengeNameTextField.setTextFieldValue(text: $0)
        }
    }
}
