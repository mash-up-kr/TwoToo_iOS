//
//  ChangeNicknameViewController.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol ChangeNicknameViewControllerDisplayLogic: AnyObject {
    func displaySetEnableNextButton(viewModel: ChangeNickname.ViewModel.ChangeButton)
    func displayToast(viewModel: ChangeNickname.ViewModel.Toast)
}

final class ChangeNicknameViewController: UIViewController {
    var interactor: ChangeNicknameBusinessLogic
    
    init(interactor: ChangeNicknameBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var navigationbar: TTNavigationDetailBar = {
        let v = TTNavigationDetailBar()
        v.configure(title: "", leftButtonImage: .asset(.icon_back), rightButtonImage: nil)
        v.delegate = self
        return v
    }()
    
    private lazy var mainIconImageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_nicknam_my)
        return v
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.setLineSpacing(11)
        v.text = "변경할 닉네임을\n입력해주세요"
        v.textAlignment = .center
        v.font = .h1
        v.textColor = .primary
        v.numberOfLines = 0
        return v
    }()
    
    private lazy var nicknameTextField: TTTextField = {
        let v = TTTextField(title: "닉네임", placeholder: "4글자 이내 닉네임을 입력해주세요", maxLength: 4)
        return v
    }()
    
    private lazy var changeButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "변경", .large)
        v.setIsEnabled(false)
        v.addAction { [weak self] in
            Task {
                Loading.shared.showLoadingView()
                await self?.interactor.didTapChangeButton()
                Loading.shared.stopLoadingView()
            }
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registKeyboardDelegate()
        
        self.nicknameTextField.didChangeTextAction = { text in
            Task {
                await self.interactor.didEnterMyNickname(name: text)
            }
        }
        
        self.nicknameTextField.returnValueAction = { text in
            Task {
                await self.interactor.didEnterMyNickname(name: text)
                await self.interactor.didTapChangeButton()
            }
        }
    }
    
    @objc private func didTapView() {
        self.view.endEditing(true)
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapGesture)
        self.view.addSubviews(
            self.navigationbar, self.mainIconImageView, self.descriptionLabel,
            self.nicknameTextField, self.changeButton)
        
        self.navigationbar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.mainIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.navigationbar.snp.bottom).offset(2)
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-4)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.nicknameTextField.snp.top).offset(-40)
        }
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.changeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
}

// MARK: - Trigger

extension ChangeNicknameViewController: TTNavigationDetailBarDelegate {
    func didTapDetailLeftButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapDetailRightButton() {
        
    }
}

// MARK: - Trigger by Parent Scene

extension ChangeNicknameViewController: ChangeNicknameScene {
    
}

// MARK: - Display Logic

extension ChangeNicknameViewController: ChangeNicknameViewControllerDisplayLogic {
    
    func displaySetEnableNextButton(viewModel: ChangeNickname.ViewModel.ChangeButton) {
        viewModel.isEnabled.unwrap {
            self.changeButton.setIsEnabled($0)
        }
    }
    
    func displayToast(viewModel: ChangeNickname.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}

// MARK: - Keyboard Setting

extension ChangeNicknameViewController: KeyboardDelegate {
    func willShowKeyboard(keyboardFrame: CGRect, duration: Double) {
        
        UIView.animate(withDuration: duration) {
            self.changeButton.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(keyboardFrame.height + 20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func willHideKeyboard(duration: Double) {
        UIView.animate(withDuration: duration) {
            self.changeButton.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            }
            self.view.layoutIfNeeded()
        }
    }
}
