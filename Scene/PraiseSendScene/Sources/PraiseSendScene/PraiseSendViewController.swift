//
//  PraiseSendViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol PraiseSendDisplayLogic: AnyObject {
    func displayPraseCommentField(viewModel: PraiseSend.ViewModel.PraseCommentField)
    func displayPraiseButton(viewModel: PraiseSend.ViewModel.PraiseButton)
    func displayToast(viewModel: PraiseSend.ViewModel.Toast)
}

final class PraiseSendViewController: UIViewController, BottomSheetViewController {
    var interactor: PraiseSendBusinessLogic
    
    init(interactor: PraiseSendBusinessLogic) {
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
        v.text = "오늘의 칭찬 한마디"
        v.textColor = .primary
        return v
    }()
    
    private lazy var messageTextView: TTTextView = {
        let v = TTTextView(placeHolder: "(최대 20자)칭찬 문구를 입력해주세요.\n예) 오늘도 잘해냈어, 앞으로도 파이팅!", maxCount: 20)
        v.customDelegate = self
        return v
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.font = .body1
        v.textColor = .grey500
        v.text = "* 한번 등록한 문구는 수정이 불가해요"
        return v
    }()
    
    private lazy var pushButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "보내기", .large)
        v.didTapButton { [weak self] in
            Task {
                await self?.interactor.didTapSendButton()
            }
        }
        v.setIsEnabled(false)
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        v.addSubviews(self.titleLabel,
                      self.messageTextView,
                      self.descriptionLabel,
                      self.pushButton)
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let v = SelfSizingScrollView()
        v.addSubview(self.scrollSizeFitView)
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.backgroundColor = .second02
        
        self.view.addSubviews(self.backScrollView)
        
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
            make.top.equalTo(self.messageTextView.snp.bottom).offset(44)
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

extension PraiseSendViewController: TTTextViewDelegate {
    
    func textViewDidChange(text: String) {
        Task {
            await self.interactor.didEnterPraiseComment(comment: text)
        }
    }
}

// MARK: - Trigger by Parent Scene

extension PraiseSendViewController: PraiseSendScene {
    
    var bottomSheetViewController: UIViewController {
        return TTBottomSheetViewController(contentViewController: self)
    }
}

// MARK: - Display Logic

extension PraiseSendViewController: PraiseSendDisplayLogic {
    
    func displayPraseCommentField(viewModel: PraiseSend.ViewModel.PraseCommentField) {
        // not work
    }
    
    func displayPraiseButton(viewModel: PraiseSend.ViewModel.PraiseButton) {
        viewModel.isEnabled.unwrap {
            self.pushButton.setIsEnabled($0)
        }
    }
    
    func displayToast(viewModel: PraiseSend.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}
