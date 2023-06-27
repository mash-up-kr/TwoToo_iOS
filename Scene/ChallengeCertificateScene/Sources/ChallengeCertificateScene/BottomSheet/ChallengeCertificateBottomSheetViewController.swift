//
//  ChallengeCertificateBottomSheetViewController.swift
//  
//
//  Created by Julia on 2023/06/26.
//

import UIKit
import DesignSystem

// 바텀시트 뿐만 아니라 VC에서도 필요할 것 같아 일단 여기 두긴했는데, 모델에서 수정해야 될 필요가 보입니다!
enum CommitPhotoType {
    case takePhoto
    case fetchPhotoFromAlbum
}

protocol ChallengeCertificateBottomSheetViewControllerDelegate: AnyObject {
    func didTapCommitButton()
    func didEndEditingCommentTextView(text: String)
    func didTapCommitPhotoType(type: CommitPhotoType)
}

/// 챌린지 인증 Scene에서 띄워지는 바텀시트 화면입니다.
///
/// 사용 예시
/// ```swift
/// let vc = TTBottomSheetViewController(contentViewController: ChallengeCertificateBottomSheetViewController())
/// self.present(vc, animated: true)
/// ```
///
/// delegate 패턴을 이용해 이벤트를 상위 뷰에 전달받을 수 있습니다.
///  1. 인증하기 버튼을 탭했을 때
///  2. 문구 입력이 끝났을 때
///  3. 사진 촬영 / 앨범에서 가져오기 버튼을 눌렀을 때

final class ChallengeCertificateBottomSheetViewController: UIViewController, BottomSheetViewController {
        
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    weak var delegate: ChallengeCertificateBottomSheetViewControllerDelegate?
    
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
        v.addAction { [weak self] in
            self?.delegate?.didTapCommitButton()
        }
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
        self.delegate?.didEndEditingCommentTextView(text: text)
    }
}

extension ChallengeCertificateBottomSheetViewController: ChallengeCertificateBottomSheetPhotoViewDelegate {
    public func didTapPlusButton() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "사진 촬영하기", style: .default) { [weak self] _ in
            self?.delegate?.didTapCommitPhotoType(type: .takePhoto)
        }
        let fetchPhotoFromAlbumAction = UIAlertAction(title: "앨범에서 가져오기", style: .default) { [weak self] _ in
            self?.delegate?.didTapCommitPhotoType(type: .fetchPhotoFromAlbum)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        [takePhotoAction, fetchPhotoFromAlbumAction, cancelAction].forEach {
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
