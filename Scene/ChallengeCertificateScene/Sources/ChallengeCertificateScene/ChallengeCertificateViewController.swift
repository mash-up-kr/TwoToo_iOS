//
//  ChallengeCertificateViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChallengeCertificateDisplayLogic: AnyObject {}

final class ChallengeCertificateViewController: UIViewController, BottomSheetViewController {
    var interactor: ChallengeCertificateBusinessLogic
    
    init(interactor: ChallengeCertificateBusinessLogic) {
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
        v.text = "인증하기"
        v.font = .h2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    private lazy var commitPhotoView: ChallengeCertificatePhotoView = {
        let v = ChallengeCertificatePhotoView(frame: .zero)
        v.delegate = self
        return v
    }()
    
    private lazy var commentTextView: TTTextView = {
        let v = TTTextView(placeHolder: "소감을 작성해주세요.")
        v.customDelegate = self
        return v
    }()
    
    private lazy var commitButton: UIButton = {
        let v = TTPrimaryButton.create(title: "인증하기", .large)
        v.didTapButton { [weak self] in
            
        }
        v.setIsEnabled(false)
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let v = SelfSizingScrollView()
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registKeyboardDelegate()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.addSubviews(self.backScrollView)
        self.backScrollView.addSubview(self.scrollSizeFitView)
        self.scrollSizeFitView.addSubviews(
            self.titleLabel,
            self.commitPhotoView,
            self.commentTextView,
            self.commitButton
        )
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
        }
        
        self.commitPhotoView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.commitPhotoView.snp.width)
        }
        
        self.commentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.commitPhotoView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }
        
        self.commitButton.snp.makeConstraints { make in
            make.top.equalTo(self.commentTextView.snp.bottom).offset(29)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(57)
            make.bottom.equalToSuperview()
        }
        
        self.scrollSizeFitView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(24)
            make.width.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        self.backScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Trigger

extension ChallengeCertificateViewController: TTTextViewDelegate,
                                              ChallengeCertificatePhotoViewDelegate,
                                              UIScrollViewDelegate,
                                              KeyboardDelegate {
    
    func textViewDidChange(text: String) {
        
    }
    
    func didTapPlusButton() {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
    
    func willShowKeyboard(keyboardFrame: CGRect, duration: Double) {
        UIView.animate(withDuration: duration) {
            self.scrollSizeFitView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardFrame.height)
            }
            self.backScrollView.contentOffset.y = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    func willHideKeyboard(duration: Double) {
        UIView.animate(withDuration: duration) {
            self.scrollSizeFitView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - Trigger by Parent Scene

extension ChallengeCertificateViewController: ChallengeCertificateScene {
    
    var bottomSheetViewController: UIViewController {
        return TTBottomSheetViewController(contentViewController: self)
    }
}

// MARK: - Display Logic

extension ChallengeCertificateViewController: ChallengeCertificateDisplayLogic {
    
}
