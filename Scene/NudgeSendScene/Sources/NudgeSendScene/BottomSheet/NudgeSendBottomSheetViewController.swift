//
//  NudgeSendBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

protocol NudgeSendBottomSheetViewControllerDelegate: AnyObject {
    func didTapPushButton()
    func didEndEditingMessageTextView(text: String)
}

public final class NudgeSendBottomSheetViewController: UIViewController, BottomSheetViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private let buttonHeight: CGFloat = 57
    
    weak var delegate: NudgeSendBottomSheetViewControllerDelegate?
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.textAlignment = .center
        v.text = "찌르기 문구 보내기 (5/5)"
        v.textColor = .primary
        return v
    }()
    
    private lazy var messageTextView: TTTextView = {
        let v = TTTextView(placeHolder: "찌르기 문구를 입력해주세요.\n최대 30자까지 입력 가능")
        v.customDelegate = self
        return v
    }()
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var pushButton: UIButton = {
        let v = UIButton()
        v.setTitle("보내기", for: .normal)
        v.backgroundColor = .gray
        v.tintColor = .mainWhite
        v.addAction { [weak self] in
            self?.delegate?.didTapPushButton()
        }
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
        let v = SelfSizingScrollView()
        v.addSubview(self.scrollSizeFitView)
        v.delegate = self
        v.addTapAction { [weak self] in
            self?.view.endEditing(true)
        }
        return v
    }()
    
    // MARK: - Method
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.attribute()
    }
    
    private func layout() {
        self.view.addSubview(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        self.messageTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(85)
        }

        self.pushButton.snp.makeConstraints { make in
            // TODO:  버튼이 위 or 아래인진 디자인 나오면 수정 필요
            make.top.equalTo(self.messageTextView.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.buttonHeight)
            make.bottom.equalToSuperview() //바텀에 정상적으로 붙지 않음
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
    
    private func attribute() {
        self.view.backgroundColor = .second02
    }
    
    /// 찌르기 횟수를 가져와 title을 구성합니다.
    public func configureNudgeCount(_ count: Int) {
        self.titleLabel.text = "찌르기 문구 보내기 (\(count)/5)"
    }
    
}

// MARK: - Delegate
extension NudgeSendBottomSheetViewController: TTTextViewDelegate {
    public func textViewDidEndEditing(text: String) {
        self.delegate?.didEndEditingMessageTextView(text: text)
    }
}

extension NudgeSendBottomSheetViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}
