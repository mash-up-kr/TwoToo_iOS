//
//  InvitationWaitViewController.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

protocol InvitationWaitDisplayLogic: AnyObject {
    func displayShare(viewModel: InvitationWait.ViewModel.Share)
    func displayToast(viewModel: InvitationWait.ViewModel.Toast)
}

final class InvitationWaitViewController: UIViewController {
    var interactor: InvitationWaitBusinessLogic
    
    init(interactor: InvitationWaitBusinessLogic) {
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
        v.text = "짝꿍의 수락을\n기다리고 있습니다"
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()
    
    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey600
        v.font = .body1
        v.text = "새로고침을 눌러 수락을 확인해보세요 "
        return v
    }()
    
    lazy var captionLabel: UILabel = {
        let v = UILabel()
        v.textColor = .grey600
        v.font = .body2
        v.text = "* 만약 초대링크를 잃어버리셨다면, 초대장 다시보내기를 해보세요"
        v.numberOfLines = 0
        return v
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.image = .asset(.icon_waiting)
        return v
    }()
    
    lazy var refreshButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "새로고침", .large)
        v.didTapButton { [weak self] in
            Task {
                Loading.shared.showLoadingView()
                await self?.interactor.didTapRefreshButton()
                Loading.shared.stopLoadingView()
            }
        }
        v.setIsEnabled(true)
        return v
    }()
    
    lazy var resendButton: TTPrimaryButtonType = {
        let v = TTPrimaryButton.create(title: "초대장 다시 보내기", .largeLine)
        v.didTapButton { [weak self] in
            Task {
                await self?.interactor.didTapResendButton()
            }
        }
        return v
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        Task {
            await self.interactor.didLoad()
        }
    }
    
    // MARK: - Layout
    
    private func setUI() {
        self.view.setBackgroundDefault()
        
        self.view.addSubviews(self.navigationBar, self.contentView, self.captionLabel, self.refreshButton, self.resendButton)
        
        self.navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        self.contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
        }
        self.imageView.snp.makeConstraints { make in
            make.height.equalTo(128)
            make.width.equalTo(185)
        }
        self.captionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalTo(self.refreshButton.snp.top).offset(-19)
        }
        self.refreshButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(57)
            make.bottom.equalTo(self.resendButton.snp.top).offset(-16)
        }
        self.resendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(57)
            make.bottom.equalToSuperview().inset(54)
        }
    }
}

// MARK: - Trigger

// MARK: - Trigger by Parent Scene

extension InvitationWaitViewController: InvitationWaitScene {
    
}

// MARK: - Display Logic

extension InvitationWaitViewController: InvitationWaitDisplayLogic {
    
    func displayShare(viewModel: InvitationWait.ViewModel.Share) {
        viewModel.message.unwrap {
            let message: [String] = [$0]
            
            let activityVC = UIActivityViewController(
                activityItems: message,
                applicationActivities: nil
            )
            activityVC.popoverPresentationController?.sourceView = self.view
           
           self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func displayToast(viewModel: InvitationWait.ViewModel.Toast) {
        viewModel.message.unwrap {
            Toast.shared.makeToast($0)
        }
    }
}
