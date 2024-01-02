//
//  NudgeSendViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol NudgeSendDisplayLogic: AnyObject {
    func displayTitle(viewModel: NudgeSend.ViewModel.Title)
    func displayNudgeCommentField(viewModel: NudgeSend.ViewModel.NudgeCommentField)
    func displayNudgeButton(viewModel: NudgeSend.ViewModel.NudgeButton)
    func displayToast(viewModel: NudgeSend.ViewModel.Toast)
}

final class NudgeSendViewController: UIViewController, BottomSheetViewController {
    var interactor: NudgeSendBusinessLogic
    
    init(interactor: NudgeSendBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textAlignment = .center
        v.textColor = .primary
        return v
    }()
    
    private lazy var messageTextView: TTTextView = {
        let v = TTTextView(placeHolder: "찌르기 문구를 입력해주세요.\n최대 30자까지 입력 가능", 
                           maxCount: 30)
        v.customDelegate = self
        return v
    }()
    
    
    private lazy var pushButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "보내기", .large)
        v.didTapButton { [weak self] in
            Task {
                Loading.shared.showLoadingView()
                await self?.interactor.didTapSendButton()
                Loading.shared.stopLoadingView()
            }
        }
        v.setIsEnabled(false)
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        v.addSubviews(self.titleLabel,
                      self.messageTextView,
                      self.pushButton)
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let heightRatio = UIDevice.current.deviceType == .default ? 0.8 : 0.67
        let v = SelfSizingScrollView(maxHeightRatio: heightRatio)
        v.addSubview(self.scrollSizeFitView)
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.messageTextView.becomeFirstResponder()
        self.registKeyboardDelegate()

        Task {
            await self.interactor.didLoad()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.post(name: NSNotification.Name("modal_dismissed"), object: nil)
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
        self.view.addSubview(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.centerX.equalToSuperview()
        }
        
        self.messageTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(85)
        }

        self.pushButton.snp.makeConstraints { make in
            make.top.equalTo(self.messageTextView.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(57)
            make.bottom.equalToSuperview()
        }
                
        self.scrollSizeFitView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        self.backScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Trigger

extension NudgeSendViewController: TTTextViewDelegate {
    
    func textViewDidChange(text: String) {
        Task {
            await self.interactor.didEnterNudgeComment(comment: text)
        }
    }
}

// MARK: - Trigger by Parent Scene

extension NudgeSendViewController: NudgeSendScene {
    
    var bottomSheetViewController: UIViewController {
        return TTBottomSheetViewController(contentViewController: self)
    }
}

// MARK: - Display Logic
extension NudgeSendViewController: NudgeSendDisplayLogic {
    
    func displayTitle(viewModel: NudgeSend.ViewModel.Title) {
        viewModel.text.unwrap {
            self.titleLabel.text = $0
        }
    }
    
    func displayNudgeCommentField(viewModel: NudgeSend.ViewModel.NudgeCommentField) {
        // do not work
    }
    
    func displayNudgeButton(viewModel: NudgeSend.ViewModel.NudgeButton) {
        viewModel.isEnabled.unwrap {
            self.pushButton.setIsEnabled($0)
        }
    }
    
    func displayToast(viewModel: NudgeSend.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}

extension NudgeSendViewController: KeyboardDelegate {
    func willShowKeyboard(keyboardFrame: CGRect, duration: Double) {
        let bottomOffset = keyboardFrame.height + 14
        UIView.animate(withDuration: duration) {
            self.pushButton.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(24)
                make.trailing.equalToSuperview().inset(24)
                make.height.equalTo(57)
                make.bottom.equalTo(self.view.snp.bottom).inset(bottomOffset)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func willHideKeyboard(duration: Double) {
        // 키보드 안내려가게 고정해둠
    }
}
