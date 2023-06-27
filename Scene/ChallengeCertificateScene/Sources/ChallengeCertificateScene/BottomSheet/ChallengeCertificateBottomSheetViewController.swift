//
//  ChallengeCertificateBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

final class ChallengeCertificateBottomSheetViewController: UIViewController, BottomSheetViewController {
        
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    // MARK: - UIComponent
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "인증하기"
        v.font = .h2
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    private lazy var commitPhotoView: ChallengeCertificateBottomSheetPhotoView = {
        let v = ChallengeCertificateBottomSheetPhotoView(frame: .zero)
        v.delegate = self
        return v
    }()
    
    private lazy var commentTextView: TTTextView = {
        let v = TTTextView(placeHolder: "소감을 작성해주세요.")
        v.customDelegate = self
        return v
    }()
    
    private lazy var commitButton: UIButton = {
        let v = UIButton()
        v.setTitle("인증하기", for: .normal)
        v.layer.cornerRadius = 20
        v.backgroundColor = .grey400
        v.setTitleColor(.white, for: .normal)
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
    
    // MARK: - Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.addObserverKeyboard()
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

// MARK: - Delegate
extension ChallengeCertificateBottomSheetViewController: TTTextViewDelegate {
    public func textViewDidEndEditing(text: String) {
        print("소감 작성 완료 \(text)")
    }
}

extension ChallengeCertificateBottomSheetViewController: ChallengeCertificateBottomSheetPhotoViewDelegate {
    public func didTapPlusButton() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "사진 촬영하기", style: .default)
        let getPhotoFromAlbumAction = UIAlertAction(title: "앨범에서 가져오기", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [takePhotoAction, getPhotoFromAlbumAction, cancelAction].forEach {
            alertVC.addAction($0)
        }
        self.present(alertVC, animated: true)
    }
}

extension ChallengeCertificateBottomSheetViewController: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollView.endEditing(true)
    }
}

// MARK: - Keyboard Setting
extension ChallengeCertificateBottomSheetViewController {
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
