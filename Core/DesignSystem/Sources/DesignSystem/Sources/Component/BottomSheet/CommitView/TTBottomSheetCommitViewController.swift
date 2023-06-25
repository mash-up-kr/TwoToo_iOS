//
//  TTBottomSheetCommitViewController.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit

public final class TTBottomSheetCommitViewController: UIViewController, ScrollableViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private let buttonHeight: CGFloat = 57
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "인증하기"
        v.font = .h2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    private lazy var commitPhotoView: TTBottomSheetCommitPhotoView = {
        let v = TTBottomSheetCommitPhotoView(frame: .zero)
        v.delegate = self
        return v
    }()
    
    private lazy var commentTextView: TTTextView = {
        let v = TTTextView()
        v.configurePlaceHolder("소감을 작성해주세요.")
        v.customDelegate = self
        return v
    }()
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var commitButton: UIButton = {
        let v = UIButton()
        v.setTitle("인증 하기", for: .normal)
        v.backgroundColor = .orange
        return v
    }()
    
    private lazy var scrollSizeFitView: UIView = {
        let v = UIView()
        v.addSubviews(self.titleLabel,
                      self.commitPhotoView,
                      self.commentTextView,
                      self.commitButton)
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let v = SelfSizingScrollView()
        v.addSubview(self.scrollSizeFitView)
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.layout()
        self.addObserverKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.view.addSubviews(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
        }
        
        self.commitPhotoView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.58)
        }
        
        self.commentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.commitPhotoView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }
        
        self.commitButton.snp.makeConstraints { make in
            make.top.equalTo(self.commentTextView.snp.bottom).offset(29)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.buttonHeight)
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

extension TTBottomSheetCommitViewController {
    
    private func addObserverKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.3) {
                self.scrollSizeFitView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardHeight)
                }
                self.backScrollView.contentOffset.y = keyboardHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.scrollSizeFitView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(14)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension TTBottomSheetCommitViewController: TTTextViewDelegate {
    public func textViewDidEndEditing(text: String) {
        print("소감 작성 완료 \(text)")
    }
}

extension TTBottomSheetCommitViewController: TTBottomSheetCommitPhotoViewDelegate {
    public func didTapPlusButton() {
        // TODO: 작동 안됨. 확인 필요
    }
}

extension TTBottomSheetCommitViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}
