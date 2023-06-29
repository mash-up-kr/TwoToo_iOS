//
//  NicknameRegistViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol NicknameRegistDisplayLogic: AnyObject {}

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
        let v = UIImageView()
        return v
    }()
    
    // 이미지 밑의 초대 안내 뷰 입니다. 아 이거 만들어야 될거같은데 .... ㅜㅜ
    lazy var introTagView: UIView = {
        let v = UIView()
        
        return v
    }
    
    lazy var inviteGuideView: UIView = {
        let v = UIView()
        v.isHidden = true
        return v
    }()
    
    lazy var topIntroView: UIView = {
        let v = UIView()
        v.addSubviews(iconImageView, inviteGuideView)
        return v
    }()
        
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "투투에서 사용할\n닉네임을 입력해주세요."
        v.numberOfLines = 2
        v.font = .h1
        v.textColor = .primary
        v.textAlignment = .center
        return v
    }()
    
    lazy var nicknameTextField: TTTextField = {
        let v = TTTextField(title: "닉네임",
                            placeholder: "4글자 이내 닉네임을 입력해주세요",
                            maxLength: 4)
        return v
    }()
    
    private lazy var confirmButton: TTPrimaryButton = {
        let v = TTPrimaryButton()
        v.title = "확인"
        v.addAction {
            Task { [weak self] in
                await self?.interactor.didTapConfirmButton()
            }
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setNavigation()
        
        Task { [weak self] in
            await self?.interactor.didLoad()
        }
    }
    
    private func setNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Layout
    private func setUI() {
        let guide = self.view.safeAreaLayoutGuide
        let safeAreaBottomInset = self.view.safeAreaInsets.bottom
        
        self.view.addSubviews(self.navigationBar,
                              self.topIntroView,
                              self.titleLabel,
                              self.nicknameTextField,
                              self.confirmButton)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(guide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().offset(44)
        }
        
        self.topIntroView.snp.makeConstraints { make in
            make.top.equalTo(self.navigationBar.snp.bottom)
            make.centerY.equalToSuperview()
            make.height.equalTo(130)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom)
            make.centerY.equalToSuperview()
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
            make.bottom.equalTo(safeAreaBottomInset)
        }
    }

}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension NicknameRegistViewController: NicknameRegistScene {
    
}

// MARK: - Display Logic

extension NicknameRegistViewController: NicknameRegistDisplayLogic {
    
}
