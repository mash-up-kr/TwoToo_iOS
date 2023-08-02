//
//  InvitationSendViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol InvitationSendDisplayLogic: AnyObject {}

final class InvitationSendViewController: UIViewController {
    var interactor: InvitationSendBusinessLogic
    
    init(interactor: InvitationSendBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    lazy var navigationBar: TTNavigationBar = {
        let v = TTNavigationBar(title: "Twotoo", rightButtonImage: nil)
        return v
    }()
    
    lazy var contentView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 33
        v.alignment = .center
        v.addArrangedSubviews(self.titleLabel, self.descriptionLabel, self.imageView)
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textColor = .primary
        v.font = .h1
        v.text = "짝꿍에게 초대장을 보내\n투투를 시작해보세요"
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey600
        v.font = .body1
        v.text = "짝꿍이 수락하면 투투를 시작할 수 있습니다"
        return v
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_invitation)
        return v
    }()
    
    lazy var sendButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "초대장 보내기", .large)
        v.didTapButton { [weak self] in
            Task {
                await self?.interactor.didTapInvitationSendButton()
            }
        }
        v.setIsEnabled(true)
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
        self.view.addSubviews(self.navigationBar, self.contentView, self.sendButton)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        self.contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.imageView.snp.makeConstraints { make in
            make.height.equalTo(138)
            make.width.equalTo(183)
        }
        self.sendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(57)
            make.bottom.equalToSuperview().inset(54)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension InvitationSendViewController: InvitationSendScene {
    
}

// MARK: - Display Logic

extension InvitationSendViewController: InvitationSendDisplayLogic {
    
}
