//
//  ChallengeCertificateViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import TOCropViewController
import UIKit

protocol ChallengeCertificateDisplayLogic: AnyObject {
    func displayImageAttachmentMethodPopup(viewModel: ChallengeCertificate.ViewModel.ImageAttachmentMethodPopup)
    func displayCertificateCommentField(viewModel: ChallengeCertificate.ViewModel.CertificateCommentField)
    func displayPermissionPopup(viewModel: ChallengeCertificate.ViewModel.PermissionPopup)
    func displayToast(viewModel: ChallengeCertificate.ViewModel.Toast)
    func displayImagePicker(viewModel: ChallengeCertificate.ViewModel.ImagePicker)
    func displayImageCropView(viewModel: ChallengeCertificate.ViewModel.ImageCropView)
    func displayCamera(viewModel: ChallengeCertificate.ViewModel.Camera)
    func displayCommitPhoto(viewModel: ChallengeCertificate.ViewModel.CommitPhoto)
    func displayCommitButton(viewModel: ChallengeCertificate.ViewModel.CommitButton)
}

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
    
    private lazy var imagePickerEventHandler: ImageEventHandler = {
        let handler = ImageEventHandler { [weak self] image in
            Task {
                await self?.interactor.didSelectImagePickerImage(selectedImage: image)
            }
        }
        return handler
    }()
    
    private lazy var cameraEventHandler: ImageEventHandler = {
        let handler = ImageEventHandler { [weak self] image in
            Task {
                await self?.interactor.didTakePhoto(image: image)
            }
        }
        return handler
    }()
    
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
        v.addTapAction { [weak self] in
            Task {
                await self?.interactor.didTapImageAdd()
            }
        }
        return v
    }()
    
    private lazy var commentTextView: TTTextView = {
        let v = TTTextView(placeHolder: "소감을 작성해주세요.", maxCount: 100)
        v.customDelegate = self
        return v
    }()
    
    private lazy var commitButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "인증하기", .large)
        v.didTapButton { [weak self] in
            Task {
                await self?.interactor.didTapCertificate()
            }
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
                                              UIScrollViewDelegate,
                                              KeyboardDelegate,
                                              UIImagePickerControllerDelegate,
                                              UINavigationControllerDelegate,
                                              TOCropViewControllerDelegate {
    
    func textViewDidChange(text: String) {
        Task {
            await self.interactor.didEnterCertificateComment(comment: text)
        }
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        Task {
            await self.interactor.didTakePhoto(image: image)
        }
    }
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        Task {
            await self.interactor.didCropImage(image: image)
        }
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
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
    
    func displayImageAttachmentMethodPopup(viewModel: ChallengeCertificate.ViewModel.ImageAttachmentMethodPopup) {
        viewModel.options.unwrap {
            let popup = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            popup.addAction(.init(title: $0.cameraOption, style: .default, handler: { _ in
                Task {
                    await self.interactor.didTapImageAttachmentMethodPopupCameraButton()
                }
            }))
            
            popup.addAction(.init(title: $0.albumOption, style: .default, handler: { _ in
                Task {
                    await self.interactor.didTapImageAttachmentMethodPopupGalleryButton()
                }
            }))
            
            popup.addAction(.init(title: $0.cancelOption, style: .cancel))
               
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func displayCertificateCommentField(viewModel: ChallengeCertificate.ViewModel.CertificateCommentField) {
        //
    }
    
    func displayPermissionPopup(viewModel: ChallengeCertificate.ViewModel.PermissionPopup) {
        viewModel.options.unwrap {
            let popup = UIAlertController(title: $0.title, message: $0.desc, preferredStyle: .alert)
            
            popup.addAction(.init(title: $0.acceptOption, style: .cancel))
            
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    func displayToast(viewModel: ChallengeCertificate.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
    
    func displayImagePicker(viewModel: ChallengeCertificate.ViewModel.ImagePicker) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self.imagePickerEventHandler
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func displayImageCropView(viewModel: ChallengeCertificate.ViewModel.ImageCropView) {
        viewModel.image.unwrap {
            let cropViewController = TOCropViewController(croppingStyle: .default, image: $0)
            cropViewController.aspectRatioPreset = .presetSquare
            cropViewController.aspectRatioLockEnabled = true
            cropViewController.resetAspectRatioEnabled = false
            cropViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: cropViewController)
            navigationController.modalPresentationStyle = .overCurrentContext
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func displayCamera(viewModel: ChallengeCertificate.ViewModel.Camera) {
        let cameraController = UIImagePickerController()
        cameraController.delegate = self.cameraEventHandler
        cameraController.sourceType = .camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.present(cameraController, animated: true)
        }
    }
    
    func displayCommitPhoto(viewModel: ChallengeCertificate.ViewModel.CommitPhoto) {
        viewModel.image.unwrap {
            self.commitPhotoView.updateImage($0)
        }
    }
    
    func displayCommitButton(viewModel: ChallengeCertificate.ViewModel.CommitButton) {
        viewModel.isEnabled.unwrap {
            self.commitButton.setIsEnabled($0)
        }
    }
}

// MARK: - Image Trigger

typealias ImageCompletion = (UIImage) -> Void

final class ImageEventHandler: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var completion: ImageCompletion?
    
    init(completion: @escaping ImageCompletion) {
        self.completion = completion
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.completion?(image)
        picker.dismiss(animated: true, completion: nil)
    }
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
