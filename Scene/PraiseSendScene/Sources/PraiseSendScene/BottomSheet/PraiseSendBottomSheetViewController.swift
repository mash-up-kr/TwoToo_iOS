//
//  PraiseSendBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

protocol PraiseSendBottomSheetViewControllerDelegate: AnyObject {
    func didTapPushButton()
    func didEndEditingMessageTextView(text: String)
}

final class PraiseSendBottomSheetViewController: UIViewController, BottomSheetViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    weak var delegate: PraiseSendBottomSheetViewControllerDelegate?
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = .h2
        v.text = "오늘의 칭찬 한마디"
        v.textColor = .primary
        return v
    }()
    
    private lazy var messageTextView: TTTextView = {
        let v = TTTextView(placeHolder: "(최대 20자)칭찬 문구를 입력해주세요.\n예) 오늘도 잘해냈어, 앞으로도 파이팅!")
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
    
    private lazy var pushButton: UIButton = {
        let v = UIButton()
        v.setTitle("보내기", for: .normal)
        v.layer.cornerRadius = 20
        v.backgroundColor = .grey400
        v.setTitleColor(.white, for: .normal)
        v.addAction { [weak self] in
            self?.delegate?.didTapPushButton()
        }
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
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.attribute()
    }
    
    private func layout() {
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
            // TODO:  버튼이 위 or 아래인진 디자인 나오면 수정 필요
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
    
    private func attribute() {
        self.view.backgroundColor = .second02
    }
}

// MARK: - Delegate
extension PraiseSendBottomSheetViewController: TTTextViewDelegate {
    public func textViewDidEndEditing(text: String) {
        self.delegate?.didEndEditingMessageTextView(text: text)
    }
}

extension PraiseSendBottomSheetViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}
