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
        return v
    }()
    
    /// 초대받은 사람이 닉네임 설정한 경우에만 보임
    lazy var inviteTagView: InviteTagView = {
        let v = InviteTagView()
        v.isHidden = true
        return v
    }()

    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "투투에서 사용할\n닉네임을 입력해주세요."
        v.numberOfLines = 2
        v.setLineSpacing(10) //임시
        v.font = .h1
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    lazy var nicknameTextField: TTTextField = {
        let v = TTTextField(title: "닉네임",
                            placeholder: "\(NicknameRegist.ViewModel.Nickname.maxLength)글자 이내 닉네임을 입력해주세요",
                            maxLength: NicknameRegist.ViewModel.Nickname.maxLength)
        v.returnValueAction = { nickname in
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
        
        Task {
            await self.interactor.didLoad()
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Layout
    private func setUI() {
        self.view.backgroundColor = .second02 // TODO: - 종이질감 이미지로 변경 필요
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubviews(self.navigationBar,
                              self.iconImageView,
                              self.inviteTagView,
                              self.titleLabel,
                              self.nicknameTextField,
                              self.confirmButton)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }

        self.iconImageView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.width.equalTo(97)
            make.height.equalTo(85)
            make.centerX.equalToSuperview()
        }
        
        self.inviteTagView.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom).offset(8)
            make.height.equalTo(36)
            make.centerX.equalToSuperview()

        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.inviteTagView.snp.bottom).offset(17)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
        }

        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(30)
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
