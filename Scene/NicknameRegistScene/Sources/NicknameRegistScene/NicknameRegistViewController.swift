//
//  NicknameRegistViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol NicknameRegistDisplayLogic: AnyObject {
    func displayInvitedUser(viewModel: NicknameRegist.ViewModel.Nickname)
    func displayToast(viewModel: NicknameRegist.ViewModel.Toast)
    func displayConfirmButton(backgroundColor: UIColor, isEnabled: Bool)
    func displayDisabledConfirmButton(backgroundColor: UIColor, isEnabled: Bool)
}

final class NicknameRegistViewController: UIViewController {
    var interactor: NicknameRegistBusinessLogic
    
    init(interactor: NicknameRegistBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "TwoToo", rightButtonImage: nil)
        return v
    }()
    
    lazy var iconImageView: UIImageView = {
        let v = UIImageView(.icon_nicknam_my)
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    /// 초대받은 사람이 닉네임 설정한 경우에만 보임
    lazy var inviteTagView: InviteTagView = {
        let v = InviteTagView()
        v.isHidden = true
        return v
    }()
    
    lazy var topContentView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8
        v.addArrangedSubviews(self.iconImageView, self.inviteTagView)
        return v
    }()

    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "투투에서 사용할\n닉네임을 입력해주세요."
        v.numberOfLines = 2
        v.setLineSpacing(10) 
        v.font = .h1
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    lazy var nicknameTextField: TTTextField = {
        let v = TTTextField(title: "닉네임",
                            placeholder: "\(NicknameRegist.ViewModel.Nickname.maxLength)글자 이내 닉네임을 입력해주세요",
                            maxLength: NicknameRegist.ViewModel.Nickname.maxLength)
        v.didChangeTextAction = { nickname in
            Task {
                await self.interactor.didEnterNickname(text: nickname)
            }
        }
        return v
    }()
    
    private lazy var confirmButton: UIButton = {
        let v = UIButton()
        v.setTitle("확인", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.titleLabel?.font = .h3
        v.backgroundColor = .grey400
        v.layer.cornerRadius = 20
        v.isEnabled = false
        v.addAction {
            Task {
                await self.interactor.didTapConfirmButton()
            }
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setNavigation()
        self.registKeyboardDelegate()
        Task {
            Loading.shared.showLoadingView()
            await self.interactor.didLoad()
            Loading.shared.stopLoadingView()
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Layout
    private func setUI() {
        self.view.setBackgroundDefault()
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubviews(self.navigationBar,
                              self.topContentView,
                              self.titleLabel,
                              self.nicknameTextField,
                              self.confirmButton)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        self.topContentView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.centerX.equalToSuperview()
        }
   
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topContentView.snp.bottom).offset(17)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
        }

        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(80)
        }

        self.confirmButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(57)
            make.bottom.equalTo(guide.snp.bottom)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension NicknameRegistViewController: NicknameRegistScene {
    
}

// MARK: - Display Logic

extension NicknameRegistViewController: NicknameRegistDisplayLogic {
    func displayInvitedUser(viewModel: NicknameRegist.ViewModel.Nickname) {
        self.iconImageView.image = .asset(.icon_nickname_mate)
        self.inviteTagView.configure(title: viewModel.inviteMessage)
        self.inviteTagView.isHidden = false
    }
    
    func displayToast(viewModel: NicknameRegist.ViewModel.Toast) {
        viewModel.message.unwrap { msg in
            Toast.shared.makeToast(msg)
        }
    }
    
    func displayConfirmButton(backgroundColor: UIColor, isEnabled: Bool) {
        self.confirmButton.backgroundColor = backgroundColor
        self.confirmButton.isEnabled = isEnabled
    }
    
    func displayDisabledConfirmButton(backgroundColor: UIColor, isEnabled: Bool) {
        self.confirmButton.backgroundColor = backgroundColor
        self.confirmButton.isEnabled = isEnabled
    }
    
}

// MARK: - Keyboard Setting
extension NicknameRegistViewController: KeyboardDelegate {
    func willShowKeyboard(keyboardFrame: CGRect, duration: Double) {
        UIView.animate(withDuration: 0.3) {
            self.nicknameTextField.snp.updateConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            }
            self.confirmButton.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(keyboardFrame.height - 10)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func willHideKeyboard(duration: Double) {
        UIView.animate(withDuration: 0.3) {
            self.nicknameTextField.snp.updateConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(35)
            }
            self.confirmButton.snp.updateConstraints { make in
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}
