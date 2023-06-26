//
//  PraiseSendBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

final class PraiseSendBottomSheetViewController: UIViewController, BottomSheetViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private let buttonHeight: CGFloat = 57
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.text = "오늘의 칭찬 한마디"
        v.textColor = .primary
        return v
    }()
    
    // TODO: 이것만 텍스트뷰 편집이 안된다 ㅠㅠ
    private lazy var messageTextView: TTTextView = {
        let v = TTTextView(placeHolder: "(최대 20자)칭찬 문구를 입력해주세요. \n예) 오늘도 잘해냈어, 앞으로도 파이팅!")
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
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var pushButton: UIButton = {
        let v = UIButton()
        v.setTitle("보내기", for: .normal)
        v.backgroundColor = .gray
        v.tintColor = .mainWhite
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
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    // MARK: - Method
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.layout()
        self.addObserverKeyboard()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.view.addSubviews(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
        }
        
        self.messageTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }

        self.pushButton.snp.makeConstraints { make in
            // TODO:  버튼이 위 or 아래인진 디자인 나오면 수정 필요
            make.top.equalTo(self.messageTextView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.buttonHeight)
//            make.bottom.equalToSuperview() //정상 작동 안됨
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

// MARK: - Delegate
extension PraiseSendBottomSheetViewController: TTTextViewDelegate {
    public func textViewDidEndEditing(text: String) {
        print("칭찬 문구 입력 완료 \(text)")
    }
}

extension PraiseSendBottomSheetViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}

// MARK: - Keyboard Setting
extension PraiseSendBottomSheetViewController {
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
                    make.bottom.equalToSuperview().inset(keyboardHeight + self.buttonHeight)
                }
                self.backScrollView.contentOffset.y = keyboardHeight + self.buttonHeight
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

